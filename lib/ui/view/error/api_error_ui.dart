import 'package:flutter/material.dart';
import 'package:mytube/ui/view/error/error_constants_ui.dart';

class YoutubeErrorUI {
  static void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(YoutubeApiErrorUi.error),
        content: const Text(YoutubeApiErrorUi.failedToLoadVideos),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(YoutubeApiErrorUi.confirmation),
          ),
        ],
      ),
    );
  }
}

class GoogleSuggestionErrorUI {
  static void showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(GoogleSuggestionApiErrorUi.error),
        content: const Text(GoogleSuggestionApiErrorUi.failedToFetch),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(GoogleSuggestionApiErrorUi.confirmation),
          ),
        ],
      ),
    );
  }
}
