import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Core/model/category_model.dart';
import 'package:news/Core/style/dialog%20utils.dart';
import 'package:news/Core/style/theme.dart';
import 'package:news/View/Category/category_tabs_widget.dart';
import 'package:news/View/Category/category_view_model.dart';

class CategoryWidget extends StatefulWidget {
  CategoryMD selectedCategory;

  CategoryWidget(this.selectedCategory);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  void initState() {
    super.initState();
    viewModel.loadSources(widget.selectedCategory.categoryID);
  }
  CategoryViewModel viewModel = CategoryViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryViewModel>(
      create: (context) => viewModel,
      child: Container(
        child: BlocConsumer<CategoryViewModel, CategoryInitialState>(
          listener: (context, state) {
            if(state is MessageAction){
              DialogUtils.showMessage(context, state.message);
            }else if(state is NavigateToScreenAction){
              Navigator.pushNamed(context, state.routeName);
            }
          },
          ///return true or false to determine whether or not
          ///to invoke listener with the state or buildWhen to rebuild
          listenWhen:(previous, current) {
            if(current is MessageAction||current is NavigateToScreenAction){
              return true;
            } return false;
          },
          buildWhen: (previous, current) {
            if(current is MessageAction){
              return false;
            }return true;
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: MyTheme.green,
                ),
              );
            } else if (state is SourcesLoadedState) {
              return CategoryTabsWidget(state.sources);
            } else if (state is ErrorState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.errorMessage),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyTheme.green),
                    onPressed: () {
                      viewModel.loadSources(widget.selectedCategory.categoryID);
                    },
                    child: const Text('try again'),
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
