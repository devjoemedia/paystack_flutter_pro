import 'package:flutter_test/flutter_test.dart';

import 'package:paystack_flutter_pro/paystack_flutter_pro.dart';

void main() {
  test('adds one to input values', () {
    final calculator = PaystackFlutterPro('test-key');
    expect(calculator.addOne(2), 3);
    expect(calculator.addOne(-7), -6);
    expect(calculator.addOne(0), 1);
  });
}
