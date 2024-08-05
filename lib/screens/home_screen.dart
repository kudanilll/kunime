import 'package:flutter/material.dart';
import 'package:kunime/widgets/carousel/banner_carousel.dart';
import 'package:kunime/widgets/carousel/ongoing_anime_carousel.dart';
import 'package:kunime/widgets/category_slider.dart';
import 'package:kunime/widgets/listview/trending_anime_list.dart';
import 'package:kunime/widgets/search_bar.dart';
import 'package:kunime/widgets/top_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TopBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BannerCarousel(),
            SimpleSearchBar(),
            CategorySlider(),
            OngoingAnimeCarousel(),
            TrendingAnimeList()
          ],
        ),
      ),
    );
  }
}
