import 'package:flutter/material.dart';
import 'package:kunime/features/home/models/home_ui_models.dart';

class CategorySlider extends StatelessWidget {
  final List<UiCategory> categories;
  final String? selectedId;
  final ValueChanged<UiCategory> onSelected;

  // optional styling
  final double height;
  final EdgeInsetsGeometry padding;
  final double spacing;

  const CategorySlider({
    super.key,
    required this.categories,
    required this.onSelected,
    this.selectedId,
    this.height = 42,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();

    final scheme = Theme.of(context).colorScheme;
    final unselectedBg = _resolveUnselectedBg(context);

    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: spacing),
        itemBuilder: (context, index) {
          final c = categories[index];
          final selected = c.id == selectedId;

          final bg = selected ? Colors.red : unselectedBg;
          // final fg = selected ? scheme.onPrimary : scheme.onSurface;

          return ElevatedButton.icon(
            onPressed: () => onSelected(c),
            icon: c.icon == null
                ? const SizedBox.shrink()
                : Icon(c.icon, size: 18, color: scheme.onSurface),
            label: Text(c.label, style: TextStyle(color: scheme.onSurface)),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: bg,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              minimumSize: Size(0, height),
            ),
          );
        },
      ),
    );
  }

  Color _resolveUnselectedBg(BuildContext context) {
    final theme = Theme.of(context);
    final sc = theme.colorScheme;
    // Fallback
    final isDark = theme.brightness == Brightness.dark;
    final fallback = isDark ? Colors.white10 : Colors.black12;
    try {
      return sc.surfaceContainerHighest.withValues(alpha: 0.6);
    } catch (_) {
      return fallback;
    }
  }
}
