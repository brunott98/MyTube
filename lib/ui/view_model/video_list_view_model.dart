import 'package:get/get.dart';
import 'package:mytube/ui/view/error/api_error_ui.dart';
import 'package:mytube/data/api/youtube/youtube_api_repo.dart';
import 'package:mytube/model/video_list_model.dart';

class VideoListViewModel extends GetxController {

  final YouTubeApiRepo _apiRepo = YouTubeApiRepo();

  final videoListData = VideoListModel(videoList: []).obs;
  var isLoading = false.obs;

  void firstSearch(String query) async {
    try {
      isLoading.value = true;
      final result = await _apiRepo.firstSearch(query);
      videoListData.value = VideoListModel(videoList: result.videoList);
    } catch (e) {
      YoutubeErrorUI.showErrorDialog(Get.overlayContext!);
    } finally {
      isLoading.value = false;
    }
  }

  void nextSearch() async {
    try {
      isLoading.value = true;
      final result = await _apiRepo.nextSearch();

      videoListData.update((value) {
        value?.videoList += result.videoList;
      });

    } catch (e) {
      YoutubeErrorUI.showErrorDialog(Get.overlayContext!);
    } finally {
      isLoading.value = false;
    }
  }

}
