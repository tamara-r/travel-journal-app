import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_journal/core/routes/app_routes.dart';
import 'package:travel_journal/features/auth/controller/auth_controller.dart';
import 'package:travel_journal/features/home/domain/utils/journeys_by_continent.dart';
import 'package:travel_journal/features/home/presentation/widgets/journey_card.dart';
import 'package:travel_journal/features/journey/domain/provider/journey_list_provider.dart';
import 'package:travel_journal/features/journey/presentation/screens/journey_details_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final journeysAsync = ref.watch(journeyListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Travel Journal"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(authControllerProvider.notifier).logout();
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
          ),
        ],
      ),
      body: journeysAsync.when(
        data: (journeys) {
          if (journeys.isEmpty) {
            return const Center(child: Text("No journeys yet."));
          }

          final grouped = groupJourneysByContinent(journeys);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: grouped.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(entry.key,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  ...entry.value.map((journey) => JourneyCard(
                        journey: journey,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  JourneyDetailsScreen(journey: journey),
                            ),
                          );
                        },
                      )),
                  const SizedBox(height: 24),
                ],
              );
            }).toList(),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }
}
