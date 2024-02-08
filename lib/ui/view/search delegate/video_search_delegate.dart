import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytube/ui/view_model/favorite_videos_view_model.dart';
import 'package:mytube/ui/view_model/search_suggestion_view_model.dart';
import '../../view_model/video_list_view_model.dart';
import 'show_video_result_list.dart';

class VideoSearch extends SearchDelegate {
  final SearchSuggestionViewModel _searchSuggestionViewModel =
      Get.put(SearchSuggestionViewModel());

  final VideoListViewModel _videoListViewModel = Get.put(VideoListViewModel());

  final FavoriteVideosViewModel _favoritesViewModel =
      Get.find();

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      _videoListViewModel.firstSearch(query);
    }

    return Obx(() {
      if (_videoListViewModel.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else if (_videoListViewModel.videoListData.value.videoList.isEmpty) {
        return const Center(child: Text("No results found."));
      } else {
        return ShowVideoResultList(
          videoList: _videoListViewModel.videoListData.value,
          videoListViewModel: _videoListViewModel,
          favoriteVideosViewModel: _favoritesViewModel,
        );
      }
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text("Enter a search term"));
    } else {
      _searchSuggestionViewModel.fetchSuggestions(query);
      return Obx(() {
        final suggestionsResults =
            _searchSuggestionViewModel.suggestionListData.value.suggestions;
        if (suggestionsResults.isEmpty) {
          return const Center(child: Text("No suggestions available."));
        } else {
          return ListView.builder(
            itemCount: suggestionsResults.length,
            itemBuilder: (context, index) {
              final suggestionResult = suggestionsResults[index];
              return ListTile(
                title: Text(suggestionResult.suggestionString),
                onTap: () {
                  query = suggestionResult.suggestionString;
                  showResults(context);
                },
              );
            },
          );
        }
      });
    }
  }
}
