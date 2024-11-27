import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kunime/routes.dart';
import 'package:kunime/widgets/button.dart';

class AuthWidzardScreen extends StatelessWidget {
  const AuthWidzardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.cover,
              child: CachedNetworkImage(
                imageUrl:
                    "https://w0.peakpx.com/wallpaper/982/1015/HD-wallpaper-neon-cat-animals-black-cats-dark-glasses-pink-purple.jpg",
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    const FaIcon(FontAwesomeIcons.solidCircleXmark),
              ),
            ),
          ),
          Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(1),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 52),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Selamat datang',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pilih metode untuk melanjutkan',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Button(
                  width: double.infinity,
                  onTap: () => Navigator.pushNamed(context, Routes.login),
                  text: 'MASUK',
                ),
                const SizedBox(
                  height: 18,
                ),
                Button(
                  width: double.infinity,
                  onTap: () => Navigator.pushNamed(context, Routes.register),
                  text: 'DAFTAR',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
