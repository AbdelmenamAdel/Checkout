import 'dart:developer';

class PaymentIntentInputModel {
  final String amount;
  final String currency;

  PaymentIntentInputModel({
    required this.amount,
    required this.currency,
  });

  Map<String, dynamic> toJson() {
    int price = int.parse(amount) * 100;

    return {
      'amount': "$price",
      'currency': currency,
    };
  }
}
