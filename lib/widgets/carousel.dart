import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

final List<String> imageUrls = [
  "https://img.freepik.com/free-photo/japan-background-digital-art_23-2151546198.jpg?t=st=1721970508~exp=1721974108~hmac=6478df1be8d9ff33f2501809113109d5c35b45940946bfb22546ba1c4f07922a&w=740",
  "https://img.freepik.com/free-photo/japan-background-digital-art_23-2151546198.jpg?t=st=1721970508~exp=1721974108~hmac=6478df1be8d9ff33f2501809113109d5c35b45940946bfb22546ba1c4f07922a&w=740",
  "https://img.freepik.com/free-photo/japan-background-digital-art_23-2151546198.jpg?t=st=1721970508~exp=1721974108~hmac=6478df1be8d9ff33f2501809113109d5c35b45940946bfb22546ba1c4f07922a&w=740",
  "https://img.freepik.com/free-photo/japan-background-digital-art_23-2151546198.jpg?t=st=1721970508~exp=1721974108~hmac=6478df1be8d9ff33f2501809113109d5c35b45940946bfb22546ba1c4f07922a&w=740",
  "https://img.freepik.com/free-photo/japan-background-digital-art_23-2151546198.jpg?t=st=1721970508~exp=1721974108~hmac=6478df1be8d9ff33f2501809113109d5c35b45940946bfb22546ba1c4f07922a&w=740",
];

class Carousel extends StatelessWidget {
  const Carousel({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        height: 200, // Sesuaikan tinggi carousel sesuai kebutuhan
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
          itemCount: imageUrls.length,
          viewportFraction: 0.8,
          scale: 0.9,
        ),
      ),
    );
  }
}
