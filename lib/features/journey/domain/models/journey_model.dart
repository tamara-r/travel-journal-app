class JourneyModel {
  final String id;
  final String title;
  final String country;
  final String? place; // opcionalno ako želiš dodatnu preciznost
  final String description;
  final List<String> tags;
  final String featuredImage;
  final List<String> gallery;
  final bool isPublic;
  final Map<String, dynamic>
      location; // možeš kasnije zameniti konkretnom klasom

  JourneyModel({
    required this.id,
    required this.title,
    required this.country,
    this.place,
    required this.description,
    required this.tags,
    required this.featuredImage,
    required this.gallery,
    required this.isPublic,
    required this.location,
  });

  factory JourneyModel.fromMap(Map<String, dynamic> map, String documentId) {
    return JourneyModel(
      id: documentId,
      title: map['title'] ?? '',
      country: map['country'] ?? '',
      place: map['place'],
      description: map['description'] ?? '',
      tags: List<String>.from(map['tags'] ?? []),
      featuredImage: map['featuredImage'] ?? '',
      gallery: List<String>.from(map['gallery'] ?? []),
      isPublic: map['isPublic'] ?? false,
      location: map['location'] ?? {},
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'country': country,
      'place': place,
      'description': description,
      'tags': tags,
      'featuredImage': featuredImage,
      'gallery': gallery,
      'isPublic': isPublic,
      'location': location,
    };
  }
}
