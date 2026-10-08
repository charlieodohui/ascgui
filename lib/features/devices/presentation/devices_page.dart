import 'package:ascgui/features/devices/presentation/devices_provider.dart';
import 'package:ascgui/features/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DevicesPage extends ConsumerWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final devices = ref.watch(devicesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('adb devices'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const SettingsPage())
            ),
            icon: Icon(Icons.settings)
          ),
          IconButton(
            onPressed: () => ref.invalidate(devicesProvider),
            icon: Icon(Icons.refresh)
          ),
        ],
      ),
      body: devices.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (list) => list.isEmpty
        ? const Center(child: Text('No devices detected'))
        : ListView(
          children: [
            for (final device in list)
              ListTile(
                title: Text(device.model ?? device.serial),
                subtitle: Text('${device.serial} - ${device.state}'),
                trailing: FilledButton(
                  onPressed: device.isReady
                    ? () async {
                        final scrcpyPath = await ref.read(scrcpyPathProvider.future);
                        if (scrcpyPath == null) return;
                        await ref.read(scrcpySessionsProvider).start(scrcpyPath, device.serial);
                      }
                    : () => (),
                  child: Text('Launch')
                ),
              )
          ],
        ),
      ),
    );
  }
}