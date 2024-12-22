const route = require("express").Router();
const {
  getOngoingAnime,
  getCompletedAnime,
  searchAnime,
  getAnimeList,
  getAnimeDetail,
  getAnimeEpisode,
  getAnimeBatch,
  getGenreList,
  getGenrePage,
  // getStreaming,
} = require("./controller");
const { register } = require("./auth");
const secure = require("./middleware");

route.get("/", (_, res) => {
  res.send({
    github: "https://github.com/kudanilll/kunime",
    endpoint: {
      getOngoingAnime: "/api/v1/ongoing/:page",
      getCompletedAnime: "/api/v1/completed/:page",
      getAnimeSearch: "/api/v1/search/:query",
      getAnimeList: "/api/v1/anime/list",
      getAnimeDetail: "/api/v1/anime/detail/:endpoint",
      getAnimeEpisode: "/api/v1/anime/episode/:endpoint",
      getAnimeBatch: "/api/v1/anime/batch/:endpoint",
      getGenreList: "/api/v1/genre",
      getGenrePage: "/api/v1/genre/:genre/:page",
      // getStreaming: "/api/v1/streaming/:content",
    },
  });
});

route.get("/api/v1/ongoing/:page", getOngoingAnime);
route.get("/api/v1/completed/:page", getCompletedAnime);
route.get("/api/v1/search/:query", searchAnime);
route.get("/api/v1/anime/list", getAnimeList);
route.get("/api/v1/anime/detail/:endpoint", getAnimeDetail);
route.get("/api/v1/anime/episode/:endpoint", getAnimeEpisode);
route.get("/api/v1/anime/batch/:endpoint", getAnimeBatch);
route.get("/api/v1/genre", getGenreList);
route.get("/api/v1/genre/:genre/:page", getGenrePage);
// route.get("/api/v1/streaming/:content", getStreaming);

// Authentication
route.post("/api/auth/register", secure, register);
// route.post("/api/auth/login", secure, login);

module.exports = route;
