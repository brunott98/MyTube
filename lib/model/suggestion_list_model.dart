class SuggestionModel {
  final String suggestionString;

  SuggestionModel({
    required this.suggestionString,
  });

}

class SuggestionListModel {
  final List<SuggestionModel> suggestions;

  SuggestionListModel({
    required this.suggestions,
  });
}

class SuggestionApiError {}
