import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_github_connect/bloc/auth/auth_bloc.dart';
import 'package:flutter_github_connect/bloc/auth/auth_event.dart';
import 'package:flutter_github_connect/helper/GIcons.dart';
import 'package:flutter_github_connect/helper/config.dart';
import 'package:flutter_github_connect/helper/git_config.dart';
import 'package:flutter_github_connect/ui/theme/export_theme.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyInAppBrowser extends InAppBrowser {
  MyInAppBrowser(
      {this.loadStart,
      int windowId,
      UnmodifiableListView<UserScript> initialUserScripts})
      : super(windowId: windowId, initialUserScripts: initialUserScripts);
  final void Function(Uri) loadStart;
  @override
  Future onBrowserCreated() async {}

  @override
  Future onLoadStart(url) async {
    // print("\n\nStarted $url\n\n");
    loadStart(url);
  }

  @override
  Future onLoadStop(url) async {
    pullToRefreshController?.endRefreshing();
    // print("\n\nStopped $url\n\n");
  }

  @override
  void onLoadError(url, code, message) {
    pullToRefreshController?.endRefreshing();
    print("Can't load $url.. Error: $message");
  }

  @override
  void onProgressChanged(progress) {
    if (progress == 100) {
      pullToRefreshController?.endRefreshing();
    }
  }

  @override
  void onExit() {}

  @override
  Future<NavigationActionPolicy> shouldOverrideUrlLoading(
      navigationAction) async {
    // print("\n\nOverride ${navigationAction.request.url}\n\n");
    return NavigationActionPolicy.ALLOW;
  }

  @override
  void onLoadResource(response) {
    print("Started at: " +
        response.startTime.toString() +
        "ms ---> duration: " +
        response.duration.toString() +
        "ms " +
        (response.url ?? '').toString());
  }

  @override
  void onConsoleMessage(consoleMessage) {
    print("""
    console output:
      message: ${consoleMessage.message}
      messageLevel: ${consoleMessage.messageLevel.toValue()}
   """);
  }
}

class InAppBrowserExampleScreen extends StatefulWidget {
  @override
  _InAppBrowserExampleScreenState createState() =>
      new _InAppBrowserExampleScreenState();
}

class _InAppBrowserExampleScreenState extends State<InAppBrowserExampleScreen> {
  PullToRefreshController pullToRefreshController;
  MyInAppBrowser browser;

  @override
  void initState() {
    super.initState();
    browser = new MyInAppBrowser(
      loadStart: onLoadStart,
    );
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.black,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          browser.webViewController.reload();
        } else if (Platform.isIOS) {
          browser.webViewController.loadUrl(
              urlRequest:
                  URLRequest(url: await browser.webViewController.getUrl()));
        }
      },
    );
    browser.pullToRefreshController = pullToRefreshController;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      openCrowser();
    });
  }

  void openCrowser() async {
    // widget.browser..
    await browser.openUrlRequest(
      urlRequest:
          URLRequest(url: Uri.parse("${Config.authUrl}${GitConfig.CLIENT_ID}")),
      options: InAppBrowserClassOptions(
        inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            useShouldOverrideUrlLoading: true,
            useOnLoadResource: true,
          ),
        ),
      ),
    );
  }

  void onLoadStart(Uri url) {
    if (url.host.startsWith('www.google.com')) {
      final code = url.query.split("code=")[1];
      print('blocking navigation to}');
      browser.close();
      BlocProvider.of<AuthBloc>(context).add(LoadAuthEvent(code));
    }
  }

  void onLoadResource(LoadedResource response) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        alignment: Alignment.center,
        height: AppTheme.fullHeight(context),
        child: Container(
          height: 150,
          width: 150,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: [
              Icon(GIcons.github, size: 120),
              CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(GColors.blue)),
            ],
          ),
        ),
      ),
    );
  }
}
