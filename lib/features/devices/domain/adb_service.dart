class ADBDevice {
  const ADBDevice({
    required this.serial,
    required this.state,
    this.model
  });

  final String serial;
  final String state;
  final String? model;

  bool get isReady => state == 'device';
}