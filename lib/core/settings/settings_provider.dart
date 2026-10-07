import 'package:ascgui/core/settings/settings_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>(
  (ref) => throw UnimplementedError('Override en main()'),
);

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(sharedPreferencesProvider)),
);

class SettingsNotifier extends Notifier<Settings> {
  @override
  Settings build() => ref.watch(settingsRepositoryProvider).load();

  Future<void> update(Settings next) async {
    await ref.read(settingsRepositoryProvider).save(next);
    state = next;
  }
}

final settingsProvider = NotifierProvider<SettingsNotifier, Settings>(
  SettingsNotifier.new,
);