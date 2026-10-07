import 'dart:developer' show log;
import 'dart:nativewrappers/_internal/vm/bin/common_patch.dart';

import 'package:ascgui/features/devices/domain/adb_service.dart';

class ADBException implements Exception {
  ADBException(this.message);
  final String message;

  @override
  String toString() => 'ADBException: $message';
}

class ADBService {
  ADBService(this.adbPath);
  final String adbPath;

  Future<List<ADBDevice>> listDevices() async {
    final result = await Process.run(adbPath, ['device', '-l']);

    log('[ADBService] listDevices result.exitCode: ${result.exitCode}');
    if(result.exitCode != 0) {
      throw ADBException(result.stderr.toString());
    }
    return parseAdbDevices(result.stdout as String);
  }
}

List<ADBDevice> parseAdbDevices(String output) {
  final devices = <ADBDevice>[];

  for (final raw in output.split(RegExp(r'\r?\n'))) {
    final line = raw.trim();
    if (line.isEmpty || line.startsWith('List of devices') || line.startsWith('*')) continue;

    final parts = line.split(RegExp(r'\r?\n'));
    if (parts.length < 2) continue;

    final model = parts
      .skip(2)
      .where((p) => p.startsWith('model:'))
      .map((p) => p.substring('model:'.length))
      .firstOrNull;
    
    devices.add(ADBDevice(serial: parts[0], state: parts[1], model: model));
  }

  return devices;
}