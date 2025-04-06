import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_journal/features/auth/controller/auth_controller.dart';
import 'package:travel_journal/features/journey/domain/provider/journey_provider.dart';
import 'package:travel_journal/features/journey/domain/journey_repository.dart';
import 'package:travel_journal/features/journey/domain/models/journey_model.dart';

final journeyControllerProvider =
    StateNotifierProvider<JourneyController, AsyncValue<List<JourneyModel>>>(
  (ref) {
    final repository = ref.watch(journeyRepositoryProvider);
    return JourneyController(ref, repository);
  },
);

class JourneyController extends StateNotifier<AsyncValue<List<JourneyModel>>> {
  final Ref _ref;
  final JourneyRepository _repository;

  JourneyController(this._ref, this._repository)
      : super(const AsyncValue.data([]));

  Future<void> loadUserJourneys() async {
    state = const AsyncValue.loading();
    try {
      final user = _ref.read(authControllerProvider).asData?.value;
      if (user != null) {
        final journeys = await _repository.getUserJourneys(user.uid);
        state = AsyncValue.data(journeys);
      } else {
        state = const AsyncValue.data([]);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addJourney(JourneyModel journey) async {
    try {
      await _repository.addJourney(journey);

      /// Ovdje čuvamo usera samo jednom, bez da izazivamo novi rebuild
      final user = _ref.read(authControllerProvider).asData?.value;
      if (user != null) {
        final journeys = await _repository.getUserJourneys(user.uid);
        state = AsyncValue.data(journeys);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateJourney(JourneyModel journey) async {
    try {
      await _repository.updateJourney(journey);
      await loadUserJourneys(); // reload
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteJourney(String id) async {
    try {
      await _repository.deleteJourney(id);
      await loadUserJourneys(); // reload
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
