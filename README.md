# another scrcpy gui (ascgui)

Because the world needed EVEN ANOTHER scrcpy GUI project. This project originated from my work as a developer of Android mobile apps built in Flutter, outside the Android Studio environment, and to make presenting product progress on video calls easier. This project's development is designed around my day-to-day needs and the emerging ones as I keep growing as a developer.

This project **IS NOT VIBECODED**, since its creation is focused on developing personal coding abilities and learning. The AI use is limited specifically towards consultant, debug guiding and second opinion; everything else is made through research in forums and official documentation and collaborators are expected to behave as such.

> **Last updated:** 2026-10-08

<!--
## Documentation

- [Installation Guide](docs/GUIA_DE_INSTALACION.md): Environment requirements and setup
- [Architecture](docs/ARQUITECTURA.md): Overview of the MVVM architecture
-->

## Development

### Flutter

This app uses Flutter as its framework and relies on FVM to keep release stability. Version 3.47.6 or later is recommended.
You can download Flutter from the following link: [docs.flutter.dev/install](https://docs.flutter.dev/install)

### FVM (Flutter Version Manager)

Install FVM if you don't have it yet, by running the following commands from the project root:

```bash
dart pub global activate fvm
fvm install 3.47.6
fvm use 3.47.6
```

Verify with:

```bash
fvm flutter --version
```

### Dependencies

Once FVM is installed, download the dependencies by running the following command from inside the project root:

```bash
fvm flutter pub get
```

## ToDo list

| Status | Feature | Notes |
| --- | --- | --- |
| Done | Show first GUI | Now it shows the devices, launches scrcpy and can configure PATHs of tools |
| Pending | Do a Changelog MD | [https://keepachangelog.com/en/1.1.0/] |

## Educated Wishes

| Feature | Notes |
| --- | --- |
| Multiple devices | No time to get to that yet |
| Stream iOS | Needs research |
| Windows build | Later |
| MacOS build | Later |

<!--
## Suggestions for a good README
Every project is different, so consider which of these sections apply to yours. The sections used in the template are suggestions for most open source projects. Also keep in mind that while a README can be too long and detailed, too long is better than too short. If you think your README is too long, consider utilizing another form of documentation rather than cutting out information.
## Badges
On some READMEs, you may see small images that convey metadata, such as whether or not all the tests are passing for the project. You can use Shields to add some to your README. Many services also have instructions for adding a badge.
## Authors and acknowledgment
Show your appreciation to those who have contributed to the project.
-->
