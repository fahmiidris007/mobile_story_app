import 'package:flutter/material.dart';
import 'package:mobile_story_app/data/api/api_service.dart';
import 'package:mobile_story_app/model/story/detail/story_detail.dart';

enum ResultState { loading, noData, hasData, error }

class StoryDetailProvider extends ChangeNotifier {
  late final ApiServices apiServices;
  final String id;

  StoryDetailProvider({required this.apiServices, this.id = ''});

  late StoryDetail _storyDetail;
  ResultState _state = ResultState.loading;
  String _message = '';

  String get message => _message;

  StoryDetail get result => _storyDetail;

  ResultState get state => _state;

  Future<dynamic> fetchStoryDetail(String id) async {
    try {
      notifyListeners();
      final storyDetail = await apiServices.getStoryDetail(id);
      if (storyDetail.error) {
        _state = ResultState.error;
        _message = storyDetail.message;
        notifyListeners();
        return _message;
      } else {
        _state = ResultState.hasData;
        _storyDetail = storyDetail;
        notifyListeners();
        return _storyDetail;
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
      return _message;
    }
  }
}
