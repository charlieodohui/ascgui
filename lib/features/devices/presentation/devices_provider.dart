import 'package:ascgui/core/process/tool_resolver.dart';
import 'package:ascgui/core/settings/settings_provider.dart';
import 'package:ascgui/features/devices/data/adb_service.dart';
import 'package:ascgui/features/devices/data/scrcpy_sessions.dart';
import 'package:ascgui/features/devices/domain/adb_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adbPathProvider = FutureProvider<String?>( (ref) {
  final settings = ref.watch(settingsProvider);
  return resolveTool('adb', configured: settings.adbPath);
});

final scrcpyPathProvider = FutureProvider<String?>( (ref) {
  final settings = ref.watch(settingsProvider);
  return resolveTool('scrcpy', configured: settings.scrcpyPath);
});

/// Para refrescar la lista desde la UI
final devicesProvider = FutureProvider<List<ADBDevice>>( (ref) async {
  final adbPath = await ref.watch(adbPathProvider.future);
  if (adbPath == null) throw ADBException('ADB not found. Configure its route');
  return ADBService(adbPath).listDevices();
});

final scrcpySessionsProvider = Provider<ScrcpySessions>( (ref) {
  final sessions = ScrcpySessions();
  ref.onDispose(sessions.stopAll);
  return sessions;
});