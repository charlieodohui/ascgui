import 'dart:developer' show log;
import 'package:ascgui/core/process/tool_resolver.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ToolPathSelector extends StatefulWidget{
  const ToolPathSelector({
    super.key,
    required this.toolName,
    required this.value,
    required this.onChange,
  });

  final String toolName;
  final String? value;
  final ValueChanged<String?> onChange;

  @override
  State<ToolPathSelector> createState() => _ToolPathSelectorState();
}

class _ToolPathSelectorState extends State<ToolPathSelector> {
  late final TextEditingController _controller;
  late Future<String?> _resolved;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? '');
    _resolve();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _resolve() {
    final text = _controller.text.trim();
    _resolved = resolveTool(
      widget.toolName,
      configured: text.isEmpty ? null : text,
    );
  }

  void _commit(String text) {
    final value = text.trim();
    widget.onChange(value.isEmpty ? null : value);
    setState(_resolve);
  }

  Future<void> _browse() async {
    final result = await FilePicker.pickFiles(
      dialogTitle: 'Select ${widget.toolName}'
    );
    
    final path = result.first.path;
    log('[ToolPathSelector] browse result path: $path');
    if (path == null) return;
    _controller.text = path;
    _commit(path);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Focus(
                onFocusChange: (hasFocus) {
                  if (!hasFocus) {}
                },
                child: TextField(
                  // controller: ,
                  // onSubmitted: ,
                  decoration: InputDecoration(
                    labelText: widget.toolName,
                    hintText: 'Enter here the tool PATH',
                    border: const OutlineInputBorder()
                  ),
                )
              )
            ),

            const SizedBox(width: 8),

            OutlinedButton.icon(
              icon: const Icon(Icons.folder_open),
              label: Text('Search'),
              onPressed: _browse,
            ),
          ],
        ),

        const SizedBox(height: 4),

        FutureBuilder<String?>(
          future: _resolved,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const SizedBox(height: 16);
            }
            final path = snapshot.data;
            return Text(
              path != null ? 'Found: $path' : 'Not found',
              style: TextStyle(color: path != null ? scheme.primary : scheme.error),
            );
          }
        ),
      ],
    );
  }
}