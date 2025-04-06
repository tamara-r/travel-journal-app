import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_journal/features/auth/controller/auth_controller.dart';
import 'package:travel_journal/core/routes/app_routes.dart';
import 'package:travel_journal/features/journey/domain/provider/journey_list_provider.dart';
import 'package:travel_journal/features/journey/presentation/screens/journey_details_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final journeysAsync = ref.watch(journeyListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
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

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: journeys.length,
            itemBuilder: (context, index) {
              final journey = journeys[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      journey.featuredImage,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(journey.title),
                  subtitle: Text('${journey.place}, ${journey.country}'),
                  trailing:
                      const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => JourneyDetailsScreen(journey: journey),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
      ),
    );
  }
}
