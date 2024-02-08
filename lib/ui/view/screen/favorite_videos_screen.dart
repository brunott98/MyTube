import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../view_model/favorite_videos_view_model.dart';

class FavoriteVideosScreen extends StatelessWidget {

  final FavoriteVideosViewModel favoriteVideosViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Videos'),
      ),
      body: FavoriteVideosList(favoriteVideosViewModel: favoriteVideosViewModel),
    );
  }
}

class FavoriteVideosList extends StatelessWidget {
  final FavoriteVideosViewModel favoriteVideosViewModel;

  const FavoriteVideosList({super.key, required this.favoriteVideosViewModel});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final favoriteVideos = favoriteVideosViewModel.getFavoriteVideos();

      if (favoriteVideos.isEmpty) {
        return const Center(child: Text('No favorite videos.'));
      }

      return ListView.builder(
        itemCount: favoriteVideos.length,
        itemBuilder: (context, index) {
          final videoModel = favoriteVideos[index];

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
      );
    });
  }
}
