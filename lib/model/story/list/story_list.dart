import 'dart:convert';

class StoryList {
  bool error;
  String message;
  List<ListStory> listStory;

  StoryList({
    required this.error,
    required this.message,
    required this.listStory,
  });

  factory StoryList.fromMap(data) {
    return StoryList(
      error: data['error'],
      message: data['message'],
      listStory: List<ListStory>.from(data['listStory'].map((x) => ListStory.fromMap(x))),
    );
  }

  factory StoryList.fromJson(Map<String, dynamic> json) {
    return StoryList(
      error: json['error'],
      message: json['message'],
      listStory: List<ListStory>.from(json['listStory'].map((x) => ListStory.fromJson(x))),
    );
  }

}

class ListStory {
  String id;
  String name;
  String description;
  String photoUrl;
  DateTime createdAt;
  double lat;
  double lon;

  ListStory({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.lat,
    required this.lon,
  });

  ListStory copyWith({
    String? id,
    String? name,
    String? description,
    String? photoUrl,
    DateTime? createdAt,
    double? lat,
    double? lon,
  }) {
    return ListStory(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'photoUrl': photoUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'lat': lat,
      'lon': lon,
    };
  }

  factory ListStory.fromMap(Map<String, dynamic>map){
    return ListStory(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      photoUrl: map['photoUrl'],
      createdAt: DateTime.parse(map['createdAt']),
      lat: map['lat'],
      lon: map['lon'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ListStory.fromJson(Map<String, dynamic> json){
    return ListStory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      photoUrl: json['photoUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      lat: json['lat'] ?? 0.0,
      lon: json['lon'] ?? 0.0,
    );
  }

  @override
  String toString() {
    return 'ListStory(id: $id, name: $name, description: $description, photoUrl: $photoUrl, createdAt: $createdAt, lat: $lat, lon: $lon)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ListStory &&
      other.id == id &&
      other.name == name &&
      other.description == description &&
      other.photoUrl == photoUrl &&
      other.createdAt == createdAt &&
      other.lat == lat &&
      other.lon == lon;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      description.hashCode ^
      photoUrl.hashCode ^
      createdAt.hashCode ^
      lat.hashCode ^
      lon.hashCode;
  }
}
