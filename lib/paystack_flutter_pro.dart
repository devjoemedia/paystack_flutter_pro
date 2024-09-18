library paystack_flutter_pro;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_paystack_max/flutter_paystack_max.dart';

/// A Calculator.
class PaystackFlutterPro {
  final String secretKey;
  // final PaystackPlugin _paystackPlugin = PaystackPlugin();

  PaystackFlutterPro(this.secretKey) {
    // _paystackPlugin.initializeTransaction(secretKey: secretKey);
  }

  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<void> startTransaction({
    required BuildContext context,
    required int amount,
    required String email,
    // PaystackCurrency? currency = PaystackCurrency.ghs,
    required Function onSuccess,
    required Function onError,
  }) async {
    // Charge charge = Charge();

    // charge.amount = amount;
    // charge.currency = currency;
    // charge.reference = _getReference();
    // charge.email = email;

    try {
      // CheckoutResponse response = await _paystackPlugin.checkout(
      //   context,
      //   method: method, // Defaults to CheckoutMethod.selectable
      //   charge: charge,
      // );
      final request = PaystackTransactionRequest(
        reference: _getReference(),
        secretKey: secretKey,
        email: email,
        amount: amount * 100,
        currency: PaystackCurrency.ghs,
        channel: [
          PaystackPaymentChannel.mobileMoney,
          PaystackPaymentChannel.card,
          PaystackPaymentChannel.ussd,
          PaystackPaymentChannel.bankTransfer,
          PaystackPaymentChannel.bank,
          PaystackPaymentChannel.qr,
          PaystackPaymentChannel.eft,
        ],
      );

      final initializedTransaction =
          await PaymentService.initializeTransaction(request);

      if (!context.mounted) return;

      final response = await PaymentService.showPaymentModal(
        context,
        transaction: initializedTransaction,
        callbackUrl: '...',
      ).then((_) async {
        debugPrint('started transaction successfully');

        return await PaymentService.verifyTransaction(
          paystackSecretKey: secretKey,
          initializedTransaction.data?.reference ?? request.reference,
        );
      });

      if (response.status) {
        onSuccess(response);
      } else {
        onError('Transaction failed');
      }
    } catch (e) {
      onError(e.toString());
    }
  }
}
