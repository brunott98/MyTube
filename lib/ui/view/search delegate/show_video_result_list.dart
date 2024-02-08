import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../model/video_list_model.dart';
import '../../view_model/favorite_videos_view_model.dart';
import '../../view_model/video_list_view_model.dart';

class ShowVideoResultList extends StatelessWidget {
  final VideoListModel videoList;
  final VideoListViewModel videoListViewModel;
  final FavoriteVideosViewModel favoriteVideosViewModel;

  ShowVideoResultList({
    required this.videoList,
    required this.videoListViewModel,
    required this.favoriteVideosViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (notification) {
        if (notification.metrics.pixels >= notification.metrics.maxScrollExtent) {
          videoListViewModel.nextSearch();
        }
        return true;
      },
      child: ListView.builder(
        itemCount: videoList.videoList.length,
        itemBuilder: (context, index) {
          final videoModel = videoList.videoList[index];

          return ListTile(
            title: Text(videoModel.title),
            subtitle: Text(videoModel.channel),
            leading: Image.network(videoModel.thumb),
            trailing: Obx(() {
              final isFavorite = favoriteVideosViewModel.isVideoFavorite(videoModel);
              return IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: isFavorite ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  favoriteVideosViewModel.toggleFavorite(videoModel);
                },
              );
            }),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: SizedBox(
                      height: 300,
                      child: YoutubePlayer(
                        controller: YoutubePlayerController(
                          initialVideoId: videoModel.id,
                          flags: const YoutubePlayerFlags(
                            autoPlay: true,
                            mute: false,
                          ),
                        ),
                        liveUIColor: Colors.amber,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
