import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/Core/API/models/Sources.dart';
import 'package:news/Core/API/models/news.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends StatelessWidget {
  static const String routeName = 'news-screen';
  Source? source;
  late DateTime publishedAt;
  @override
  Widget build(BuildContext context) {
    News news = ModalRoute.of(context)?.settings.arguments as News;
    publishedAt = DateTime.parse(news.publishedAt ??'');
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
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.share_outlined,
                      size: 26,
                    )),
              )
            ],
            title: Text(news.source?.name ?? ''),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: news.urlToImage ?? '',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            news.source?.name ?? '',
                            style: const TextStyle(
                                color: Colors.black87, fontSize: 14),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          const Icon(
                            Icons.circle,
                            color: Color(0xff79828B),
                            size: 8,
                          ),
                          Text(
                            news.author ?? '',
                            textAlign: TextAlign.start,
                              style: const TextStyle(
                              color: Colors.black87, fontSize: 14)
                          ),
                          const Icon(
                            Icons.circle,
                            color: Color(0xff79828B),
                            size: 8,
                          )
                        ],
                      ),
                      Text(
                        news.title ?? '',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.history_toggle_off,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            '${showPublishedAt(news)}',
                            textAlign: TextAlign.end,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 20,
                          color: Colors.white,
                          shadowColor: Colors.grey[100],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SingleChildScrollView(
                                  child: Text(
                                    news.description ?? '',
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.black87),
                                  ),
                                ),
                                const Spacer(),
                                InkWell(
                                  onTap: (){
                                    _launchUrl(Uri.parse(news.url??''));
                                  },
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: const [
                                        Text(
                                          'View Full Article',
                                          style: TextStyle(
                                              fontSize: 16,fontWeight: FontWeight.bold, color: Colors.black87),
                                        ),
                                        Icon(Icons.play_arrow),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

showPublishedAt(News news){
    var dateTimeNow = DateTime.now();
    var difference = dateTimeNow.difference(publishedAt).inMinutes;
    if(difference < 0){
      difference = dateTimeNow.difference(publishedAt).inSeconds;
      return '$difference seconds ago';
    }else if(difference>0 && difference<60){
      difference = dateTimeNow.difference(publishedAt).inMinutes;
      return '$difference minutes ago';
    }else if(difference>60 && difference<1440){
      difference = dateTimeNow.difference(publishedAt).inHours;
      return '$difference hours ago';
    }
    else if(difference>1440 && difference<44640){
      difference = dateTimeNow.difference(publishedAt).inDays;
      return '$difference days ago';
    }else{
      return DateFormat.yMMMd().format(publishedAt);
    }

}
  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
