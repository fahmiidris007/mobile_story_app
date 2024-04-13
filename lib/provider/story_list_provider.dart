import 'package:flutter/material.dart';
import 'package:mobile_story_app/data/api/api_service.dart';
import 'package:mobile_story_app/model/story/list/story_list.dart';

enum ResultStateList { loading, noData, hasData, error }

class StoryListProvider extends ChangeNotifier{
  late final ApiServices apiServices;

  StoryListProvider({required this.apiServices}){
    fetchAllStory();
  }

  late StoryList _storyList;
  String _message = '';
  ResultStateList _state = ResultStateList.loading;

  String get message => _message;
  StoryList get result => _storyList;
  ResultStateList get state => _state;

  Future<dynamic> fetchAllStory() async {
    try {
      _state = ResultStateList.loading;
      notifyListeners();
      final story = await apiServices.getStoryList();
      if (story.listStory.isEmpty) {
        _state = ResultStateList.noData;
        notifyListeners();
        return _message = 'No Data';
      } else {
        _state = ResultStateList.hasData;
        notifyListeners();
        return _storyList = story;
      }
    } catch (e) {
      _state = ResultStateList.error;
      notifyListeners();
      return _message = 'Error $e';
    }
  }
}