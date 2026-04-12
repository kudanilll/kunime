import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kunime/core/themes/app_tokens.dart';

class AlphabetSlider extends StatelessWidget {
  const AlphabetSlider({
    super.key,
    required this.selectedLetter,
    required this.onSelected,
  });

  final String? selectedLetter;
  final ValueChanged<String?> onSelected;

  static const List<String> _letters = <String>[
    '#',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: SizedBox(
        height: 42,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          scrollDirection: Axis.horizontal,
          child: IntrinsicWidth(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _letters.map((letter) {
                final normalizedValue = letter == '#' ? null : letter;
                final isSelected = selectedLetter == normalizedValue;
                return Padding(
                  padding: EdgeInsets.only(left: letter != '#' ? 8 : 0),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(96),
                    onTap: () {
                      HapticFeedback.lightImpact();
                      onSelected(normalizedValue);
                    },
                    child: AnimatedContainer(
                      width: 62,
                      duration: const Duration(milliseconds: 180),
                      constraints: const BoxConstraints(
                        minWidth: 42,
                        minHeight: 42,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTokens.primaryContainer
                            : AppTokens.secondary,
                        borderRadius: BorderRadius.circular(96),
                      ),
                      child: Center(
                        child: Text(
                          letter,
                          maxLines: 1,
                          textAlign: TextAlign.center,
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
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
