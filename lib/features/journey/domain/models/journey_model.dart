class JourneyModel {
  final String? id;
  final String title;
  final String description;
  final String country;
  final String place;
  final List<String> tags;
  final String featuredImage;
  final List<String> gallery;
  final bool isPublic;
  final String userId;
  final String? authorName;
  final Map<String, dynamic>? map;

  JourneyModel({
    this.id,
    required this.title,
    required this.description,
    required this.country,
    required this.place,
    required this.tags,
    required this.featuredImage,
    required this.gallery,
    required this.isPublic,
    required this.userId,
    this.authorName,
    this.map,
  });

  JourneyModel copyWith({
    String? id,
    String? title,
    String? description,
    String? country,
    String? place,
    List<String>? tags,
    String? featuredImage,
    List<String>? gallery,
    bool? isPublic,
    String? userId,
    String? authorName,
    Map<String, dynamic>? map,
  }) {
    return JourneyModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      country: country ?? this.country,
      place: place ?? this.place,
      tags: tags ?? this.tags,
      featuredImage: featuredImage ?? this.featuredImage,
      gallery: gallery ?? this.gallery,
      isPublic: isPublic ?? this.isPublic,
      userId: userId ?? this.userId,
      authorName: authorName ?? this.authorName,
      map: map ?? this.map,
    );
  }
}
