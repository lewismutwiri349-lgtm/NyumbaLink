import 'package:flutter_test/flutter_test.dart';
import 'package:nyumbalink/shared/data/sample_fee_schedule.dart';

void main() {
  test('provisional fee bands follow decision D8 with Q1 filled as 600', () {
    expect(provisionalFeeForRentKes(2500), 200);
    expect(provisionalFeeForRentKes(3000), 200);
    expect(provisionalFeeForRentKes(3001), 500);
    expect(provisionalFeeForRentKes(5000), 500);
    expect(provisionalFeeForRentKes(5001), 600);
    expect(provisionalFeeForRentKes(6000), 600);
    expect(provisionalFeeForRentKes(8000), 600);
  });
}
