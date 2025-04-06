import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_journal/features/journey/data/journey_repository_impl.dart';
import 'package:travel_journal/features/journey/domain/journey_repository.dart';

final journeyRepositoryProvider = Provider<JourneyRepository>((ref) {
  return JourneyRepositoryImpl();
});
