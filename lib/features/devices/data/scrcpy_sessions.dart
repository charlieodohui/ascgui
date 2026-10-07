import 'dart:convert';
import 'dart:io';

class ScrcpySessions {
  final _running = <String, Process>{};

  bool isRunning(String serial) => _running.containsKey(serial);

  Future<void> start(
    String scrcpyPath,
    String serial,
    { 
      List<String> extraArgs = const [],
      void Function(String line)? onLog 
    }
  ) async {
    if (isRunning(serial)) return;
    final process = await Process.start(scrcpyPath, ['-s', serial, ...extraArgs]);
    _running[serial] = process;

    // Hay que consumir stdout/stderr, o el proceso puede bloquearse (como discord en linux hace tiempo).
    for (final stream in [process.stdout, process.stderr]) {
      stream
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen((line) => onLog?.call(line));
    }
    // Si el usuario cierra la ventana de scrcpy, lo quitamos de la lista.
    await process.exitCode.then((_) => _running.remove(serial));
  }

  void stop(String serial) => _running.remove(serial)?.kill();

  void stopAll() {
    for (final p in _running.values) {
      p.kill();
    }
    _running.clear();
  }
}