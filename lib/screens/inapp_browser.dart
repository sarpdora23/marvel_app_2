import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:marvel_app_2/utilities/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InApppBrowser extends StatelessWidget {
  late String _link;
  InApppBrowser(this._link);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: appBlueTheme),
      body: ViewWeb(_link),
    );
  }
}

class ViewWeb extends StatelessWidget {
  late String _link;
  ViewWeb(this._link);
  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: _link,
      onProgress: (progress) => CircularProgressIndicator(),
      onWebViewCreated: ((controller) {
        _controller.complete(controller);
      }),
    );
  }
}
