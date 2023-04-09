import 'package:flutter/material.dart';
import 'package:news/Core/API/api_manager.dart';
import 'package:news/Core/API/models/news.dart';
import 'package:news/Core/style/theme.dart';
import 'package:news/View/news/news_item.dart';

class SearchPage extends StatefulWidget {
static const String routeName = 'search-page';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
String query = '';
List<News> newsList= [];
News? news;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Image.asset(
            'assets/images/pattern.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            toolbarHeight: 70,
            leading: const SizedBox(),
            leadingWidth: 6,
            title: Container(
              height:70 ,
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                onChanged: (String? value){
                  setState(() {query = value!;});
                },
                decoration: InputDecoration(
                  prefixIcon:IconButton(
                    onPressed: (){Navigator.pop(context);},
                    icon: const Icon(Icons.clear,color: MyTheme.green,size: 26,),
                  ),
                  suffixIcon: IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.search,color: MyTheme.green,size: 26,),
                  ),
                  hintText: 'Search Article...',
                  hintStyle: TextStyle(
                    color: MyTheme.green.withOpacity(0.8)
                  ),
                  contentPadding: const EdgeInsets.only(top: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Colors.white
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.white
                ),
              ),
            ),
          ),
          body: ListView.builder(
            itemCount: search().length,
            itemBuilder: (context, index) => NewsItem(search().elementAt(index)),),
        ),
      ],
    );
  }

  List search(){
    APIManager.getNews(query: query).then((newsResponse){
      newsList = newsResponse.newsList ?? [];
    }).catchError((error){
      debugPrint('error during call api $error');
    });
    return newsList;
  }
}