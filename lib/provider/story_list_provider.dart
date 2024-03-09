import 'package:flutter/material.dart';
import 'package:mobile_story_app/data/api/api_service.dart';
import 'package:mobile_story_app/model/story/list/story_list.dart';

enum ResultStateList { loading, noData, hasData, error }

class StoryListProvider extends ChangeNotifier {
  late final ApiServices apiServices;
  int? pageItems = 1;
  int sizeItems = 10;

  StoryListProvider({required this.apiServices}) {
    fetchAllStory();
  }

  List<ListStory> storyList = [];

  String _message = '';
  ResultStateList _state = ResultStateList.loading;

  String get message => _message;

  ResultStateList get state => _state;

  Future<dynamic> fetchAllStory() async {
    try {
      if (pageItems == 1) {
        _state = ResultStateList.loading;
        notifyListeners();
      }
      if (pageItems != null) {
        final result = await apiServices.getStoryList(pageItems!, sizeItems);
        if (result.listStory.isEmpty) {
          _state = ResultStateList.noData;
          _message = 'Data is empty';
          notifyListeners();
        } else {
          storyList.addAll(result.listStory);
          _state = ResultStateList.hasData;
          if (result.listStory.length < sizeItems) {
            pageItems = null;
          } else {
            pageItems = pageItems! + 1;
          }
          notifyListeners();
        }
      }
    } catch (e) {
      _state = ResultStateList.error;
      _message = 'Error $e';
    }
    notifyListeners();
  }

  Future<dynamic> refreshAllStory() async {
    try {
      _state = ResultStateList.loading;
      notifyListeners();
      final result = await apiServices.getStoryList(1, sizeItems);
      if (result.listStory.isEmpty) {
        _state = ResultStateList.noData;
        _message = 'Data is empty';
        notifyListeners();
      } else {
        storyList = result.listStory;
        _state = ResultStateList.hasData;
        pageItems = 2;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultStateList.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }
}
