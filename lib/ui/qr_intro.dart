import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import '/providers/variable_provider.dart';
import '/ui/homepage.dart';
import '/ui/show_profile.dart';
import 'package:provider/provider.dart';
import 'package:solid_auth/solid_auth.dart';

import '../widgets/client_widgets.dart';
import 'book_list.dart';

class QRIntroScreen extends StatefulWidget {
  const QRIntroScreen({Key? key}) : super(key: key);

  @override
  State<QRIntroScreen> createState() => _QRIntroScreenState();
}

class _QRIntroScreenState extends State<QRIntroScreen> {
  String qrCode = "";
  bool data = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    print("Does webid exists?" + Provider.of<VariableProvider>(context).email);
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookMate'),
        actions: [_profileButton(), _logoutButton(context)],
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
                  scanQRCode();
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => const QRScanScreen()));
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
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => const ShowProfile()));
        },
        icon: const Icon(Icons.account_circle));
  }

  _logoutButton(BuildContext context) {
    VariableProvider provider =
        Provider.of<VariableProvider>(context, listen: false);
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

  Future<void> scanQRCode() async {
    final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.QR);
    qrCode = barcodeScanRes;
    if (!mounted) return;
    setState(() {
      qrCode = barcodeScanRes;
    });

    setState(() {
      isLoading = true;
    });
    isLoading
        ? showDialogBox(context)
        : Navigator.of(context, rootNavigator: true).pop('dialog');
    Timer(const Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });

      !isLoading
          ? Navigator.of(context, rootNavigator: true).pop('dialog')
          : showDialogBox(context);

      if (qrCode.isNotEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(qrCode)));
        Provider.of<VariableProvider>(context, listen: false)
            .updateUserWebID(qrCode);
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const LibraryBooks()));
      } else {
        showError(context);
      }
    });

    setState(() {
      isLoading = false;
    });
  }
}
