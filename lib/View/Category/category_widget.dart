import 'package:flutter/material.dart';
import 'package:news/Core/API/api_manager.dart';
import 'package:news/Core/API/models/SourcesResponse.dart';
import 'package:news/Core/model/category_model.dart';
import 'package:news/View/Category/category_tabs_widget.dart';

class CategoryWidget extends StatelessWidget {
  CategoryMD selectedCategory;
  CategoryWidget(this.selectedCategory);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<SourcesResponse>(
        future: APIManager.getSources(selectedCategory.categoryID),
        builder: (buildContext, snapshot){
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
                    'Server Error Loading data${snapshot.data?.message}',
                    style:Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: Colors.black87, fontWeight: FontWeight.w300)
                ),
              ],
            ) ,);
          }
          var sources = snapshot.data?.sources;
          return CategoryTabsWidget(sources!);
          //   ListView.builder(
          //   itemBuilder: (context, index) => Text('${sources?[index].name}'),
          //   itemCount: sources?.length ?? 0 ,
          // );
        },
      ),

    );
  }
}
