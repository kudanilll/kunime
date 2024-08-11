import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kunime/routes.dart';
import 'package:kunime/utils/theme_data.dart';
import 'package:kunime/widgets/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _hidePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
            icon: const Icon(
              FontAwesomeIcons.circleChevronLeft,
              size: 32,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pushNamed(context, Routes.widzard),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
                "https://akcdn.detik.net.id/visual/2024/01/24/anime-oshi-no-ko-2023_169.jpeg?w=1024&q=100",
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) =>
                const FaIcon(FontAwesomeIcons.solidCircleXmark),
          ),
          if (isLightMode(context))
            Container(
              height: 248,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                  ],
                ),
              ),
            ),
          Column(
            children: [
              Container(
                height: 248,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.2),
                      Theme.of(context)
                          .scaffoldBackgroundColor
                          .withOpacity(0.8),
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(1),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Selamat Datang Kembali!',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Selamat datang, kami merindukanmu',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: Icon(
                            FontAwesomeIcons.solidEnvelope,
                            size: 20,
                          ),
                        ),
                        hintText: 'Email',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                        fillColor:
                            Theme.of(context).searchViewTheme.backgroundColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      obscureText: _hidePassword,
                      decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: Icon(
                            FontAwesomeIcons.lock,
                            size: 20,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: IconButton(
                            iconSize: 20,
                            icon: FaIcon(
                              _hidePassword
                                  ? FontAwesomeIcons.solidEyeSlash
                                  : FontAwesomeIcons.solidEye,
                            ),
                            onPressed: () => setState(() {
                              _hidePassword = !_hidePassword;
                            }),
                          ),
                        ),
                        hintText: 'Kata sandi',
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide.none,
                        ),
                        fillColor:
                            Theme.of(context).searchViewTheme.backgroundColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, Routes.forgotPassword),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),
                    Button(
                      width: double.infinity,
                      onTap: () {},
                      text: 'MASUK',
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, Routes.register),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Belum memiliki akun? '),
                          Text(
                            'Daftar disini',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
