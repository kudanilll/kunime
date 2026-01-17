class UiAnime {
  final String id;
  final String title;
  final String imageUrl;
  const UiAnime({
    required this.id,
    required this.title,
    required this.imageUrl,
  });
}

class UiBanner {
  final String id;
  final String imageUrl;
  final String? deepLink;
  const UiBanner({required this.id, required this.imageUrl, this.deepLink});
}

class UiCategory {
  final String id;
  final String label;
  final String icon;
  const UiCategory({required this.id, required this.label, required this.icon});
}

class UiOngoing {
  final String title;
  final String image;
  final int episode;
  final String day;
  final String endpoint;

  const UiOngoing({
    required this.title,
    required this.image,
    required this.episode,
    required this.day,
    required this.endpoint,
  });
}

class UiTrending {
  final String id;
  final String title;
  final String imageUrl;
  final int episodeCount;

  const UiTrending({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.episodeCount,
  });
}
