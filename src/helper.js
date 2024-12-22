const axios = require("axios");
const cheerio = require("cheerio");
const qs = require("qs");
const config = require("./config");

const baseUrl = config.BASE_URL;

async function getNonce() {
  try {
    const url = `${baseUrl}/wp-admin/admin-ajax.php`;
    const payload = {
      action: "aa1208d27f29ca340c92c66d1926f13f",
    };
    const response = await axios.post(url, qs.stringify(payload), {
      headers: {
        Origin: baseUrl,
        Referer: baseUrl,
        Cookie: process.env.COOKIE,
        "User-Agent": process.env.USER_AGENT,
        "X-Requested-With": process.env.X_REQUEST_WITH,
        "Content-Type": process.env.CONTENT_TYPE,
      },
    });
    if (response.data && response.data.dat) {
      return response.data.dat;
    } else {
      return null;
    }
  } catch (error) {
    console.error(error);
    return null;
  }
}

async function getUrlAjax(content, nonce) {
  try {
    const decodedContent = JSON.parse(atob(content));
    const payload = {
      ...decodedContent,
      nonce,
      action: "2a3505c93b0035d3f455df82bf976b84",
    };

    const url = `${baseUrl}/wp-admin/admin-ajax.php`;
    const response = await axios.post(url, qs.stringify(payload), {
      headers: {
        Origin: baseUrl,
        Referer: baseUrl,
        Cookie: process.env.COOKIE,
        "User-Agent": process.env.USER_AGENT,
        "X-Requested-With": process.env.X_REQUEST_WITH,
        "Content-Type": process.env.CONTENT_TYPE,
      },
    });

    return atob(response.data.data);
  } catch (error) {
    console.error(error);
    return null;
  }
}

function notFoundQualityHandler(res, num) {
  const $ = cheerio.load(res);
  const links = [];
  const element = $(".download");
  let response;
  element.filter(function () {
    if ($(this).find(".anime-box > .anime-title").eq(0).text() === "") {
      $(this)
        .find(".yondarkness-box")
        .filter(function () {
          const quality = $(this)
            .find(".yondarkness-title")
            .eq(num)
            .text()
            .split("[")[1]
            .split("]")[0];
          const size = $(this)
            .find(".yondarkness-title")
            .eq(num)
            .text()
            .split("]")[1]
            .split("[")[1];
          $(this)
            .find(".yondarkness-item")
            .eq(num)
            .find("a")
            .each((_, el) => {
              const _list = {
                host: $(el).text(),
                link: $(el).attr("href"),
              };
              links.push(_list);
              response = { quality, size, links };
            });
        });
    } else {
      $(this)
        .find(".anime-box")
        .filter(function () {
          const quality = $(this)
            .find(".anime-title")
            .eq(num)
            .text()
            .split("[")[1]
            .split("]")[0];
          const size = $(this)
            .find(".anime-title")
            .eq(num)
            .text()
            .split("]")[1]
            .split("[")[1];
          $(this)
            .find(".anime-item")
            .eq(num)
            .find("a")
            .each((_, el) => {
              const _list = {
                host: $(el).text(),
                link: $(el).attr("href"),
              };
              links.push(_list);
              response = { quality, size, links };
            });
        });
    }
  });
  return response;
}

function epsQualityFunction(num, res) {
  const $ = cheerio.load(res);
  const element = $(".download");
  const links = [];
  let response;
  element.find("ul").filter(function () {
    const quality = $(this).find("li").eq(num).find("strong").text();
    const size = $(this).find("li").eq(num).find("i").text();
    $(this)
      .find("li")
      .eq(num)
      .find("a")
      .each(function () {
        const _list = {
          host: $(this).text(),
          link: $(this).attr("href"),
        };
        links.push(_list);
        response = { quality, size, links };
      });
  });
  return response;
}

function batchQualityFunction(num, res) {
  const $ = cheerio.load(res);
  const element = $(".batchlink");
  const links = [];
  let response;
  element.find("ul").filter(function () {
    const quality = $(this).find("li").eq(num).find("strong").text().trim();
    const size = $(this).find("li").eq(num).find("i").text().trim();
    $(this)
      .find("li")
      .eq(num)
      .find("a")
      .each(function () {
        const _list = {
          host: $(this).text().trim(),
          link: $(this).attr("href"),
        };
        links.push(_list);
        response = { quality, size, links };
      });
  });
  return response;
}

module.exports = {
  getNonce,
  getUrlAjax,
  notFoundQualityHandler,
  epsQualityFunction,
  batchQualityFunction,
};
