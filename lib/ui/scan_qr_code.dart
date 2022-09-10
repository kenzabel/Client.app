import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interface_connection/ui/book_list.dart';
import 'package:interface_connection/ui/qr_scan_screen.dart';
import 'package:interface_connection/widgets/client_widgets.dart';

import '../model/BooksData.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  String? qrCode;
  bool data = false;
  bool isLoading = false;

  List<BooksData> booksDataList = [];
  Future<List<BooksData>> getBooksData() async {
    final String response = await rootBundle.loadString('assets/result.json');
    final data = await json.decode(response);

    for (Map i in data) {
      booksDataList.add(BooksData.fromJson(i));
    }
    print(booksDataList[0].title);
    return booksDataList;
  }

  Future<void> scanQRCode() async {
    final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.QR);

    if (!mounted) return;
    setState(() {
      qrCode = barcodeScanRes;
    });

    getBooksData();
    setState(() {
      isLoading = true;
    });
    isLoading
        ? showDialogBox(context)
        : Navigator.of(context, rootNavigator: true).pop('dialog');
    Timer(const Duration(seconds: 5), () {
      getBooksData();
      setState(() {
        isLoading = false;
      });

      !isLoading
          ? Navigator.of(context, rootNavigator: true).pop('dialog')
          : showDialogBox(context);

      if (qrCode == "library_one") {
        print("Yay!");
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

  @override
  void initState() {
    getBooksData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: twoButtonsAppbar(
        context: context,
        icon1: Icons.arrow_back_ios_new,
        route1: () => Navigator.of(context).pop(),
        title: "Scan QRCode",
        icon2: Icons.notifications,
        route2: () {},
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
                onPressed: () => scanQRCode(),
                child: const Icon(Icons.camera_alt)),
          ],
        ),
      ),
    );
  }
}
