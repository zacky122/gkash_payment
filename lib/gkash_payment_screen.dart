import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:gkashpayment/payment_request.dart';

import 'gkash_payment_sdk.dart';

class GkashPaymentScreen extends StatefulWidget {
  final PaymentRequest paymentRequest;

  const GkashPaymentScreen(this.paymentRequest);

  @override
  _GkashPaymentScreenState createState() => _GkashPaymentScreenState();
}

class _GkashPaymentScreenState extends State<GkashPaymentScreen> {
  GkashPaymentSDK _gkashPaymentSDK;

  @override
  void initState() {
    _gkashPaymentSDK = GkashPaymentSDK.getInstance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      title: Text('Gkash Payment'),
    );
    return Scaffold(
      appBar: appBar,
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: InAppWebView(
          initialUrl: _gkashPaymentSDK.getHostUrl(),
          onWebViewCreated: (InAppWebViewController controller) {
            var data = ("version=" +
                Uri.encodeComponent(widget.paymentRequest.version ?? "") +
                "&CID=" +
                Uri.encodeComponent(widget.paymentRequest.cid ?? "") +
                "&v_currency=" +
                Uri.encodeComponent(widget.paymentRequest.currency ?? "") +
                "&v_amount=" +
                Uri.encodeComponent(widget.paymentRequest.amount ?? "") +
                "&v_cartid=" +
                Uri.encodeComponent(widget.paymentRequest.cartid ?? "") +
                "&v_firstname=" +
                "&signature=" +
                Uri.encodeComponent(
                    widget.paymentRequest.generateSignature() ?? ""));

            controller.postUrl(
                url: _gkashPaymentSDK.getHostUrl() + "api/PaymentForm.aspx",
                postData: utf8.encode(data));
          },
        ),
      ),
    );
  }
}
