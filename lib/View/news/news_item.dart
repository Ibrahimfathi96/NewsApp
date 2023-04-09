import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/Core/API/models/news.dart';
import 'package:intl/intl.dart';
import 'package:news/View/news/news_details_screen.dart';

class NewsItem extends StatelessWidget {
  News news;
  NewsItem(this.news);
  late DateTime publishedAt;
  @override
  Widget build(BuildContext context) {
    publishedAt = DateTime.parse(news.publishedAt ??'');
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, NewsDetailsScreen.routeName, arguments: news);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              width: double.infinity,
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CachedNetworkImage(
                  imageUrl: news.urlToImage ?? '',fit: BoxFit.fill,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Text(
              news.author ?? '',
              textAlign: TextAlign.start,
            ),
            Text(
              news.title ?? '',
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontWeight: FontWeight.w300, color: Colors.black, fontSize: 22),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                '${showPublishedAt(news)}',
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }
  showPublishedAt(News news){
    var dateTimeNow = DateTime.now();
    var difference = dateTimeNow.difference(publishedAt).inMinutes;
    if(difference<0){
      difference = dateTimeNow.difference(publishedAt).inSeconds;
      return '$difference seconds ago';
    }else if(difference>0 && difference<60){
      difference = dateTimeNow.difference(publishedAt).inMinutes;
      return '$difference minutes ago';
    }else if(difference>60 && difference<1440){
      difference = dateTimeNow.difference(publishedAt).inHours;
      return '$difference hours ago';
    }else if(difference>1440 && difference<44640){
      difference = dateTimeNow.difference(publishedAt).inDays;
      return '$difference days ago';
    }else{
      return DateFormat.yMMMd().format(publishedAt);
    }

  }
}
