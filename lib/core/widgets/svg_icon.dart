import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIcon {
  SvgIcon._();

  static final String _iconPath = 'assets/icons';

  static Widget search(double size, Color color) => SvgPicture.asset(
    '$_iconPath/search.svg',
    width: size,
    height: size,
    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
  );
}
