import 'package:checkout/Features/checkout/data/models/ephemeral_key_model/ephemeral_key_model.dart';
import 'package:checkout/Features/checkout/data/models/init_payment_sheet_input_model.dart';
import 'package:checkout/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:checkout/Features/checkout/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:checkout/core/services/api_keys.dart';
import 'package:checkout/core/services/api_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripeService {
  ApiService apiService = ApiService();
  Future<EphemeralKeyModel> createEphemeralKey(
      {required String customerId}) async {
    final response = await apiService.post(
        body: {"customer": customerId},
        contentType: Headers.formUrlEncodedContentType,
        url: "https://api.stripe.com/v1/ephemeral_keys",
        token: ApiKeys.secretKey,
        headers: {
          'Content-Type': Headers.formUrlEncodedContentType,
          'Authorization': 'Bearer ${ApiKeys.secretKey}',
          'Stripe-Version': '2024-06-20'
        });

    return EphemeralKeyModel.fromJson(response.data);
  }

  Future<PaymentIntentModel> createPaymentIntent(
      PaymentIntentInputModel paymentIntentInputModel) async {
    final response = await apiService.post(
      body: paymentIntentInputModel.toJson(),
      contentType: Headers.formUrlEncodedContentType,
      url: "https://api.stripe.com/v1/payment_intents",
      token: ApiKeys.secretKey,
    );

    return PaymentIntentModel.fromJson(response.data);
  }

  Future initPaymentSheet({required InitPaymentSheetInputModel model}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: model.clientSecret,
          customerEphemeralKeySecret: model.ephemeralKeySecret,
          customerId: model.customerId,
          merchantDisplayName: "Abdelmoneim Adel"),
    );
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment({
    required PaymentIntentInputModel paymentIntentInputModel,
  }) async {
    var paymentIntentModel = await createPaymentIntent(paymentIntentInputModel);
    var ephemeralKeyModel =
        await createEphemeralKey(customerId: paymentIntentInputModel.cusomerId);
    InitPaymentSheetInputModel initPaymentSheetModel =
        InitPaymentSheetInputModel(
      clientSecret: paymentIntentModel.clientSecret!,
      customerId: paymentIntentInputModel.cusomerId,
      ephemeralKeySecret: ephemeralKeyModel.secret!,
    );
    await initPaymentSheet(model: initPaymentSheetModel);
    await displayPaymentSheet();
  }
}
