import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kunime/app/router/nav_ext.dart';
import 'package:kunime/features/home/application/completed_controller.dart';
import 'package:kunime/features/home/application/completed_state.dart';
import 'package:kunime/core/themes/app_colors.dart';
// import 'package:kunime/features/home/presentation/sections/completed/widgets/alphabet_slider.dart';
import 'package:kunime/features/home/presentation/sections/completed/widgets/completed_anime_list.dart';
import 'package:kunime/features/home/presentation/sections/completed/widgets/completed_skeleton_list.dart';
import 'package:kunime/features/home/presentation/sections/completed/widgets/pagination_controls.dart';

class CompletedSection extends ConsumerStatefulWidget {
  const CompletedSection({super.key});

  @override
  ConsumerState<CompletedSection> createState() => _CompletedSectionState();
}

class _CompletedSectionState extends ConsumerState<CompletedSection> {
  final GlobalKey _topKey = GlobalKey();

  Future<void> _handlePageChange(Future<void> Function() onChange) async {
    final targetContext = _topKey.currentContext;
    if (targetContext == null || !mounted) return;

    await onChange();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      Scrollable.ensureVisible(
        targetContext,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        alignment: -1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(completedControllerProvider);
    final controller = ref.read(completedControllerProvider.notifier);

    return Column(
      key: _topKey,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // AlphabetSlider(
        //   selectedLetter: state.selectedLetter,
        //   onSelected: controller.selectLetter,
        // ),
        const SizedBox(height: 12),
        _buildContent(state, controller),
      ],
    );
  }

  Widget _buildContent(CompletedState state, CompletedController controller) {
    switch (state.status) {
      case CompletedStatus.initialLoading:
        return const CompletedSkeletonList();
      case CompletedStatus.empty:
        return const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Tidak ada data',
            style: TextStyle(color: AppColors.neutral400),
          ),
        );
      case CompletedStatus.error:
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                state.errorMessage ?? 'Gagal memuat data',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.neutral400),
              ),
              const SizedBox(height: 12),
              FilledButton(
                onPressed: controller.retry,
                child: const Text('Coba lagi'),
              ),
            ],
          ),
        );
      case CompletedStatus.success:
        return Column(
          children: [
            CompletedAnimeList(
              items: state.items,
              onTapItem: (item) => context.pushAnimeDetail(item.endpoint),
            ),
            if (state.errorMessage != null) ...[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                child: Text(
                  state.errorMessage!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.errorBadge,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
            PaginationControls(
              currentPage: state.currentPage,
              hasNextPage: state.hasNextPage,
              isLoading: state.isPageLoading,
              onPageSelected: (page) {
                _handlePageChange(() => controller.fetchPage(page));
              },
            ),
          ],
        );
    }
  }
}
