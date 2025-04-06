import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:travel_journal/common/widgets/custom_button.dart';
import 'package:travel_journal/common/widgets/custom_text_area.dart';
import 'package:travel_journal/common/widgets/custom_text_field.dart';
import 'package:travel_journal/core/utils/form_validators.dart';
import 'package:travel_journal/features/auth/controller/auth_controller.dart';
import 'package:travel_journal/features/journey/data/country_details_service.dart';
import 'package:travel_journal/features/journey/domain/models/country_model.dart';
import 'package:travel_journal/features/journey/domain/models/journey_model.dart';
import 'package:travel_journal/features/journey/presentation/widgets/country_picker_field.dart';
import 'package:travel_journal/features/journey/presentation/widgets/tags_input_widget.dart';

class JourneyForm extends ConsumerStatefulWidget {
  final JourneyModel? initialJourney;
  final void Function(JourneyModel journey) onSubmit;
  final bool isLoading;
  final String submitLabel;

  const JourneyForm({
    super.key,
    this.initialJourney,
    required this.onSubmit,
    this.isLoading = false,
    this.submitLabel = 'Submit',
  });

  @override
  ConsumerState<JourneyForm> createState() => _JourneyFormState();
}

class _JourneyFormState extends ConsumerState<JourneyForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _placeController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<String> _tags = [];
  CountryModel? _selectedCountry;
  bool _isPublic = false;

  @override
  void initState() {
    super.initState();
    final j = widget.initialJourney;
    if (j != null) {
      _titleController.text = j.title;
      _placeController.text = j.place;
      _descriptionController.text = j.description;
      _tags = j.tags;
      _isPublic = j.isPublic;
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedCountry == null && widget.initialJourney?.map == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a country")),
      );
      return;
    }

    final journey = JourneyModel(
      id: widget.initialJourney?.id,
      title: _titleController.text.trim(),
      country: _selectedCountry?.name ?? widget.initialJourney?.country ?? '',
      place: _placeController.text.trim(),
      description: _descriptionController.text.trim(),
      tags: _tags,
      featuredImage: 'assets/images/demo_featured_image.jpg',
      gallery: [
        'assets/images/demo_gallery_1.jpg',
        'assets/images/demo_gallery_2.jpg',
        'assets/images/demo_gallery_3.jpg',
        'assets/images/demo_gallery_4.jpg',
        'assets/images/demo_gallery_5.jpg',
        'assets/images/demo_gallery_6.jpg',
        'assets/images/demo_gallery_7.jpg',
      ],
      isPublic: _isPublic,
      userId: widget.initialJourney?.userId ??
          ref.read(authControllerProvider).value?.uid ??
          '',
      map: _selectedCountry != null
          ? {
              'continent': _selectedCountry?.region,
              'subregion': _selectedCountry?.subregion,
              'code': _selectedCountry?.code,
              'capital': _selectedCountry?.capital,
              'flag': _selectedCountry?.flagUrl,
              'map': _selectedCountry?.mapUrl,
              'currency': _selectedCountry?.currency,
              'languages': _selectedCountry?.languages,
              'authorName':
                  ref.read(authControllerProvider).value?.fullName ?? '',
            }
          : widget.initialJourney?.map,
    );

    widget.onSubmit(journey);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextField(
            label: "Title",
            controller: _titleController,
            validator: (v) => FormValidators.validateRequiredField(v, "Title"),
          ),
          const SizedBox(height: 16),
          CountryPickerField(
            selectedCountry: _selectedCountry?.name,
            onSelect: (country) async {
              final details =
                  await CountryDetailsService.fetchByCode(country.countryCode);

              setState(() {
                _selectedCountry = details;
              });
            },
          ),
          const SizedBox(height: 16),
          CustomTextField(
            label: "Place",
            controller: _placeController,
            validator: (v) => FormValidators.validateRequiredField(v, "Place"),
          ),
          const SizedBox(height: 16),
          CustomTextArea(
            label: "Description",
            controller: _descriptionController,
            maxLines: 4,
            validator: (v) =>
                FormValidators.validateRequiredField(v, "Description"),
          ),
          const SizedBox(height: 24),
          TagsInput(
            initialTags: _tags,
            onChanged: (updated) => setState(() => _tags = updated),
          ),
          const SizedBox(height: 24),
          SwitchListTile(
            value: _isPublic,
            onChanged: (value) => setState(() => _isPublic = value),
            title: const Text("Make this journey public"),
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: widget.submitLabel,
            isLoading: widget.isLoading,
            onPressed: widget.isLoading ? null : _submit,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _placeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
