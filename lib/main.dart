import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'Features/checkout/presentation/views/my_cart_view.dart';

void main() {
  // Stripe.publishableKey = ApiKeys.puplishableKey;

  runApp(
    DevicePreview(
      builder: (context) => const CheckoutApp(),
    ),
  );
}

class CheckoutApp extends StatelessWidget {
  const CheckoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      home: const MyCartView(),
    );
  }
}
