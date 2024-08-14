class PaymentIntentInputModel {
  final String amount;
  final String currency;
  final String cusomerId;
  PaymentIntentInputModel({
    required this.cusomerId,
    required this.amount,
    required this.currency,
  });

  Map<String, dynamic> toJson() {
    int price = int.parse(amount) * 100;

    return {
      'amount': "$price",
      'currency': currency,
      'customer': cusomerId,
    };
  }
}
