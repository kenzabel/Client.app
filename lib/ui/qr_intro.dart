import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interface_connection/providers/variable_provider.dart';
import 'package:interface_connection/ui/homepage.dart';
import 'package:interface_connection/ui/qr_scan_screen.dart';
import 'package:interface_connection/ui/show_profile.dart';
import 'package:provider/provider.dart';
import 'package:solid_auth/solid_auth.dart';

class QRIntroScreen extends StatefulWidget {
  const QRIntroScreen({Key? key}) : super(key: key);

  @override
  State<QRIntroScreen> createState() => _QRIntroScreenState();
}

class _QRIntroScreenState extends State<QRIntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookMate'),
        actions: [
          _profileButton(),
          _logoutButton(context)
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Click here to scan a QR code',
              style: GoogleFonts.josefinSans(
                textStyle:
                    const TextStyle(color: Color(0xff164276), fontSize: 17),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  fixedSize: Size(MediaQuery.of(context).size.width * .40, 50),
                  padding: const EdgeInsets.all(8),
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const QRScanScreen()));
                },
                child: const Icon(Icons.camera_alt)),
          ],
        ),
      ),
    );
  }

  _profileButton() {
    return IconButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ShowProfile()));
        },
        icon: const Icon(Icons.account_circle));
  }

  _logoutButton(BuildContext context){
    VariableProvider provider = Provider.of<VariableProvider>(context, listen: false);
    String logoutUrl = provider.getAuthData['logoutUrl'];
    return IconButton(
        onPressed: () {
          logout(logoutUrl);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
        icon: const Icon(Icons.logout));
  }
}
