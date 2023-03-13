import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/Core/API/models/news.dart';

class NewsItem extends StatelessWidget {
  News news;
  NewsItem(this.news);
  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(
            news.publishedAt ?? '',
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
