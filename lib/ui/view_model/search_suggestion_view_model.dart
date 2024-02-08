import 'package:get/get.dart';
import 'package:mytube/data/api/googlesuggestions/google_suggestions_api_repo.dart';
import 'package:mytube/model/suggestion_list_model.dart';
import 'package:mytube/ui/view/error/api_error_ui.dart';

class SearchSuggestionViewModel extends GetxController {

  final _googleSuggestionsRepo = GoogleSuggestionsApiRepo();
  final suggestionListData = SuggestionListModel(suggestions: []).obs;


  Future<void> fetchSuggestions(String search) async {
    try {

      suggestionListData.value = await _googleSuggestionsRepo.youtubeGoogleSearchSuggestion(search);

    } catch (e) {

      GoogleSuggestionErrorUI.showErrorDialog(Get.overlayContext!);

    }
  }

}




