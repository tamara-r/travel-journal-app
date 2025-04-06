import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class CountryPickerField extends StatelessWidget {
  final String? selectedCountry;
  final void Function(Country country) onSelect;

  const CountryPickerField({
    super.key,
    required this.selectedCountry,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: () {
        showCountryPicker(
          context: context,
          showPhoneCode: false,
          onSelect: onSelect,
        );
      },
      decoration: InputDecoration(
        labelText: 'Select Country',
        hintText: selectedCountry ?? 'Choose a country',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        suffixIcon: const Icon(Icons.arrow_drop_down),
      ),
      controller: TextEditingController(text: selectedCountry ?? ''),
    );
  }
}
