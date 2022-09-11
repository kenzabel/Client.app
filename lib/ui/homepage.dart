import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interface_connection/providers/variable_provider.dart';
import 'package:interface_connection/ui/login.dart';
import 'package:interface_connection/ui/profile.dart';
import 'package:interface_connection/ui/register.dart';
import 'package:interface_connection/ui/scan_qr_code.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:solid_auth/solid_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          child: Stack(
            children: [
              Positioned(
                top: 200,
                left: -100,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: const BoxDecoration(
                    color: Color(0x304599ff),
                    borderRadius: BorderRadius.all(
                      Radius.circular(150),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: -10,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(
                      color: Color(0x30cc33ff),
                      borderRadius: BorderRadius.all(
                        Radius.circular(100),
                      )),
                ),
              ),
              Positioned(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 80,
                    sigmaY: 80,
                  ),
                  child: Container(),
                ),
              ),
              SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(children: [
                      const SizedBox(
                        height: 50,
                      ),
                      _logo(),
                      _loginLabel(),
                      const SizedBox(
                        height: 150,
                      ),
                      _loginBtn(context),
                      const SizedBox(
                        height: 200,
                      ),
                      _signUpLabel("Vous n'avez pas encore de compte Solid ?",
                          const Color(0xff909090)),
                      const SizedBox(
                        height: 10,
                      ),
                      _signUpButton(
                          "Créez-en un.", const Color(0xff164276), context),
                    ]),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _logo() {
    return Center(
      child: SizedBox(
        child: GestureDetector(
          onTap: () {
             Navigator.of(context).push(
                 MaterialPageRoute(builder: (context) => const ScanQRCode()));
          },
          child: Image.asset('images/book.jpg'),
        ),
        height: 80,
      ),
    );
  }

  Widget _loginLabel() {
    return Center(
      child: Text("BookMate",
          style: GoogleFonts.josefinSans(
              textStyle: const TextStyle(
            color: Color(0xff164276),
            fontWeight: FontWeight.w900,
            fontSize: 34,
          ))),
    );
  }

  _loginBtn(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: const BoxDecoration(
        color: Color(0xff008fff),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: TextButton(
        onPressed: () async {
          // Get issuer URI
          String _issuerUri = await getIssuer("https://solidcommunity.net/");

          // Define scopes. Also possible scopes -> webid, email, api
          final List<String> _scopes = <String>[
            'openid',
            'profile',
            'offline_access',
          ];

          // Authentication process for the POD issuer
          var authData =
              await authenticate(Uri.parse(_issuerUri), _scopes, context);

          // Decode access token to get the correct webId
          String accessToken = authData['accessToken'];
          Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
          String webId = decodedToken['webid'];
          Provider.of<VariableProvider>(context, listen: false)
              .updateUserWebID(webId);
          Provider.of<VariableProvider>(context, listen: false)
              .updateAuthData(authData);

          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ProfilePage()));
        },
        child: Text("Se connecter",
            style: GoogleFonts.josefinSans(
                textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 24,
            ))),
      ),
    );
  }

  Widget _signUpLabel(String label, Color textColor) {
    return Text(
      label,
      style: GoogleFonts.josefinSans(
        textStyle: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _signUpButton(String label, Color textColor, BuildContext context) {
    return TextButton(
        onPressed: () {
          // Now we will redirect to register page from here
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const RegisterPage()));
        },
        child: Text(
          label,
          style: GoogleFonts.josefinSans(
            textStyle: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
        ));
  }
}
