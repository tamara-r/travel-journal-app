import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_journal/features/journey/controller/journey_controller.dart';
import 'package:travel_journal/features/journey/domain/models/journey_model.dart';
import 'package:travel_journal/features/journey/domain/provider/journey_list_provider.dart';
import 'package:travel_journal/features/journey/presentation/screens/journey_details_screen.dart';
import 'package:travel_journal/features/journey/presentation/widgets/journey_form_widget.dart';

class AddJourneyScreen extends ConsumerStatefulWidget {
  const AddJourneyScreen({super.key});

  @override
  ConsumerState<AddJourneyScreen> createState() => _AddJourneyScreenState();
}

class _AddJourneyScreenState extends ConsumerState<AddJourneyScreen> {
  final _titleController = TextEditingController();
  final _countryController = TextEditingController();
  final _placeController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagsController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _countryController.dispose();
    _placeController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Journey")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            Image.asset(
              'assets/images/map.png',
              height: 180,
            ),
            const SizedBox(height: 24),
            JourneyForm(
              onSubmit: _handleSubmit,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmit(JourneyModel journey) async {
    final controller = ref.read(journeyControllerProvider.notifier);

    try {
      await controller.addJourney(journey);

      ref.invalidate(journeyListProvider);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Journey successfully added")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => JourneyDetailsScreen(journey: journey),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add journey: $e")),
      );
    }
  }
}
