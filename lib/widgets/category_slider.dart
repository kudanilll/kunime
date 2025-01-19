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
    {"icon": FontAwesomeIcons.bookmark, "label": "Favorit"},
    {"icon": FontAwesomeIcons.clockRotateLeft, "label": "Riwayat"},
  ];

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
                    color: _selectedIndex == index
                        ? Colors.white
                        : Theme.of(context).searchViewTheme.backgroundColor,
                  ),
                  label: Text(
                    _categories[index]["label"],
                    style: TextStyle(
                      color: _selectedIndex == index
                          ? Colors.white
                          : Theme.of(context).searchViewTheme.backgroundColor,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor:
                        _selectedIndex == index ? Colors.white : Colors.black,
                    backgroundColor:
                        _selectedIndex == index ? Colors.red : Colors.grey[300],
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
