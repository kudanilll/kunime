import 'package:flutter/material.dart';
import 'package:kunime/core/themes/app_colors.dart';
import 'package:kunime/core/themes/app_tokens.dart';

class PaginationControls extends StatelessWidget {
  final int currentPage;
  final bool hasNextPage;
  final bool isLoading;
  final ValueChanged<int> onPageSelected;

  const PaginationControls({
    super.key,
    required this.currentPage,
    required this.hasNextPage,
    required this.isLoading,
    required this.onPageSelected,
  });

  List<int?> _buildPageNumbers() {
    final pages = <int?>[];
    final startPage = currentPage <= 3 ? 1 : currentPage - 1;
    final endPage = currentPage + (hasNextPage ? 1 : 0);

    if (startPage > 1) {
      pages.add(1);
      if (startPage > 2) {
        pages.add(null);
      }
    }

    for (var page = startPage; page <= endPage; page++) {
      if (!pages.contains(page)) {
        pages.add(page);
      }
    }

    return pages;
  }

  @override
  Widget build(BuildContext context) {
    final pages = _buildPageNumbers();

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        top: 8,
        right: 16,
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      child: SizedBox(
        height: 42,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: IntrinsicWidth(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...pages.map((page) {
                  if (page == null) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '...',
                        style: TextStyle(
                          color: AppColors.neutral400,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    );
                  }

                  final isSelected = page == currentPage;
                  return Padding(
                    padding: EdgeInsets.only(left: page != pages.first ? 8 : 0),
                    child: GestureDetector(
                      onTap: isLoading ? null : () => onPageSelected(page),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        constraints: const BoxConstraints(
                          minWidth: 48,
                          minHeight: 48,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTokens.primary
                              : AppTokens.secondary,
                          borderRadius: BorderRadius.circular(96),
                        ),
                        child: Center(
                          child: isLoading && isSelected
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppTokens.onPrimary,
                                  ),
                                )
                              : Text(
                                  '$page',
                                  style: TextStyle(
                                    color: isSelected
                                        ? AppTokens.onPrimary
                                        : AppTokens.onSecondary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
