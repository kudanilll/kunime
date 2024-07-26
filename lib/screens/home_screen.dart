import 'package:flutter/material.dart';
import 'package:kunime/widgets/carousel.dart';
import 'package:kunime/widgets/top_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TopBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [Carousel()],
        ),
      ),
    );
  }
}
