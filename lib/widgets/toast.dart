import 'package:flutter/material.dart';
import 'package:toasty_box/toast_enums.dart';
import 'package:toasty_box/toasty_box.dart';

class Toast {
  static Future<void> show(BuildContext context, String message) {
    return ToastService.showToast(
      context,
      message: message,
      messageStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 14,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      shadowColor: Colors.transparent,
      length: ToastLength.short,
      isClosable: true,
    );
  }

  static Future<void> success(BuildContext context, String message) {
    return ToastService.showToast(
      context,
      message: message,
      messageStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 14,
      ),
      backgroundColor: Colors.lightGreen.shade400,
      shadowColor: Colors.transparent,
      length: ToastLength.short,
      isClosable: true,
    );
  }

  static Future<void> error(BuildContext context, String message) {
    return ToastService.showToast(
      context,
      message: message,
      messageStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 14,
      ),
      backgroundColor: Colors.red.shade400,
      shadowColor: Colors.transparent,
      length: ToastLength.short,
      isClosable: true,
    );
  }
}
