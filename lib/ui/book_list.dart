import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interface_connection/ui/recommended.dart';

import '../model/BooksData.dart';
import '../widgets/client_widgets.dart';
import 'book_details.dart';

class LibraryBooks extends StatefulWidget {
  const LibraryBooks({super.key});

  @override
  State<LibraryBooks> createState() => _LibraryBooksState();
}

class _LibraryBooksState extends State<LibraryBooks> {
  List<String> booksUri = [];
  List<BooksData> booksDataList = [];
  List<dynamic> chk = [];
  Future<List<BooksData>> getBooksData() async {
    final String response = await rootBundle.loadString('assets/result.json');
    final data = await json.decode(response);

    for (Map i in data) {
      booksDataList.add(BooksData.fromJson(i));
      chk.add({"isChecked": false});
    }
    return booksDataList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: twoButtonsAppbar(
        context: context,
        icon1: Icons.arrow_back_ios_new,
        route1: () => Navigator.of(context).pop(),
        title: "Scan QRCode",
        icon2: Icons.book,
        route2: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const RecommendedBooks()));
        },
      ),
      body: FutureBuilder(
          future: getBooksData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: booksDataList.length,
                    itemBuilder: (context, index) {
                      bool isChecked = false;
                      bool checkBox = false;
                      String? bookName = booksDataList[index].title;
                      String? author = booksDataList[index].author;
                      String? description = booksDataList[index].abstract;
                      bool? fav = booksDataList[index].isFavorite;
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => BooksDetails(
                                    title: bookName,
                                    author: author,
                                    description: description,
                                  )));
                        },
                        child: Card(
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
                                      child: Text('Title : $bookName'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text('Author : $author'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        'Description : $description',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    chk[index]["isChecked"]
                                        ? chk[index]["isChecked"] = false
                                        : chk[index]["isChecked"] = true;
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: chk[index]["isChecked"]
                                        ? Colors.red
                                        : Colors.grey,
                                  ))
                            ],
                          ),
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
