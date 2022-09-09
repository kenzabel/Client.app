// ignore_for_file: sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interface_connection/apiwrapper/api_wrapper.dart';
import 'package:interface_connection/datafiles/categories_list.dart';
import 'package:interface_connection/providers/categories_provider.dart';
import 'package:interface_connection/providers/variable_provider.dart';
import 'package:interface_connection/ui/qr_intro.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late MediaQueryData _mediaQueryData;

  saveToPod(CategoriesProvider provider) async {
    provider.updateIsLoading(true);
    if (kDebugMode) {
      print('Category Selected');
    }
    Map<String, dynamic> listOfSelectedCategories = {
      "webId":
          Provider.of<VariableProvider>(context, listen: false).getUserWebID,
      "username":
          Provider.of<VariableProvider>(context, listen: false).getUsername,
      "password":
          Provider.of<VariableProvider>(context, listen: false).getPassword,
      "categories": selectedCategories
    };

    if (kDebugMode) {
      print('List of categories : ' + selectedCategories.toString());
    }
    String route = "categories";

    String jsonData = jsonEncode(listOfSelectedCategories);
    if (kDebugMode) {
      print("JSON Data For API : " + jsonData);
    }

    var data = await CallAPI.apiMModule
        .postResponse(route, listOfSelectedCategories, null);

    if (kDebugMode) {
      print("Message from api : ${data.toString()}");
    }

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const QRIntroScreen()));

    provider.updateIsLoading(false);
  }

  @override
  Widget build(BuildContext context) {
    CategoriesProvider provider = Provider.of<CategoriesProvider>(context);
    _mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: Text(
                  'Select your favourite genres',
                  style: GoogleFonts.josefinSans(
                    textStyle:
                        const TextStyle(color: Color(0xff164276), fontSize: 25),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'These genres you select help us find out your taste and what you would like as suggestions',
                  style: GoogleFonts.josefinSans(
                    textStyle:
                        const TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      childAspectRatio:
                          1 / _mediaQueryData.size.aspectRatio * 2),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: categories[index].isChecked,
                            onChanged: (value) {
                              provider.updateCheckBoxValue(index, value);
                            },
                          ),
                          Text(
                            categories[index].bookName,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(_mediaQueryData.size.width * .85, 40),
                    padding: const EdgeInsets.all(8),
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                  ),
                  onPressed: () {
                    selectedCategories.clear();
                    for (int i = 0; i < categories.length; i++) {
                      if (categories[i].isChecked == true) {
                        selectedCategories.add(categories[i].bookName);
                      }
                    }
                    if (selectedCategories.isEmpty) {
                      Fluttertoast.showToast(
                          msg: "Select at least one category",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.black45,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      // saveToPod(provider);
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const QRIntroScreen())
                      );
                    }
                  },
                  child: const Text(
                    'Save Categories',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
          provider.isLoading ? const CircularProgressIndicator() : Container()
        ],
      ),
    );
  }
}
