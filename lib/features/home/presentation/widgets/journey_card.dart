import 'package:flutter/material.dart';
import 'package:travel_journal/config/theme/app_text_styles.dart';
import 'package:travel_journal/features/journey/domain/models/journey_model.dart';

class JourneyCard extends StatelessWidget {
  final JourneyModel journey;
  final VoidCallback onTap;

  const JourneyCard({
    super.key,
    required this.journey,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Featured image
          journey.featuredImage.startsWith('http')
              ? Image.network(
                  journey.featuredImage,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  journey.featuredImage,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  journey.title,
                  style: AppTextStyles.titleLarge
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Place + icon
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 18),
                    const SizedBox(width: 4),
                    Text(journey.place, style: AppTextStyles.bodyMedium),
                  ],
                ),
                const SizedBox(height: 16),
                // Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: journey.tags
                      .map((tag) => Chip(label: Text(tag)))
                      .toList(),
                ),
                const SizedBox(height: 8),

                // View Details button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: onTap,
                    label: const Text("View Details"),
                    style: TextButton.styleFrom(
                      foregroundColor: theme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
