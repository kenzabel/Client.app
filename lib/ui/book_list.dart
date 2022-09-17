import 'dart:convert';

import 'package:flutter/material.dart';
import '/ui/recommended.dart';
import 'package:provider/provider.dart';

import '../apiwrapper/api_wrapper.dart';
import '../model/BooksData.dart';
import '../providers/variable_provider.dart';
import '../widgets/client_widgets.dart';

class LibraryBooks extends StatefulWidget {
  const LibraryBooks({super.key});

  @override
  State<LibraryBooks> createState() => _LibraryBooksState();
}

class _LibraryBooksState extends State<LibraryBooks> {
  late final Future? getBookDataFuture;
  List<String> booksUri = [];
  List<BooksData> booksDataList = [];
  List<dynamic> chk = [];
  Future<List<String>> getBooksData() async {
    // final String response = await rootBundle.loadString('assets/result.json');
    // final data = await json.decode(response);

    // for (Map i in data) {
    //   booksDataList.add(BooksData.fromJson(i));
    //   chk.add({"isChecked": false});
    // }

    //NewCode
    String bookRoute = 'booksList';
    print("getBookDAta"); //TODO remove print()
    Map<String, dynamic> bookData = {
      "webId": //"https://aidayahiaoui201.solidcommunity.net/profile/card#me",
          Provider.of<VariableProvider>(context, listen: false).getUserWebID,
    };
    print(bookData['webId']);

    String jsonData = jsonEncode(bookData);
    var data2 =
        await CallAPI.apiMModule.postResponse(bookRoute, jsonData, null);
    var urls = data2['@graph'][0]['voc:save'];
    //Left for checking

    for (var each in urls) {
      booksUri.add(each['@id']);
      chk.add({"isChecked": false});
    }
    return booksUri;
  }

  @override
  void initState() {
    CallAPI.init();
    super.initState();
    getBookDataFuture = getBooksData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: twoButtonsAppbar(
        context: context,
        icon1: Icons.arrow_back_ios_new,
        route1: () => Navigator.of(context).pop(),
        title: "Book Mate",
        icon2: Icons.book,
        route2: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const RecommendedBooks()));
        },
      ),
      body: FutureBuilder(
          future: getBookDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: booksUri.length,
                    itemBuilder: (context, index) {
                      bool isChecked = false;
                      bool checkBox = false;
                      String? bookName = booksUri[index];
                      String? author = "Author"; //booksDataList[index].author;
                      String? description = "Description";
                      // booksDataList[index].abstract;
                      return Card(
                        elevation: 5.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(bookName),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(4.0),
                                  //   child: Text('Author : $author'),
                                  // ),
                                  // Padding(
                                  //   padding: const EdgeInsets.all(4.0),
                                  //   child: Text(
                                  //     'Description : $description',
                                  //     overflow: TextOverflow.ellipsis,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            // ? Checkbox(
                            //     side: const BorderSide(
                            //       color: Colors.black,
                            //     ),
                            //     value: chk[index]['isChecked'],
                            //     onChanged: (v) {
                            //       chk[index]["isChecked"]
                            //           ? chk[index]["isChecked"] = false
                            //           : chk[index]["isChecked"] = true;
                            //       setState(() {});
                            //     })
                            // :
                            IconButton(
                              onPressed: () {
                                chk[index]["isChecked"]
                                    ? chk[index]["isChecked"] = false
                                    : chk[index]["isChecked"] = true;
                                setState(() {});
                              },
                              icon: Icon(
                                chk[index]["isChecked"]
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: Text('Fetching Data'),
                );
              }
            } else {
              return const Center(
                child: Text('Something went wrong!'),
              );
            }
          }),
    );
  }
}
