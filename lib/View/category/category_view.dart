import 'package:flutter/material.dart';
import 'package:news/Core/models/category_model.dart';
import 'package:news/Core/style/theme.dart';
import 'package:news/View/category/category_navigator.dart';
import 'package:news/View/category/category_tabs_widget.dart';
import 'package:news/View/category/category_view_model.dart';
import 'package:news/base/base_state.dart';
import 'package:provider/provider.dart';

class CategoryNewsList extends StatefulWidget {
  CategoryMD selectedCategory;
  CategoryNewsList(this.selectedCategory, {super.key});

  @override
  State<CategoryNewsList> createState() => _CategoryNewsListState();
}

class _CategoryNewsListState
    extends BaseState<CategoryNewsList, CategoryNewsListViewModel>
    implements CategoryNewsListNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.loadNewsSources(widget.selectedCategory.categoryID);
  }

  @override
  CategoryNewsListViewModel initViewModel() {
    return CategoryNewsListViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoryNewsListViewModel>(
      create: (_) => viewModel,
      child: Container(
        child: Consumer<CategoryNewsListViewModel>(
          //this child could be any thing not for re-building
          // child: const Text('header text view'),
          builder: (buildContext, viewModel, child) {
            if (viewModel.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: CircularProgressIndicator(
                        color: MyTheme.green,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      viewModel.errorMessage!,
                      style: const TextStyle(fontSize: 22),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyTheme.green),
                      onPressed: () {
                        viewModel.loadNewsSources(
                            widget.selectedCategory.categoryID);
                      },
                      child: const Text(
                        'try again',
                        style: TextStyle(fontSize: 22),
                      ),
                    ),
                  ],
                ),
              );
            }
            else if (viewModel.sources!.isEmpty) {
              //loading
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(
                    child: CircularProgressIndicator(color: MyTheme.green,),
                  ),
                  SizedBox(height: 12,),
                  Text("Loading news...",style: TextStyle(fontSize: 22),)
                ],
              );
            } else {
              return CategoryTabsWidget(viewModel.sources!);
            }
          },
        ),
      ),
    );
  }
}
