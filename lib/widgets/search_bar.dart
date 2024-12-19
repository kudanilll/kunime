import 'package:flutter/material.dart';

class SimpleSearchBar extends StatelessWidget {
  const SimpleSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.grey[900],
          color: Theme.of(context).searchViewTheme.backgroundColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextField(
          decoration: const InputDecoration(
            hintText: 'Cari anime...',
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Icon(Icons.search),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
          onChanged: (value) {},
        ),
      ),
    );
  }
}
