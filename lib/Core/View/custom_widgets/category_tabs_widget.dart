import 'package:flutter/material.dart';
import 'package:news/Core/API/models/Sources.dart';
import 'package:news/Core/View/custom_widgets/news_list.dart';
import 'package:news/Core/View/custom_widgets/source_tab_item.dart';

class CategoryTabsWidget extends StatefulWidget {
  List<Source> sources;

  CategoryTabsWidget(this.sources);

  @override
  State<CategoryTabsWidget> createState() => _CategoryTabsWidgetState();
}

class _CategoryTabsWidgetState extends State<CategoryTabsWidget> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DefaultTabController(
        length: widget.sources.length,
        child: Column(
          children: [
            TabBar(
              labelPadding: const EdgeInsets.all(5),
                onTap: (index){
                  setState(() {
                    selectedIndex = index;
                  });
                },
                tabs:
                widget.sources.map((source) => SourceTab(source,
                  widget.sources.indexOf(source) == selectedIndex
                )).toList(),
              indicatorColor: Colors.transparent,
              isScrollable: true,
            ),
            Expanded(child: NewsList(widget.sources[selectedIndex])),
          ],
        ),

      ),
    );
  }
}
