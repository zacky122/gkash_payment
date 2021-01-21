import 'package:crypto/crypto.dart';
import 'dart:convert';

class PaymentRequest {
  final String version;
  final String cid;
  final String currency;
  final String amount;
  final String cartid;
  final String signature;
  final String returnUrl; // Android package name
  final String email; // Optional
  final String mobileNo; // Optional
  final String firstName; // Optional
  final String lastName; // Optional
  final String productDescription; // Optional
  final String billingStreet; // Optional
  final String billingPostCode; // Optional
  final String billingCity; // Optional
  final String billingState; // Optional
  final String billingCountry;

  PaymentRequest(
      {this.version,
      this.cid,
      this.currency,
      this.amount,
      this.cartid,
      this.signature,
      this.returnUrl,
      this.email,
      this.mobileNo,
      this.firstName,
      this.lastName,
      this.productDescription,
      this.billingStreet,
      this.billingPostCode,
      this.billingCity,
      this.billingState,
      this.billingCountry});

  String generateSignature() {
    String sign = (signature +
            ";" +
            cid +
            ";" +
            cartid +
            ";" +
            double.parse(amount).toStringAsFixed(2).replaceAll(".", "") +
            ";" +
            currency)
        .toUpperCase();
    var signaureHash = sha512.convert(utf8.encode(sign));

    return signaureHash.toString().toLowerCase();
  }
}
