import 'dart:convert';

import 'package:client_app/ui/recommendedBooks.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/userCont.dart';
import '../model/BooksData.dart';
import '../model/infosbooks.dart';
import '../model/recommendations.dart';
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
  final _ctrlr = TextEditingController();

  Future<List<BooksData>> getBooksData() async {
    final String response =
        await rootBundle.loadString('assets/recommended.json');
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
        title: "Recommended Books",
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _textField(),
    );
  }

  Widget _textField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          "Enter your Recommendation System",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black12,
          ),
          child: TextField(
            controller: _ctrlr,
            decoration: const InputDecoration(hintText: "Enter URL"),
            maxLines: 1,
          ),
        ),
        TextButton(
            onPressed: _addSystem,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue.shade400,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              child: const Text(
                "Get recommandations",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )),
      ],
    );
  }

  void _addSystem() async {
    Map<String, dynamic> json = {
      "webId": "https://aidayahiaoui201.solidcommunity.net"
    };
    UsereRcommendations usereRcommendations =
        await UserCont().postRecommendations(json);
    var data = usereRcommendations.recommendedBooks;
    var recommendations = data.split(',');
    var score = '';
    for (var i = 0; i < recommendations.length; i++) {
      var element = recommendations[i].split('score');
      recommendations[i] = element[0];
      score = score + element[1] + ',';
    }
    score = score.substring(0, score.length - 1);
    var scores = score.split(',');
    Map<String, dynamic> json2 = {"uris": recommendations.toString()};
    InfosBook infosBook = await UserCont().getInfosBook(json2);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                RecommendedBooksScreen(infosBook: infosBook)));
  }
}
