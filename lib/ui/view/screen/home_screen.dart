import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mytube/ui/theme/themes.dart';
import '../../view_model/favorite_videos_view_model.dart';
import '../search delegate/video_search_delegate.dart';
import 'favorite_videos_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final FavoriteVideosViewModel favoriteVideosViewModel = Get.put(FavoriteVideosViewModel());


    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          SizedBox(
            width: 50,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Obx(() => Positioned(
                  left: 0,
                  child: Text(
                    favoriteVideosViewModel.favoriteCount.value.toString(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                )),
                Positioned(
                  right: 0,
                  child: IconButton(
                    onPressed: () {

                      Get.to(() => FavoriteVideosScreen(),
                      transition: Transition.leftToRight);

                    },
                    icon: const Icon(Icons.star),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {
                showSearch(context: context, delegate: VideoSearch());
              },
              icon: const Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topLeft,
            colors: [
              AppColors.accentColor2,
              AppColors.accentColor2,
              Colors.black87,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
              Colors.black,
            ],
          ),
        ),
        child: const SizedBox(
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
