import 'package:flutter/material.dart';
import 'package:news/Core/API/models/Sources.dart';
import 'package:news/Core/style/theme.dart';

class SourceTab extends StatelessWidget {
  bool selected;
  Source source;
  SourceTab(this.source, this.selected);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: selected? MyTheme.green : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: MyTheme.green, width: 2)
      ),
      child: Text(source.name ?? '',
      style: TextStyle(
        color: selected? Colors.white:MyTheme.green
      ),
      ),
    );
  }
}
