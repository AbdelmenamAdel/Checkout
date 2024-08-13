import 'package:checkout/Features/checkout/data/models/payment_intent_input_model.dart';

import 'package:checkout/core/errors/failures.dart';
import 'package:checkout/core/services/stripe_service.dart';

import 'package:dartz/dartz.dart';

import 'checkout_repo.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  StripeService stripeService = StripeService();
  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await stripeService.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return right(null);
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
