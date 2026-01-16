import 'package:kunime/features/home/models/home_ui_models.dart';

abstract class BannerRepository {
  Future<List<UiBanner>> getBanners();
}
