import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interface_connection/apiwrapper/api_wrapper.dart';
import 'package:interface_connection/ui/profile.dart';
import 'package:provider/provider.dart';

import '../providers/variable_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late MediaQueryData _mediaQueryData;
  String route = "login";

  void checkValidations(BuildContext context, VariableProvider provider) {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty) {
      Fluttertoast.showToast(
          msg: "Enter Username",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (password.isEmpty) {
      Fluttertoast.showToast(
          msg: "Enter Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      // After checking all errors if everything is okay then we save this data.
      provider.updateIsLoading(true);
      loginToSolid(username, password, context, provider);
    }
  }

  loginToSolid(String username, String password, BuildContext context,
      VariableProvider provider) async {
    Map<String, dynamic> credentials = {
      "username": username,
      "password": password
    };

    String jsonData = jsonEncode(credentials);
    if (kDebugMode) {
      print("JSON Data For API : " + jsonData);
    }

    var data = await CallAPI.apiMModule.postResponse(route, credentials, null);

    if (kDebugMode) {
      print('Data from api : $data');
    }

    if (jsonDecode(data)['webId'] != "session.webId is undefined") {
      Provider.of<VariableProvider>(context, listen: false)
          .updateUserWebID(jsonDecode(data)['webId']);

      Provider.of<VariableProvider>(context, listen: false)
          .updateUsername(username);

      Provider.of<VariableProvider>(context, listen: false)
          .updatePassword(password);

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const ProfilePage()));

      Fluttertoast.showToast(
          msg: "Login Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);

      provider.updateIsLoading(false);
    } else {
      Fluttertoast.showToast(
          msg: "Wrong Username or Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);

      provider.updateIsLoading(false);
    }
    // Here async and await means We know that it will take some time
    // to get the data from api to the app
    // now app never waits for anyone it will keep going on next execution
  }

  @override
  void initState() {
    // implement initState
    super.initState();
    CallAPI.init();
  }

  @override
  void dispose() {
    // implement dispose
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    VariableProvider provider = Provider.of<VariableProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login To Solid'),
      ),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Login to solid',
                  style: GoogleFonts.josefinSans(
                    textStyle:
                        const TextStyle(color: Colors.black, fontSize: 30),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextField(
                    controller: _usernameController,
                    cursorColor: Colors.blue,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0)),
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'Enter Username',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: TextField(
                    controller: _passwordController,
                    cursorColor: Colors.blue,
                    obscureText: true,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0)),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0)),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blue, width: 2.0)),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'Enter Password',
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(_mediaQueryData.size.width * .85, 40),
                    padding: const EdgeInsets.all(8),
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () => checkValidations(context, provider),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          provider.getIsLoading
              ? const CircularProgressIndicator()
              : Container()
        ],
      ),
    );
  }
}
