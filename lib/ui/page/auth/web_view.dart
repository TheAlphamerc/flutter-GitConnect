import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/auth/index.dart';
import 'package:flutter_github_connect/helper/config.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  final ValueNotifier<bool> showLoader = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return Stack(
            children: <Widget>[
              WebView(
                initialUrl: "${Config.authUrl}ca0290b6cbf8bae69c5a",
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  print('Web view completed');
                  _controller.complete(webViewController);
                },
                javascriptChannels: <JavascriptChannel>[
                  _toasterJavascriptChannel(context),
                ].toSet(),
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.startsWith('https://www.google.com/')) {
                    final code = request.url.split("code=")[1];
                    log(code);
                    print('blocking navigation to $request}');

                    _load(context, code);

                    return NavigationDecision.prevent;
                  }
                  print('allowing navigation to $request');
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  showLoader.value = true;
                  print('Page started loading');
                },
                onPageFinished: (String url) {
                  showLoader.value = false;
                  print('Page finished loading: $url');
                },
                gestureNavigationEnabled: true,
              ),
              ValueListenableBuilder(
                valueListenable: showLoader,
                builder: (context, bool value, child) {
                  return child;
                },
                child: Align(
                  alignment: Alignment.center,
                  child: showLoader.value
                      ? CircularProgressIndicator()
                      : Container(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
      name: 'Message',
      onMessageReceived: (JavascriptMessage message) {
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      },
    );
  }

  void _load(context, String code) {
    print("Get Acess TOken");
    BlocProvider.of<AuthBloc>(context).add(LoadAuthEvent(code));
  }
}
