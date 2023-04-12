import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/Core/API/models/Sources.dart';
import 'package:news/Core/style/theme.dart';
import 'package:news/View/news/news_item.dart';
import 'package:news/View/news/news_list_view_model.dart';

class NewsList extends StatefulWidget {
  Source source;
  NewsList(this.source);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  NewsListViewModel newsListViewModel = NewsListViewModel();
  @override
  void initState() {
    super.initState();
    newsListViewModel.loadNewsBySourceId(widget.source.id!);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocBuilder<NewsListViewModel, NewsListState>(
      bloc: newsListViewModel,
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator(),);
        } else if (state is NewsLoadedState) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return NewsItem(state.newsList[index]);
            },
            itemCount: state.newsList.length,
          );
        } else if (state is ErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: MyTheme.green,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                    textAlign: TextAlign.center,
                    state.errorMessage,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.w300)),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyTheme.green),
                    onPressed: () {
                      newsListViewModel.loadNewsBySourceId(widget.source.id!);
                    },
                    child: const Text('try again'))
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    )

        // FutureBuilder<NewsResponse>(
        //   future: APIManager.getNews(sourceId:source.id ?? '',query:''),
        //   builder: (context, snapshot){
        //     if(snapshot.connectionState == ConnectionState.waiting){
        //       return const Center(child: CircularProgressIndicator(),);
        //     }
        //     if(snapshot.hasError){
        //       return Center(
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             const CircularProgressIndicator(),
        //             const SizedBox(height: 20,),
        //             Text(
        //                 textAlign: TextAlign.center,
        //                 'Error Loading Data,Check Your Connection\n${snapshot.error.toString()}',
        //                 style:Theme.of(context)
        //                     .textTheme
        //                     .headlineLarge!
        //                     .copyWith(color: Colors.black87, fontWeight: FontWeight.w300)
        //             ),
        //           ],
        //         ),
        //       );
        //     }
        //     if(snapshot.data!.status == 'error'){
        //       return Center(child:Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           const CircularProgressIndicator(),
        //           const SizedBox(height: 20,),
        //           Text(
        //               textAlign: TextAlign.center,
        //               'Server Error Loading data${
        //               snapshot.data?.message
        //               }',
        //               style:Theme.of(context)
        //                   .textTheme
        //                   .headlineLarge!
        //                   .copyWith(color: Colors.black87, fontWeight: FontWeight.w300)
        //           ),
        //         ],
        //       ) ,);
        //     }
        //     var newsList = snapshot.data?.newsList;
        //     return ListView.builder(
        //       itemBuilder: (context, index) {
        //         return NewsItem(newsList![index]);
        //       },
        //       itemCount: newsList?.length ,
        //     );
        //   },
        // ),
        );
  }
}
