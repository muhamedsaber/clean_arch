
import 'package:clean_arch/core/constants.dart';
import 'package:clean_arch/core/helper/url_helper.dart';
import 'package:clean_arch/features/daily_news/data/model/article_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArticleContentSheet extends StatelessWidget {
  const ArticleContentSheet({super.key, required this.model});
  final ArticleModel model;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 700,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
              child: ListView(
            children: [
              Center(
                child: Container(
                  width: 60,
                  height: 6,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  model.urlToImage ?? Constants.kDefaultImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      Constants.kDefaultImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                model.title ?? "No Title",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                model.description ?? "No Description",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _formatDate(model.publishedAt ?? ""),
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black45,
                ),
              ),
              const SizedBox(height: 20),
            ],
          )),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () => launchURL(model.url ?? "", context),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Read More"),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String date) {
    try {
      final DateTime dateTime = DateTime.parse(date);
      return DateFormat.yMMMMd().format(dateTime);
    } catch (e) {
      return "";
    }
  }
}
