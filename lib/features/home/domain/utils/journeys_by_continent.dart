import 'package:travel_journal/features/journey/domain/models/journey_model.dart';

Map<String, List<JourneyModel>> groupJourneysByContinent(
    List<JourneyModel> journeys) {
  final sorted = journeys.toList()
    ..sort((a, b) =>
        (a.map?['continent'] ?? '').compareTo(b.map?['continent'] ?? ''));

  final grouped = <String, List<JourneyModel>>{};

  for (final journey in sorted) {
    final continent = journey.map?['continent'] ?? 'Unknown';
    grouped.putIfAbsent(continent, () => []).add(journey);
  }

  return grouped;
}
