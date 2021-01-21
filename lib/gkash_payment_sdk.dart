import 'package:flutter/material.dart';
import 'package:gkashpayment/payment_request.dart';

import 'gkash_payment_screen.dart';


class GkashPaymentSDK {
  static GkashPaymentSDK instance;
  BuildContext _context;
  String _hostUrl = "https://api-staging.pay.asia/";

  static GkashPaymentSDK getInstance() {
    if (instance == null) {
      instance = GkashPaymentSDK();
    }
    return instance;
  }

  void setProductionEnvironment(bool isProduction) {
    if (isProduction) {
      _hostUrl = "https://api.gkash.my/";
    }
  }

  String getHostUrl() {
    return _hostUrl;
  }

  void startPayment(BuildContext context, PaymentRequest request) {
    _context = context;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) {
          return GkashPaymentScreen(request);
        },
      ),
    );
  }
}
