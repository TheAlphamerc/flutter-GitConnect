import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/auth/index.dart';
import 'package:flutter_github_connect/helper/config.dart';
import 'package:flutter_github_connect/ui/page/user/profile_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

 AuthBloc _authBloc(BuildContext context) {
    return BlocProvider.of<AuthBloc>(context);
  }

class WebViewPage extends StatefulWidget {
  final String link;
  // final AuthBloc authBloc;
  const WebViewPage({Key key, this.link, }) : super(key: key);
 

  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

class _WebViewExampleState extends State<WebViewPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  ValueNotifier<bool> showLoader = ValueNotifier(false);

  @override
  void initState() {
    _authBloc(context).listen((state) {
      if (state is SucessState) {
        if (state.isSuccess) {
          print("Navigate to Profile page");
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => ProfilePage()));
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool loading = true;
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

                    _load(code);

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
                  child: loading ? CircularProgressIndicator() : Container(),
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

  void _load(String code) {
    // widget.authBloc.add(LoadAuthEvent(code));
    BlocProvider.of<AuthBloc>(context).add(LoadAuthEvent(code));
  }
}
