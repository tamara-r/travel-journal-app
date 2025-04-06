import 'package:travel_journal/features/journey/domain/models/journey_model.dart';

class JourneyDto {
  static Map<String, dynamic> toMap(JourneyModel journey) {
    final map = <String, dynamic>{
      'title': journey.title,
      'description': journey.description,
      'country': journey.country,
      'place': journey.place,
      'isPublic': journey.isPublic,
      'userId': journey.userId,
    };

    if (journey.tags.isNotEmpty) map['tags'] = journey.tags;
    if (journey.gallery.isNotEmpty) map['gallery'] = journey.gallery;
    if (journey.featuredImage.isNotEmpty) {
      map['featuredImage'] = journey.featuredImage;
    }
    if (journey.map != null && journey.map!.isNotEmpty) {
      map['map'] = journey.map;
    }

    return map;
  }

  static JourneyModel fromMap(Map<String, dynamic> map, String docId) {
    return JourneyModel(
      id: docId,
      title: map['title'],
      description: map['description'],
      country: map['country'],
      place: map['place'],
      tags: List<String>.from(map['tags'] ?? []),
      featuredImage: map['featuredImage'] ?? '',
      gallery: List<String>.from(map['gallery'] ?? []),
      isPublic: map['isPublic'],
      userId: map['userId'],
      map: map['map'] ?? {},
    );
  }
}
