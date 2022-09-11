import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/BooksData.dart';
import '../widgets/client_widgets.dart';
import 'book_details.dart';

class RecommendedBooks extends StatefulWidget {
  const RecommendedBooks({super.key});
  @override
  State<RecommendedBooks> createState() => _RecommendedBooksState();
}

class _RecommendedBooksState extends State<RecommendedBooks> {
  List<String> booksUri = [];
  List<BooksData> booksDataList = [];
  List<BooksData> booksRepo = [];
  List<dynamic> chk = [];
  bool isLoading = true;

  Future<List<BooksData>> getBooksData() async {
    final String response = await rootBundle.loadString('assets/result.json');
    final data = await json.decode(response);

    for (Map i in data) {
      booksDataList.add(BooksData.fromJson(i));
      chk.add({"isChecked": false});
    }
    setState(() {
      isLoading = false;
    });
    return booksDataList;
  }

  @override
  void initState() {
    getBooksData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      appBar: twoButtonsAppbar(
        context: context,
        icon1: Icons.arrow_back_ios_new,
        route1: () => Navigator.of(context).pop(),
        title: "Recomended Books",
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: screenHeight(context),
              width: screenWidth(context),
              child: ListView(
                children: [
                  Container(
                    height: screenHeight(context) * 0.20,
                    child: ListView.builder(
                      primary: false,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: booksDataList.length,
                      itemBuilder: (context, index) {
                        return productCategory(
                            context: context,
                            title: booksDataList[index].genre,
                            img: 'images/book.jpg');
                      },
                    ),
                  ),
                  Text(
                    "You may also like",
                    style: GoogleFonts.inter(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  YMargin(10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: GridView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: booksDataList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                (orientation == Orientation.portrait) ? 2 : 3),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BooksDetails(
                                        title: booksDataList[index].title,
                                        author: booksDataList[index].author,
                                        description:
                                            booksDataList[index].abstract,
                                      )));
                            },
                            child: Card(
                              child: GridTile(
                                footer: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      booksDataList[index].title.toString()),
                                ),
                                child: Image.asset(
                                    'images/beach.jpeg'), //just for testing, will fill with image later
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
