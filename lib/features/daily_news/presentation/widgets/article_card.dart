import 'package:clean_arch/core/constants.dart';
import 'package:clean_arch/features/daily_news/data/model/article_model.dart';
import 'package:flutter/material.dart';


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  // Add this for date formatting.

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Add this for date formatting.

class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key, required this.model});
  final ArticleModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: FadeInImage.assetNetwork(
                placeholder: Constants.kLoadingGiff,
                image: model.urlToImage ?? Constants.kDefaultImage,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
                imageErrorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    Constants.kDefaultImage,
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title ?? "",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    model.description ?? "",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDate(model.publishedAt??""),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black45,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate to the full article
                        },
                        child: Text(
                          "Read More",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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

