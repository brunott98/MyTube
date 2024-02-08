import 'package:http/http.dart' as http;
import 'package:mytube/data/api/youtube/my_key.dart';
import 'package:mytube/model/video_list_model.dart';
import 'dart:convert';

class YouTubeApiRepo {
  static final YouTubeApiRepo _instance = YouTubeApiRepo._internal();

  factory YouTubeApiRepo() {
    return _instance;
  }

  YouTubeApiRepo._internal();

  String _nextPageToken = '';
  late String _search;


  Future<VideoListModel> firstSearch(String search) async {

    _search =  search;

    final uri = Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$apiKey&maxResults=10");

    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final List<VideoModel> videos =
          (data['items'] as List<dynamic>?)?.map<VideoModel>((item) {
            final snippet = item['snippet'];
            return VideoModel(
              id: item['id']['videoId'] ?? '',
              title: snippet['title'] ?? '',
              thumb: snippet['thumbnails']['high']['url'] ?? '',
              channel: snippet['channelTitle'] ?? '',
            );
          }).toList() ??
              [];

      _nextPageToken = data['nextPageToken'] ?? '';

      return VideoListModel(videoList: videos);
    } else {
      throw YoutubeApiError();
    }
  }

  Future<VideoListModel> nextSearch() async {
    if (_nextPageToken.isEmpty) {
      return VideoListModel(videoList: []);
    }

    final uri = Uri.parse(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$apiKey&maxResults=10&pageToken=$_nextPageToken");

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      final List<VideoModel> videos =
          (data['items'] as List<dynamic>?)?.map<VideoModel>((item) {
            final snippet = item['snippet'];
            return VideoModel(
              id: item['id']['videoId'] ?? '',
              title: snippet['title'] ?? '',
              thumb: snippet['thumbnails']['high']['url'] ?? '',
              channel: snippet['channelTitle'] ?? '',
            );
          }).toList() ??
              [];

      _nextPageToken = data['nextPageToken'] ?? '';


      return VideoListModel(videoList: videos);
    } else {
      throw YoutubeApiError();
    }
  }





}
