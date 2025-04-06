import 'package:flutter/material.dart';

class GalleryUrlsInput extends StatefulWidget {
  final List<String> initialUrls;
  final void Function(List<String>) onChanged;

  const GalleryUrlsInput({
    super.key,
    required this.initialUrls,
    required this.onChanged,
  });

  @override
  State<GalleryUrlsInput> createState() => _GalleryUrlsInputState();
}

class _GalleryUrlsInputState extends State<GalleryUrlsInput> {
  late List<String> _urls;
  final _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _urls = [...widget.initialUrls];
  }

  void _addUrl() {
    final url = _urlController.text.trim();
    if (url.isNotEmpty && !_urls.contains(url)) {
      setState(() {
        _urls.add(url);
        _urlController.clear();
      });
      widget.onChanged(_urls);
    }
  }

  void _removeUrl(String url) {
    setState(() {
      _urls.remove(url);
    });
    widget.onChanged(_urls);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Gallery Image URLs"),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _urlController,
                decoration: const InputDecoration(
                  hintText: "Enter image URL",
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (_) => _addUrl(),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _addUrl,
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
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _urls
              .map(
                (url) => Chip(
                  label: Text(
                    url,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onDeleted: () => _removeUrl(url),
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }
}
