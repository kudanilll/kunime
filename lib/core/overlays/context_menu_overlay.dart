import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/features/home/models/context_menu_action.dart';

class ContextMenuOverlay extends StatelessWidget {
  final LayerLink link;
  final Offset offset;
  final Widget? preview;
  final List<ContextMenuAction> actions;

  const ContextMenuOverlay({
    super.key,
    required this.link,
    required this.offset,
    required this.actions,
    this.preview,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (preview != null)
          IgnorePointer(
            ignoring: true,
            child: CompositedTransformFollower(
              link: link,
              showWhenUnlinked: false,
              offset: Offset.zero,
              child: preview!,
            ),
          ),

        CompositedTransformFollower(
          link: link,
          showWhenUnlinked: false,
          offset: offset,
          child: Material(
            type: MaterialType.transparency,
            child: IntrinsicWidth(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  actions.length,
                  (i) => Padding(
                    padding: EdgeInsets.only(top: i == 0 ? 0 : 8),
                    child: _ContextMenuActionTile(action: actions[i], index: i),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContextMenuActionTile extends StatelessWidget {
  final ContextMenuAction action;
  final int index;

  const _ContextMenuActionTile({required this.action, required this.index});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 140 + (index * 40)),
      curve: Curves.easeOut,
      builder: (context, t, child) {
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(0, (1 - t) * 12),
            child: child,
          ),
        );
      },
      child: InkWell(
        onTap: action.onTap,
        borderRadius: BorderRadius.circular(96),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.black,
            borderRadius: BorderRadius.circular(96),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              action.icon,
              const SizedBox(width: 8),
              Text(
                action.label,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
