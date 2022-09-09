import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String registerURL = "https://solidcommunity.net/register";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
          child: WebView(
        initialUrl: registerURL,
        javascriptMode: JavascriptMode.unrestricted,
      )),
    );
  }
}
