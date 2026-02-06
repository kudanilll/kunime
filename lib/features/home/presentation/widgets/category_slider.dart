import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kunime/core/themes/app_tokens.dart';
import 'package:kunime/core/widgets/svg_icon.dart';
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
    this.height = 48,
    this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    if (categories.isEmpty) return const SizedBox.shrink();
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

          final bg = selected ? AppTokens.primary : AppTokens.secondary;
          final fg = selected ? AppTokens.onPrimary : AppTokens.onSecondary;

          final icon = SvgIconData(path: c.icon, size: 18, color: fg);

          return InkWell(
            borderRadius: BorderRadius.circular(96),
            onTap: () {
              HapticFeedback.lightImpact();
              onSelected(c);
            },
            child: Container(
              height: height,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(96),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon.widget,
                  const SizedBox(width: 8),
                  Text(
                    c.label,
                    style: TextStyle(
                      color: fg,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
