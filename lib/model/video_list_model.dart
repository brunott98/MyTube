import 'package:get/get.dart';

class VideoModel {
  final String id;
  final String title;
  final String thumb;
  final String channel;
  final Rx<bool>isFavorited;

  VideoModel({
    required this.id,
    required this.title,
    required this.thumb,
    required this.channel,
    bool isFavorited = false,
  }) : isFavorited = isFavorited.obs;

  factory VideoModel.fromJsonToVideoModel(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'],
      title: map['title'],
      thumb: map['thumb'],
      channel: map['channel'],
      isFavorited: map['isFavorited'] ?? false,
    );
  }

  Map<String, dynamic> fromVideoModelToJson() {
    return {
      'id': id,
      'title': title,
      'thumb': thumb,
      'channel': channel,
      'isFavorited': isFavorited.value,
    };
  }
}

class VideoListModel {
   List<VideoModel> videoList;

  VideoListModel({required this.videoList});
}

class YoutubeApiError{

}