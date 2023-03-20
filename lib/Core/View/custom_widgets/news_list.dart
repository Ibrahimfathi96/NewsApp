import 'package:flutter/material.dart';
import 'package:news/Core/API/api_manager.dart';
import 'package:news/Core/API/models/NewsResponse.dart';
import 'package:news/Core/API/models/Sources.dart';
import 'package:news/Core/View/custom_widgets/news_item.dart';

class NewsList extends StatelessWidget {
Source source;
NewsList(this.source);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<NewsResponse>(
        future: APIManager.getNews(sourceId:source.id ?? '',query:''),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          if(snapshot.hasError){
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20,),
                  Text(
                      textAlign: TextAlign.center,
                      'Error Loading Data,Check Your Connection\n${snapshot.error.toString()}',
                      style:Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: Colors.black87, fontWeight: FontWeight.w300)
                  ),
                ],
              ),
            );
          }
          if(snapshot.data!.status == 'error'){
            return Center(child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20,),
                Text(
                    textAlign: TextAlign.center,
                    'Server Error Loading data${
                    snapshot.data?.message
                    }',
                    style:Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: Colors.black87, fontWeight: FontWeight.w300)
                ),
              ],
            ) ,);
          }
          var newsList = snapshot.data?.newsList;
          return ListView.builder(
            itemBuilder: (context, index) {
              return NewsItem(newsList![index]);
            },
            itemCount: newsList?.length ,
          );
        },
      ),
    );
  }
}
