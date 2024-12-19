import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

final List<String> imageUrls = [
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQd3Jjb1fhVHvdkm9Br2IJL1RPwRyoSo08kw&s",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT47osGtlwwb7y3T6obO22_zKVEODOIJr3qIQ&s",
  "https://staticg.sportskeeda.com/editor/2023/01/d6973-16738138947896-1920.jpg?w=640",
  "https://p325k7wa.twic.pics/high/jujutsu-kaisen/jujutsu-kaisen-cursed-clash/00-page-setup/JJK-header-mobile2.jpg?twic=v1/resize=760/step=10/quality=80",
  "https://www.blibli.com/friends-backend/wp-content/uploads/2023/01/B110510-Cover.jpg",
];

class BannerCarousel extends StatelessWidget {
  const BannerCarousel({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SizedBox(
        height: 200,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
              ),
            );
          },
          autoplay: true,
          itemCount: imageUrls.length,
          viewportFraction: 0.8,
          scale: 0.9,
        ),
      ),
    );
  }
}
