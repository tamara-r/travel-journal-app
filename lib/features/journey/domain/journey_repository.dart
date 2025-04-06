import 'package:travel_journal/features/journey/domain/models/journey_model.dart';

abstract class JourneyRepository {
  Future<void> addJourney(JourneyModel journey);
  Future<void> updateJourney(JourneyModel journey);
  Future<void> deleteJourney(String journeyId);
  Future<List<JourneyModel>> getUserJourneys(String userId);
  Future<List<JourneyModel>> getPublicJourneys(); // za home feed
}
