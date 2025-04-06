import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_journal/features/journey/domain/journey_repository.dart';
import 'package:travel_journal/features/journey/domain/models/journey_dto.dart';
import 'package:travel_journal/features/journey/domain/models/journey_model.dart';

class JourneyRepositoryImpl implements JourneyRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'journeys';

  @override
  Future<void> addJourney(JourneyModel journey) async {
    final docRef = _firestore.collection(_collection).doc();
    final journeyWithId = journey.copyWith(id: docRef.id);
    await docRef.set(JourneyDto.toMap(journeyWithId));
  }

  @override
  Future<void> updateJourney(JourneyModel journey) async {
    if (journey.id == null) {
      throw Exception('Journey ID is required for update.');
    }
    await _firestore
        .collection(_collection)
        .doc(journey.id)
        .update(JourneyDto.toMap(journey));
  }

  @override
  Future<void> deleteJourney(String journeyId) async {
    await _firestore.collection(_collection).doc(journeyId).delete();
  }

  @override
  Future<List<JourneyModel>> getUserJourneys(String userId) async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs
        .map((doc) => JourneyDto.fromMap(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<List<JourneyModel>> getPublicJourneys() async {
    final snapshot = await _firestore
        .collection(_collection)
        .where('isPublic', isEqualTo: true)
        .get();

    return snapshot.docs
        .map((doc) => JourneyDto.fromMap(doc.data(), doc.id))
        .toList();
  }
}
