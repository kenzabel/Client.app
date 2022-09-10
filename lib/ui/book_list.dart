import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  Future<List<BooksData>> getBooksData() async {
    final String response = await rootBundle.loadString('assets/result.json');
    final data = await json.decode(response);

    for (Map i in data) {
      booksDataList.add(BooksData.fromJson(i));
    }
    print(booksDataList[0].title);
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
                                    setState(() {
                                      bookName = "dsdsd";
                                      isChecked = true;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color:
                                        isChecked ? Colors.red : Colors.black,
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
