import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final List<String> imageUrls = [
  "${dotenv.env['BANNER_1_URL']}",
  "${dotenv.env['BANNER_2_URL']}",
  "${dotenv.env['BANNER_3_URL']}",
  "${dotenv.env['BANNER_4_URL']}",
  "${dotenv.env['BANNER_5_URL']}",
  "${dotenv.env['BANNER_6_URL']}",
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
              child: Image.network(imageUrls[index], fit: BoxFit.cover),
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
