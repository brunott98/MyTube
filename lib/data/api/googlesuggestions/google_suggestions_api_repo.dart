import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mytube/model/suggestion_list_model.dart';

class GoogleSuggestionsApiRepo {

  static final GoogleSuggestionsApiRepo _instance = GoogleSuggestionsApiRepo._internal();

  factory GoogleSuggestionsApiRepo() {
    return _instance;
  }

  GoogleSuggestionsApiRepo._internal();

  Future<SuggestionListModel> youtubeGoogleSearchSuggestion(String search) async {
    final Uri uri = Uri.parse("http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json");
    final http.Response response = await http.get(uri);


    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final SuggestionListModel suggestionList = _parseSuggestionListModel(responseData);

      return suggestionList;

    } else {
      throw SuggestionApiError();
    }
  }

  SuggestionListModel _parseSuggestionListModel(List<dynamic> json) {
    final List<SuggestionModel> suggestions = (json[1] as List<dynamic>?)
        ?.map<SuggestionModel>((dynamic item) {
      final String suggestion = item[0] as String;
      return SuggestionModel(suggestionString: suggestion);
    })
        .toList() ??
        [];

    return SuggestionListModel(suggestions: suggestions);
  }

}
