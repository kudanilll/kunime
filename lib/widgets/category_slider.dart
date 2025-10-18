import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategorySlider extends StatefulWidget {
  const CategorySlider({super.key});
  @override
  State<CategorySlider> createState() => _CategorySliderState();
}

class _CategorySliderState extends State<CategorySlider> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {"icon": FontAwesomeIcons.fire, "label": "Ongoing"},
    {"icon": FontAwesomeIcons.wandMagicSparkles, "label": "Baru Rilis"},
    {"icon": FontAwesomeIcons.star, "label": "Populer"},
    {"icon": FontAwesomeIcons.star, "label": "Genre"},
    {"icon": FontAwesomeIcons.bookmark, "label": "Favorit"},
    {"icon": FontAwesomeIcons.clockRotateLeft, "label": "Riwayat"},
  ];

  Color _getTextColor(BuildContext context, bool isSelected) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    if (isDarkMode) {
      return Colors.white;
    } else {
      return isSelected ? Colors.white : Colors.grey.shade900;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 42,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              final bool isSelected = _selectedIndex == index;
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 16.0 : 4.0,
                  right: index == _categories.length - 1 ? 16.0 : 4.0,
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = index;
                      // TODO: add logic to change the content based on the selected category
                    });
                  },
                  icon: Icon(
                    _categories[index]["icon"],
                    size: 18,
                    color: _getTextColor(context, isSelected),
                  ),
                  label: Text(
                    _categories[index]["label"],
                    style: TextStyle(
                      color: _getTextColor(context, isSelected),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isSelected
                        ? Colors.red
                        : Theme.of(context).searchViewTheme.backgroundColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    elevation: 0,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
