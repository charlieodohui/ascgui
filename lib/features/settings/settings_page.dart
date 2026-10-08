import 'package:ascgui/core/settings/settings_provider.dart';
import 'package:ascgui/core/widgets/tool_path_selector.dart';
import 'package:ascgui/features/devices/presentation/devices_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerWidget{
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ToolPathSelector(
              toolName: 'scrcpy',
              value: settings.scrcpyPath,
              onChange: notifier.setScrcpyPath,
            ),
            const SizedBox(height: 24),
            ToolPathSelector(
              toolName: 'adb',
              value: settings.adbPath,
              onChange: (v) async {
                await notifier.setAdbPath(v);
                ref.invalidate(devicesProvider);
              }
            ),
          ],
        ),
      ),
    );
  }
}