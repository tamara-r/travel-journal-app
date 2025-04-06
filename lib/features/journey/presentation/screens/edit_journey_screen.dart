import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_journal/features/journey/controller/journey_controller.dart';
import 'package:travel_journal/features/journey/domain/models/journey_model.dart';
import 'package:travel_journal/features/journey/domain/provider/journey_list_provider.dart';
import 'package:travel_journal/features/journey/presentation/widgets/journey_form_widget.dart';

class EditJourneyScreen extends ConsumerStatefulWidget {
  final JourneyModel journey;

  const EditJourneyScreen({super.key, required this.journey});

  @override
  ConsumerState<EditJourneyScreen> createState() => _EditJourneyScreenState();
}

class _EditJourneyScreenState extends ConsumerState<EditJourneyScreen> {
  bool _isLoading = false;

  Future<void> _handleUpdate(JourneyModel updatedJourney) async {
    setState(() => _isLoading = true);

    try {
      await ref
          .read(journeyControllerProvider.notifier)
          .updateJourney(updatedJourney);

      ref.invalidate(journeyListProvider);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Journey updated successfully")),
      );

      Navigator.pop(context);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update journey: $e")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Journey")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: JourneyForm(
          initialJourney: widget.journey,
          onSubmit: _handleUpdate,
          isLoading: _isLoading,
          submitLabel: 'Update',
        ),
      ),
    );
  }
}
