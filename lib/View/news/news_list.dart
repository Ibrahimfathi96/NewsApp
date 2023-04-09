import 'package:flutter/material.dart';
import 'package:news/Core/API/models/Sources.dart';
import 'package:news/Core/style/theme.dart';
import 'package:news/View/news/navigator.dart';
import 'package:news/View/news/news_item.dart';
import 'package:news/View/news/news_list_view_model.dart';
import 'package:news/base/base_state.dart';
import 'package:provider/provider.dart';

class NewsList extends StatefulWidget {
  Source source;

  NewsList(this.source, {super.key});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends BaseState<NewsList, NewsListViewModel>
    implements NewsListNavigator {
  @override
  NewsListViewModel initViewModel() {
    return NewsListViewModel();
  }

  @override
  void initState() {
    super.initState();
    viewModel.getNewsBySourceId(widget.source.id!);
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => viewModel,
      child: Container(
        child: Consumer<NewsListViewModel>(
          builder: (context, viewModel, _) {
            if (viewModel.errorMessage != null) {
              return Column(
                children: [
                  const CircularProgressIndicator(
                    color: MyTheme.green,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text('${viewModel.errorMessage}'),
                  const SizedBox(
                    height: 12,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: MyTheme.green),
                      onPressed: () {
                        viewModel.getNewsBySourceId(widget.source.id!);
                      },
                      child: const Text('try again'))
                ],
              );
            }else if (viewModel.newsList!.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: MyTheme.green,
                ),
              );
            } else {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return NewsItem(viewModel.newsList![index]);
                },
                itemCount: viewModel.newsList?.length??0,
              );
            }
          },
        ),
      ),
    );
  }
}
