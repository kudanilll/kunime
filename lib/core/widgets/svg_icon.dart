import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgIconData {
  final String path;
  final double size;
  final Color color;

  const SvgIconData({
    required this.path,
    required this.size,
    required this.color,
  });

  Widget get widget => SvgPicture.asset(
    path,
    width: size,
    height: size,
    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
  );

  IconButton get iconButton => IconButton(
    onPressed: null, // non-clickable
    icon: widget,
    iconSize: size,
    padding: EdgeInsets.zero,
    tooltip: null,
  );
}

class SvgIcon {
  SvgIcon._();

  static const String _iconPath = 'assets/icons';
  static const String searchIcon = '$_iconPath/search.svg';
  static const String fireIcon = '$_iconPath/fire.svg';
  static const String checkDoubleIcon = '$_iconPath/check-double.svg';
  static const String shapesIcon = '$_iconPath/shapes.svg';
  static const String bookmarkIcon = '$_iconPath/bookmark.svg';
  static const String historyIcon = '$_iconPath/history.svg';

  static SvgIconData search(double size, Color color) =>
      SvgIconData(path: searchIcon, size: size, color: color);
  static SvgIconData fire(double size, Color color) =>
      SvgIconData(path: fireIcon, size: size, color: color);
  static SvgIconData checkDouble(double size, Color color) =>
      SvgIconData(path: checkDoubleIcon, size: size, color: color);
  static SvgIconData shapes(double size, Color color) =>
      SvgIconData(path: shapesIcon, size: size, color: color);
  static SvgIconData bookmark(double size, Color color) =>
      SvgIconData(path: bookmarkIcon, size: size, color: color);
  static SvgIconData history(double size, Color color) =>
      SvgIconData(path: historyIcon, size: size, color: color);
}
