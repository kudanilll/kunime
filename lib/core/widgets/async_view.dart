import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncView<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T data) builder;
  final Widget? loading;
  final Widget? error;

  const AsyncView({
    super.key,
    required this.value,
    required this.builder,
    this.loading,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    if (value.isLoading && !value.hasValue) {
      return loading ?? const Center(child: CircularProgressIndicator());
    }
    if (value.hasError) {
      return error ?? Center(child: Text('Error: ${value.error}'));
    }
    return builder(value.requireValue);
  }
}
