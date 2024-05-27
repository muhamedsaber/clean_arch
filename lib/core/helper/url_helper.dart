import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void launchURL(String url, BuildContext context) async {
    final Uri uri = Uri.parse(url);

    try {
      await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not open The Article: $url')),
      );
    }
  }