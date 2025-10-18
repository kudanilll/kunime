import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kunime/routes.dart';
import 'package:kunime/utils/theme_data.dart';
import 'package:kunime/utils/validator.dart';
import 'package:kunime/widgets/button.dart';
import 'package:kunime/widgets/toast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _hidePassword = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // TODO: handle register
  void _register() {
    final String email = _emailController.text;
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    if (email.isEmpty) {
      Toast.error(context, "Email tidak boleh kosong");
      return;
    }

    if (username.isEmpty) {
      Toast.error(context, "Nama pengguna tidak boleh kosong");
      return;
    }

    if (password.isEmpty) {
      Toast.error(context, "Kata sandi tidak boleh kosong");
      return;
    }

    if (!validateEmail(email)) {
      Toast.error(context, "Email tidak valid");
      return;
    }

    if (password.length < 8) {
      Toast.error(context, "Password harus lebih dari 8 karakter");
      return;
    }

    Toast.success(context, "Berhasil masuk");
    Routes.replaceTo(Routes.home);
  }

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
            onPressed: () => Routes.replaceTo(Routes.wizard),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: '${dotenv.env['IMG_SIGNUP_URL']}',
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
                          .withOpacity(0.3),
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
                        'Daftar Sekarang',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Isi formulir dibawah ini',
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
                      decoration: InputDecoration(
                        prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: Icon(
                            FontAwesomeIcons.solidUser,
                            size: 20,
                          ),
                        ),
                        hintText: 'Nama pengguna',
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
                    const SizedBox(height: 32),
                    Button(
                      width: double.infinity,
                      onTap: () => _register(),
                      text: 'DAFTAR',
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => Routes.navigateTo(Routes.login),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Sudah memiliki akun? '),
                          Text(
                            'Masuk disini',
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
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
