import 'package:kunime/features/home/data/banner_repository.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';

class BannerRepositoryImpl implements BannerRepository {
  @override
  Future<List<UiBanner>> getBanners() async {
    final raw = <String?>[
      const String.fromEnvironment('BANNER_1_URL'),
      const String.fromEnvironment('BANNER_2_URL'),
      const String.fromEnvironment('BANNER_3_URL'),
      const String.fromEnvironment('BANNER_4_URL'),
      const String.fromEnvironment('BANNER_5_URL'),
      const String.fromEnvironment('BANNER_6_URL'),
    ];

    bool valid(String? u) {
      if (u == null) return false;
      final s = u.trim();
      if (s.isEmpty) return false;
      if (s.toLowerCase() == 'null') return false;
      final uri = Uri.tryParse(s);
      return uri != null && (uri.isScheme('http') || uri.isScheme('https'));
    }

    final urls = raw.where(valid).map((s) => s!.trim()).toList();

    // Fallback tetap di repository, bukan provider
    final finalUrls = urls.isEmpty
        ? List.generate(3, (i) => 'https://picsum.photos/1200/400?banner=$i')
        : urls;

    return List.generate(
      finalUrls.length,
      (i) => UiBanner(id: 'banner_$i', imageUrl: finalUrls[i]),
    );
  }
}
