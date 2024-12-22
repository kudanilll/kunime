const axios = require("axios");
const cheerio = require("cheerio");
const {
  getNonce,
  getUrlAjax,
  notFoundQualityHandler,
  epsQualityFunction,
  batchQualityFunction,
} = require("./helper");
const config = require("./config");

const baseUrl = config.BASE_URL;

function parseEpisodeNumber(episodeText) {
  return parseInt(episodeText.replace("Episode ", ""), 10) || 0;
}

function extractEndpoint(href) {
  return href?.replace(`${baseUrl}/anime/`, "").replace("/", "") || "";
}

function extractGenres(text) {
  return text.match(/[A-Z][a-z]+/g) || [];
}

function extractStatus(text) {
  return text.match(/Ongoing|Completed/)?.[0] || null;
}

function extractRating(text) {
  const ratingMatch = text.match(/\d+(\.\d+)?/);
  return ratingMatch ? parseFloat(ratingMatch[0]) : null;
}

async function getOngoingAnime(req, res) {
  const { page } = req.params;
  const url =
    page === 1
      ? `${baseUrl}/ongoing-anime`
      : `${baseUrl}/ongoing-anime/page/${page}`;

  try {
    const response = await axios.get(url);

    if (response.status !== 200) {
      return res.status(response.status).json({
        success: false,
        message: `Unexpected status: ${response.status}`,
        content: [],
      });
    }

    const $ = cheerio.load(response.data);
    const content = [];

    $(".rapi ul > li").each((_, el) => {
      content.push({
        title: $(el).find("h2").text().trim(),
        thumb: $(el).find("img").attr("src"),
        episode: parseEpisodeNumber($(el).find(".epz").text().trim()),
        updated_on: $(el).find(".newnime").text().trim(),
        updated_day: $(el).find(".epztipe").text().trim(),
        endpoint: extractEndpoint($(el).find(".thumb > a").attr("href")),
      });
    });

    return res.status(200).json({
      success: true,
      message: "success",
      currentPage: parseInt(page, 10),
      content,
    });
  } catch (error) {
    console.error("Error in getOngoingAnime:", error);
    return res.status(500).json({
      success: false,
      message: error.message,
      content: [],
    });
  }
}

async function getCompletedAnime(req, res) {
  const { page } = req.params;
  const url =
    page === 1
      ? `${baseUrl}/complete-anime`
      : `${baseUrl}/complete-anime/page/${page}`;

  try {
    const response = await axios.get(url);

    if (response.status !== 200) {
      return res.status(response.status).json({
        success: false,
        message: `Unexpected status: ${response.status}`,
        content: [],
      });
    }

    const $ = cheerio.load(response.data);
    const content = [];

    $(".rapi ul > li").each((_, el) => {
      content.push({
        title: $(el).find("h2").text().trim(),
        thumb: $(el).find("img").attr("src"),
        total_episode: parseEpisodeNumber($(el).find(".epz").text().trim()),
        updated_on: $(el).find(".newnime").text().trim(),
        rating: parseFloat($(el).find(".epztipe").text().trim()) || null,
        endpoint: extractEndpoint($(el).find(".thumb > a").attr("href")),
      });
    });

    return res.status(200).json({
      success: true,
      message: "success",
      currentPage: parseInt(page, 10),
      content,
    });
  } catch (error) {
    console.error("Error in getCompletedAnime:", error);
    return res.status(500).json({
      success: false,
      message: error.message,
      content: [],
    });
  }
}

async function searchAnime(req, res) {
  const { query } = req.params;

  try {
    const response = await axios.get(`${baseUrl}/?s=${query}&post_type=anime`);

    if (response.status !== 200) {
      return res.status(response.status).json({
        success: false,
        message: `Unexpected status: ${response.status}`,
        content: [],
      });
    }

    const $ = cheerio.load(response.data);
    const content = $(".page li")
      .map((_, el) => {
        const $el = $(el);
        const setText = $el.find(".set").text();

        return {
          title: $el.find("h2 > a").text().trim(),
          thumb: $el.find("img").attr("src"),
          genres: extractGenres(setText),
          status: extractStatus(setText),
          rating: extractRating(setText),
          endpoint: extractEndpoint($el.find("h2 > a").attr("href")),
        };
      })
      .get();

    return res.status(200).json({
      success: true,
      message: "success",
      query,
      content,
    });
  } catch (error) {
    console.error("Error in searchAnime:", error);
    return res.status(500).json({
      success: false,
      message: error.message,
      content: [],
    });
  }
}

async function getAnimeList(_, res) {
  try {
    const response = await axios.get(`${baseUrl}/anime-list`);

    if (response.status !== 200) {
      return res.status(response.status).json({
        success: false,
        message: `Unexpected status: ${response.status}`,
        content: [],
      });
    }

    const $ = cheerio.load(response.data);
    const animeElements = $(".jdlbar");

    const content = animeElements
      .map((_, el) => {
        const title = $(el).find("a").text().trim() || null;
        const endpoint = $(el)
          .find("a")
          .attr("href")
          .replace(`${baseUrl}/anime/`, "");

        return { title, endpoint };
      })
      .get();

    return res.status(200).json({
      success: true,
      message: "success",
      content,
    });
  } catch (error) {
    console.error("Error in getAnimeList:", error);
    return res.status(500).json({
      success: false,
      message: error.message,
      content: [],
    });
  }
}

async function getAnimeDetail(req, res) {
  const endpoint = req.params.endpoint;
  try {
    const response = await axios.get(`${baseUrl}/anime/${endpoint}`);

    if (response.status !== 200) {
      return res.status(response.status).json({
        success: false,
        message: `Unexpected status: ${response.status}`,
        content: [],
      });
    }

    const $ = cheerio.load(response.data);

    const title = $(".jdlrx > h1").text().trim();
    const thumb = $(".fotoanime img").attr("src");
    const sinopsis = $(".fotoanime .sinopc p")
      .map((_, el) => $(el).text().trim())
      .get();
    const detail = $(".fotoanime .infozingle p")
      .map((_, el) => $(el).text().trim())
      .get();

    const episodeElements = $(".episodelist li");
    const episodeList = episodeElements
      .map((_, el) => ({
        title: $(el).find("span > a").text().trim(),
        endpoint: $(el)
          .find("span > a")
          .attr("href")
          .replace(new RegExp(`${baseUrl}/(episode|batch|lengkap)/`, "g"), "")
          .replace("/", ""),
        date: $(el).find(".zeebr").text().trim().replace(",", " "),
      }))
      .get();

    const animeDetail = {
      title,
      thumb,
      sinopsis,
      detail,
    };

    return res.status(200).json({
      success: true,
      message: "success",
      endpoint,
      content: { anime_detail: animeDetail, episode_list: episodeList },
    });
  } catch (error) {
    console.error("Error in getAnimeDetail:", error);
    return res.status(500).json({
      success: false,
      message: error.message,
      content: [],
    });
  }
}

async function getAnimeEpisode(req, res) {
  const endpoint = req.params.endpoint;
  const url = `${baseUrl}/episode/${endpoint}`;

  try {
    const response = await axios.get(url);

    if (response.status !== 200) {
      return res.status(response.status).json({
        success: false,
        message: `Unexpected status: ${response.status}`,
        content: [],
      });
    }

    const $ = cheerio.load(response.data);
    const title = $(".venutama > h1").text().trim();

    if (!title) {
      return res.status(404).json({
        success: false,
        message: "Episode not found",
        content: [],
      });
    }

    const episodeData = {
      id: url.replace(`${baseUrl}/episode/`, ""),
      title,
      base_url: url,
      stream_link: $("#embed_holder .responsive-embed-stream iframe").attr(
        "src"
      ),
      list_episode: [],
    };

    // Extract episode list
    episodeData.list_episode = $("#selectcog option")
      .map((_, el) => ({
        title: $(el).text().trim(),
        endpoint: $(el).attr("value").replace(`${baseUrl}/episode/`, ""),
      }))
      .get()
      .slice(1);

    // Extract streaming links
    const extractStreamingLinks = (selector) =>
      $(selector)
        .find("li")
        .map((_, el) => ({
          host: $(el).text().trim(),
          // i dont know why error :(
          // link: `/api/v1/streaming/${$(el).find("a").data("content")}`,
          link: `https://nya-otakudesu.vercel.app/api/v1/streaming/${$(el)
            .find("a")
            .data("content")}`,
        }))
        .get();

    episodeData.streaming = {
      low_quality: {
        quality: "360p",
        links: extractStreamingLinks(".mirrorstream > .m360p"),
      },
      medium_quality: {
        quality: "480p",
        links: extractStreamingLinks(".mirrorstream > .m480p"),
      },
      high_quality: {
        quality: "720p",
        links: extractStreamingLinks(".mirrorstream > .m720p"),
      },
    };

    // Extract download links (assuming these functions are defined elsewhere)
    const [lowQuality, mediumQuality, highQuality] = [
      notFoundQualityHandler?.(response.data, 0) ||
        epsQualityFunction(0, response.data),
      notFoundQualityHandler?.(response.data, 1) ||
        epsQualityFunction(1, response.data),
      notFoundQualityHandler?.(response.data, 2) ||
        epsQualityFunction(2, response.data),
    ];

    episodeData.download = {
      low_quality: lowQuality,
      medium_quality: mediumQuality,
      high_quality: highQuality,
    };

    return res.status(200).json({
      success: true,
      message: "success",
      content: episodeData,
    });
  } catch (error) {
    console.error("Error in getAnimeEpisode:", error);
    return res.status(500).json({
      success: false,
      message: error.message,
      content: [],
    });
  }
}

async function getAnimeBatch(req, res) {
  const { endpoint } = req.params;
  const url = `${baseUrl}/batch/${endpoint}`;

  try {
    const response = await axios.get(url);

    if (response.status !== 200) {
      return res.status(response.status).json({
        success: false,
        message: `Unexpected status: ${response.status}`,
        content: null,
      });
    }

    const $ = cheerio.load(response.data);

    const content = {
      title: $(".batchlink > h4").text().trim(),
      base_url: url,
      download: {
        low: batchQualityFunction(0, response.data),
        medium: batchQualityFunction(1, response.data),
        high: batchQualityFunction(2, response.data),
      },
    };

    return res.status(200).json({
      success: true,
      message: "success",
      content,
    });
  } catch (error) {
    console.error("Error in getAnimeBatch:", error);
    return res.status(500).json({
      success: false,
      message: error.message,
      content: null,
    });
  }
}

async function getGenreList(_, res) {
  try {
    const response = await axios.get(`${baseUrl}/genre-list/`);

    if (response.status !== 200) {
      return res.status(response.status).json({
        success: false,
        message: `Unexpected status: ${response.status}`,
        content: [],
      });
    }

    const $ = cheerio.load(response.data);
    const content = [];

    $(".genres")
      .find("a")
      .each((_, el) => {
        const genre = $(el).text().trim();
        const endpoint =
          $(el).attr("href")?.replace("/genres/", "").replace("/", "") || "";

        content.push({ genre, endpoint });
      });

    return res.status(200).json({
      success: true,
      message: "success",
      content,
    });
  } catch (error) {
    console.error("Error in getGenreList:", error);
    return res.status(500).json({
      success: false,
      message: error.message,
      content: [],
    });
  }
}

async function getGenrePage(req, res) {
  const { genre, page } = req.params;
  const url =
    page === 1
      ? `${baseUrl}/genres/${genre}`
      : `${baseUrl}/genres/${genre}/page/${page}`;

  try {
    const response = await axios.get(url);

    if (response.status !== 200) {
      return res.status(response.status).json({
        success: false,
        message: `Unexpected status: ${response.status}`,
        content: [],
      });
    }

    const $ = cheerio.load(response.data);
    const content = [];

    $(".col-anime-con").each((_, el) => {
      const animeData = {
        title: $(el).find(".col-anime-title > a").text().trim(),
        endpoint:
          $(el)
            .find(".col-anime-title > a")
            .attr("href")
            ?.replace(`${baseUrl}/anime/`, "") || "",
        studio: $(el).find(".col-anime-studio").text().trim(),
        episode:
          parseInt(
            $(el).find(".col-anime-eps").text().trim().replace("Episode ", ""),
            10
          ) || 0,
        rating:
          parseFloat($(el).find(".col-anime-rating").text().trim()) || null,
        thumb: $(el).find(".col-anime-cover > img").attr("src"),
        season: $(el).find(".col-anime-date").text().trim(),
        sinopsis: $(el).find(".col-synopsis").text().trim(),
        genre: $(el).find(".col-anime-genre").text().trim().split(", "),
      };

      content.push(animeData);
    });

    return res.status(200).json({
      success: true,
      message: "success",
      content,
    });
  } catch (error) {
    console.error("Error in getGenrePage:", error);
    res.status(500).json({
      success: false,
      message: error.message,
      content: [],
    });
  }
}

async function getStreaming(req, res) {
  try {
    const nonce = await getNonce();
    const htmlStreaming = await getUrlAjax(req.params.content, nonce);

    const $ = cheerio.load(htmlStreaming);
    const streamingUrl = $("iframe").attr("src");

    return res.status(200).json({
      success: true,
      streaming_url: streamingUrl,
    });
  } catch (error) {
    console.error("Error in getStreaming:", error);
    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
}

module.exports = {
  getOngoingAnime,
  getCompletedAnime,
  searchAnime,
  getAnimeList,
  getAnimeDetail,
  getAnimeEpisode,
  getAnimeBatch,
  getGenreList,
  getGenrePage,
  getStreaming,
};
