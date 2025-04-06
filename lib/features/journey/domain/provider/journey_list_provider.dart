import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_journal/features/journey/domain/models/journey_model.dart';

final journeyListProvider = FutureProvider<List<JourneyModel>>((ref) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('journeys')
      .orderBy('title')
      .get();

  return snapshot.docs.map((doc) {
    final data = doc.data();

    return JourneyModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      country: data['country'] ?? '',
      place: data['place'] ?? '',
      tags: List<String>.from(data['tags'] ?? []),
      featuredImage: data['featuredImage'] ?? '',
      gallery: List<String>.from(data['gallery'] ?? []),
      isPublic: data['isPublic'] ?? false,
      userId: data['userId'] ?? '',
      map: data['map'] != null ? Map<String, dynamic>.from(data['map']) : null,
    );
  }).toList();
});
