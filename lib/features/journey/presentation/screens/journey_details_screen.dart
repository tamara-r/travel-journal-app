import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_journal/common/widgets/confirm_dialog.dart';
import 'package:travel_journal/config/theme/app_text_styles.dart';
import 'package:travel_journal/features/auth/controller/auth_controller.dart';
import 'package:travel_journal/features/auth/domain/provider/user_provider.dart';
import 'package:travel_journal/features/journey/controller/journey_controller.dart';
import 'package:travel_journal/features/journey/domain/models/journey_model.dart';
import 'package:travel_journal/features/journey/domain/provider/journey_list_provider.dart';
import 'package:travel_journal/features/journey/presentation/screens/edit_journey_screen.dart';
import 'package:travel_journal/features/journey/presentation/widgets/image_gallery_slider.dart';
import 'package:url_launcher/url_launcher.dart';

class JourneyDetailsScreen extends ConsumerWidget {
  final JourneyModel journey;

  const JourneyDetailsScreen({super.key, required this.journey});

  void _openMap(String? url) async {
    if (url != null && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(journey.title),
        actions: [
          Consumer(
            builder: (context, ref, _) {
              final currentUser = ref.watch(authControllerProvider).value;
              if (currentUser?.uid != journey.userId) return const SizedBox();

              return PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditJourneyScreen(journey: journey),
                      ),
                    );
                  } else if (value == 'delete') {
                    _showDeleteDialog(context, ref);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text('Edit')),
                  const PopupMenuItem(value: 'delete', child: Text('Delete')),
                ],
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _buildImage(
                journey.featuredImage,
                height: 400,
                width: double.infinity,
              ),
            ),

            const SizedBox(height: 16),

            // Location + flag
            Row(
              children: [
                Icon(Icons.location_on_outlined,
                    size: 20, color: theme.primaryColor),
                const SizedBox(width: 4),
                Text(
                  '${journey.place}, ${journey.country}',
                  style: AppTextStyles.bodyMedium,
                ),
                const Spacer(),
                if (journey.map?['flag'] != null)
                  Image.network(
                    journey.map!['flag'],
                    height: 20,
                    width: 28,
                    fit: BoxFit.cover,
                  )
              ],
            ),

            const SizedBox(height: 6),

            // Author
            if (journey.userId.isNotEmpty)
              Consumer(
                builder: (context, ref, _) {
                  final authorAsync =
                      ref.watch(userByIdProvider(journey.userId));
                  return authorAsync.when(
                    data: (user) => Text(
                      user != null ? 'by ${user.fullName}' : '',
                      style: AppTextStyles.bodyMedium.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                    loading: () => const SizedBox(
                        height: 20, child: CircularProgressIndicator()),
                    error: (e, _) => const Text('by Unknown'),
                  );
                },
              ),

            const SizedBox(height: 16),

            // Info icons only
            Wrap(
              spacing: 16,
              runSpacing: 12,
              children: [
                if (journey.map?['capital'] != null)
                  _infoIcon(
                    context,
                    Icons.account_balance_outlined,
                    journey.map!['capital'],
                  ),
                if (journey.map?['currency'] != null)
                  _infoIcon(
                    context,
                    Icons.attach_money_outlined,
                    journey.map!['currency'],
                  ),
                if (journey.map?['languages'] != null)
                  _infoIcon(
                    context,
                    Icons.language_outlined,
                    (journey.map!['languages'] as List).join(', '),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            if (journey.map?['map'] != null)
              TextButton.icon(
                onPressed: () => _openMap(journey.map!['map']),
                icon: Icon(Icons.map_outlined, color: theme.primaryColor),
                label: Text(
                  "View on Google Maps",
                  style: TextStyle(color: theme.primaryColor),
                ),
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  backgroundColor: WidgetStateProperty.all(Colors.transparent),
                  surfaceTintColor: WidgetStateProperty.all(Colors.transparent),
                  shadowColor: WidgetStateProperty.all(Colors.transparent),
                  foregroundColor: WidgetStateProperty.all(theme.primaryColor),
                ),
              ),

            const Divider(height: 32),

            // Description
            Text(journey.description, style: AppTextStyles.bodyMedium),

            const SizedBox(height: 16),

            // Tags
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  journey.tags.map((tag) => Chip(label: Text(tag))).toList(),
            ),

            const SizedBox(height: 24),

            // Gallery title
            Text(
              'Gallery',
              style:
                  AppTextStyles.titleLarge.copyWith(color: theme.primaryColor),
            ),

            const SizedBox(height: 12),

            // Gallery images
            SizedBox(
              height: 100,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: journey.gallery.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final imageUrl = journey.gallery[index];
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => ImageGallerySlider(
                          images: journey.gallery,
                          initialIndex: index,
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _buildImage(imageUrl, height: 100, width: 100),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoIcon(BuildContext context, IconData icon, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: Theme.of(context).primaryColor),
        const SizedBox(width: 6),
        Text(value, style: AppTextStyles.bodyMedium),
      ],
    );
  }

  Widget _buildImage(String path, {double? height, double? width}) {
    final isNetwork = path.startsWith('http') || path.startsWith('https');
    return isNetwork
        ? Image.network(
            path,
            height: height,
            width: width,
            fit: BoxFit.cover,
          )
        : Image.asset(
            path,
            height: height,
            width: width,
            fit: BoxFit.cover,
          );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => ConfirmDialog(
        title: 'Delete Journey',
        message: 'Are you sure you want to delete this journey?',
        onConfirm: () async {
          await ref
              .read(journeyControllerProvider.notifier)
              .deleteJourney(journey.id!);

          ref.invalidate(journeyListProvider);

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Journey deleted successfully'),
                duration: const Duration(seconds: 2),
              ),
            );

            Navigator.pop(context); // Close the dialog

            Navigator.of(context).pushNamedAndRemoveUntil(
              '/home',
              (route) => false,
            );
          }
        },
      ),
    );
  }
}
