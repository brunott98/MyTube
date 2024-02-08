import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/video_list_model.dart';

class FavoriteVideosViewModel extends GetxController {

  final RxMap<String, VideoModel> favoriteVideos = <String, VideoModel>{}.obs;

  RxInt favoriteCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void addFavoriteVideo(VideoModel video) {
    favoriteVideos[video.id] = video;
    favoriteCount.value = favoriteVideos.length;
    saveFavorites();
  }

  void removeFavoriteVideo(VideoModel video) {
    favoriteVideos.remove(video.id);
    favoriteCount.value = favoriteVideos.length;
    saveFavorites();
  }

  bool isVideoFavorite(VideoModel video) {
    return favoriteVideos.containsKey(video.id);
  }

  List<VideoModel> getFavoriteVideos() {
    return favoriteVideos.values.toList();
  }

  void toggleFavorite(VideoModel videoModel) {
    videoModel.isFavorited.toggle();

    if (videoModel.isFavorited.isTrue) {
      addFavoriteVideo(videoModel);
    } else {
      removeFavoriteVideo(videoModel);
    }
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getKeys().contains("favorites")) {
      final favoritesList =
          json.decode(prefs.getString("favorites")!) as List<dynamic>;

      favoriteVideos.assignAll(
        { for (var video in favoritesList) VideoModel.fromJsonToVideoModel(video).id : VideoModel.fromJsonToVideoModel(video) },
      );
      favoriteCount.value = favoriteVideos.length;
    }
  }

  Future<void> saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final existingFavorites = prefs.getString("favorites");
    List<Map<String, dynamic>> favoritesList = [];

    if (existingFavorites != null) {
      final dynamic decodedData = json.decode(existingFavorites);
      if (decodedData is List) {
        favoritesList = List<Map<String, dynamic>>.from(decodedData);
      }
    }


    for (var video in favoriteVideos.values) {
      final newFavorite = {
        'id': video.id,
        'title': video.title,
        'thumb': video.thumb,
        'channel': video.channel,
        'isFavorited': video.isFavorited.value,
      };

      final existingVideoIndex = favoritesList.indexWhere((fav) => fav['id'] == newFavorite['id']);

      if (existingVideoIndex != -1) {

        // Se o vídeo já existe, substituimos ele na lista
        favoritesList[existingVideoIndex] = newFavorite;
      } else {

        // Se o vídeo não existe, adicione ele na lista
        favoritesList.add(newFavorite);
      }
    }

    favoritesList.removeWhere((fav) => !favoriteVideos.keys.contains(fav['id']));

    prefs.setString("favorites", json.encode(favoritesList));


  }
}
