import 'package:flutter/material.dart';

class TagsInput extends StatefulWidget {
  final List<String> initialTags;
  final void Function(List<String>) onChanged;

  const TagsInput({
    super.key,
    this.initialTags = const [],
    required this.onChanged,
  });

  @override
  State<TagsInput> createState() => _TagsInputState();
}

class _TagsInputState extends State<TagsInput> {
  final TextEditingController _tagController = TextEditingController();
  late List<String> _tags;

  @override
  void initState() {
    super.initState();
    _tags = List.from(widget.initialTags);
  }

  void _addTag(String tag) {
    final trimmed = tag.trim();
    if (trimmed.isNotEmpty && !_tags.contains(trimmed)) {
      setState(() {
        _tags.add(trimmed);
        _tagController.clear();
      });
      widget.onChanged(_tags);
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
    widget.onChanged(_tags);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _tagController,
                decoration: InputDecoration(
                  labelText: "New tag",
                  hintText: "e.g. beach",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                onSubmitted: _addTag,
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () => _addTag(_tagController.text),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Add"),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _tags.map((tag) {
            return Chip(
              label: Text(tag),
              deleteIcon: const Icon(Icons.close, size: 18),
              onDeleted: () => _removeTag(tag),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }
}
