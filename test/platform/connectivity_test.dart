import 'package:connectivity/connectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  group('test koneksi', () {
    Connectivity connectivity = MockConnectivity();
    test('untuk koneksi wifi', () async {
      when(connectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.wifi);

      expect(await connectivity.checkConnectivity(), ConnectivityResult.wifi);
    });
    test('untuk koneksi mobile', () async {
      when(connectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.mobile);

      expect(await connectivity.checkConnectivity(), ConnectivityResult.mobile);
    });
    test('untuk koneksi kosong / tidak ada', () async {
      when(connectivity.checkConnectivity())
          .thenAnswer((_) async => ConnectivityResult.none);

      expect(await connectivity.checkConnectivity(), ConnectivityResult.none);
    });
  });
}
