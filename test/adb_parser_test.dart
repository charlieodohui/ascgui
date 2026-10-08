import 'package:ascgui/features/devices/data/adb_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'parse out devices along with its model',
    () {
      const testOutput = '''
        List of devices attached
        emulator-5554          device product:sdk model:Pixel_7 device:generic transport_id:1
        R58M123ABC             unauthorized transport_id:2
        ''';
      
      final devices = parseAdbDevices(testOutput);
      expect(devices.first.model, 'Pixel_7');
      expect(devices.first.isReady, isTrue);
      expect(devices.last.isReady, isFalse);
    }
  );

  test(
    'no devices detected output returns empty list',
    (){
      const testOutput = 'List of devices attached\n\n';
      expect(parseAdbDevices(testOutput), isEmpty);
    }
  );
}