import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/auth/index.dart';
import 'package:flutter_github_connect/helper/config.dart';
import 'package:flutter_github_connect/helper/git_config.dart';
import 'package:flutter_github_connect/ui/theme/colors.dart';
import 'package:flutter_github_connect/ui/widgets/g_loader.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  final ValueNotifier<bool> showLoader = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Stack(
            children: <Widget>[
              WebView(
                initialUrl: "${Config.authUrl}${GitConfig.CLIENT_ID}",
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  print('Web view completed');
                  showLoader.value = true;
                  _controller.complete(webViewController);
                },
                javascriptChannels: <JavascriptChannel>[
                  _toasterJavascriptChannel(context),
                ].toSet(),
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.startsWith('https://www.google.com/')) {
                    final code = request.url.split("code=")[1];
                    log(code);
                    print('blocking navigation to}');

                    _load(context, code);

                    return NavigationDecision.prevent;
                  }
                  print('allowing navigation');
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  showLoader.value = true;
                  print('Page started loading');
                },
                onPageFinished: (String url) {
                  showLoader.value = false;
                  print('Page finished loading:');
                },
                gestureNavigationEnabled: true,
              ),
              ValueListenableBuilder<bool>(
                valueListenable: showLoader,
                builder: (context, value, child) {
                  return Align(
                    alignment: Alignment.center,
                    child: value
                        ? GLoader(stroke: 1)
                        : Container(),
                  );
                },
                // child:
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
