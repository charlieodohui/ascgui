import 'dart:developer' show log;
import 'dart:io';

Future<String?> resolveTool(String name, {String? configured}) async {
  if (configured != null && configured.isNotEmpty) {
    return File(configured).existsSync() ? configured : null;
  }

  String finder = 'which';
  //if (Platform.isLinux) finder = 'which';

  try {
    final result = await Process.run(finder, [name]);

    log('[ToolResolver] result.exitCode: ${result.exitCode}');
    if (result.exitCode != 0) return null;

    final first = (result.stdout as String).split(RegExp(r'\r?\n')).first.trim();
    log('[ToolResolver] first: $first');
    return first.isEmpty ? null : first;
  } on ProcessException {
    return null;
  }
}