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
    return value.when(
      data: builder,
      loading: () =>
          loading ?? const Center(child: CircularProgressIndicator()),
      error: (e, st) => error ?? Center(child: Text('Error: $e')),
    );
  }
}
