import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:mobile_story_app/common.dart';
import 'package:mobile_story_app/data/api/api_service.dart';
import 'package:mobile_story_app/model/story/add/add_story.dart';

enum ResultState { loading, noData, hasData, error }

class AddStoryProvider extends ChangeNotifier {
  late final ApiServices apiServices;
  String? imagePath;
  XFile? imageFile;
  bool isUploading = false;
  double? lat;
  double? lon;
  BuildContext? context;

  AddStoryProvider({required this.apiServices});

  late AddStory? addStory;
  late ResultState _state = ResultState.loading;
  String _message = '';

  String get message => _message;

  AddStory? get result => addStory;

  ResultState get state => _state;

  Future<dynamic> postStory(
      String description, List<int> photo, double? lat, double? lon) async {
    try {
      isUploading = true;
      addStory = const AddStory(error: false, message: '');
      notifyListeners();
      final story = await apiServices.postStory(description, photo, lat!, lon!);
      if (story.error) {
        _state = ResultState.error;
        _message = AppLocalizations.of(context!)!.errorUploud;
        notifyListeners();
        return _message;
      } else {
        _state = ResultState.hasData;
        addStory = story;
        _message = AppLocalizations.of(context!)!.successUploud;
        notifyListeners();
        return addStory;
      }
    } catch (e) {}
  }

  Future<List<int>> compressImage(List<int> bytes) async {
    int imageLength = bytes.length;
    if (imageLength < 1000000) return bytes;
    final img.Image image = img.decodeImage(Uint8List.fromList(bytes))!;
    int compressQuality = 100;
    int length = imageLength;
    List<int> newByte = [];
    do {
      compressQuality -= 10;
      newByte = img.encodeJpg(
        image,
        quality: compressQuality,
      );
      length = newByte.length;
    } while (length > 1000000);
    return newByte;
  }

  void setImageFile(XFile? value) {
    imageFile = value;
    notifyListeners();
  }

  void setImagePath(String? value) {
    imagePath = value;
    notifyListeners();
  }

  //todo: set location
  void setLocation(double lat, double lon) {
    this.lat = lat;
    this.lon = lon;
    notifyListeners();
  }
}
