import 'package:flutter/material.dart';

import '../controllers/userCont.dart';
import '../model/infoPers.dart';
import '../model/infosbooks.dart';
import '../model/savedbooks.dart';
import '../ui/genres.dart';
import '../ui/profileScreen.dart';
import '../ui/ratedBooksScreen.dart';
import '../ui/savedBooksScreen.dart';
import '/model/ratedbooks.dart';
import '/model/recommendations.dart';
import '/model/savedbooks.dart';
import '/model/userInterest.dart';

class QrDrawer extends StatelessWidget {
  final String webId;
  QrDrawer(this.webId, {Key? key}) : super(key: key);
  final UserCont userCont = UserCont();
  @override
  Widget build(BuildContext context) {
    final webIDPattern = RegExp(r'(https:\/\/)?([a-zA-Z0-9]*)\.solid');
    final matchwebId = webIDPattern.firstMatch(webId);
    print("from regex" + (matchwebId?.group(2) ?? ""));
    final webIdExtracted =
        "https://${matchwebId!.group(2)!}.solidcommunity.net";
    print(webIdExtracted);
    // webId = webId.
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset("images/BookMate.png"),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text(
            'Personal information',
            style: TextStyle(fontSize: 20),
          ),
          onTap: () async {
            Map<String, dynamic> json = {"webId": webIdExtracted};
            User user = await userCont.postUser(json);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileScreen(user: user)));
          },
        ),
        ListTile(
          leading: const Icon(Icons.bookmark_add_outlined),
          title: const Text(
            'Saved books',
            style: TextStyle(fontSize: 20),
          ),
          onTap: () async {
            Map<String, dynamic> json = {"webId": webIdExtracted};
            UsereSavedBooks usereSavedBooks =
                await userCont.getSavedBooks(json);
            var data = usereSavedBooks.savedBooks;
            data = data.substring(1, data.length - 1);
            var savedBooks = data.split(',');

            Map<String, dynamic> json2 = {"uris": savedBooks.toString()};
            InfosBook infosBook = await userCont.getInfosBook(json2);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SavedBooksScreen(infosBook: infosBook)));
          },
        ),
        ListTile(
          leading: Icon(Icons.star),
          title: Text(
            'Rated books',
            style: TextStyle(fontSize: 20),
          ),
          onTap: () async {
            Map<String, dynamic> json = {"webId": webIdExtracted};
            UserRatedBooks userRatedBooks = await userCont.getRatedBooks(json);
            var data = userRatedBooks.ratedBooks;
            data = data.substring(1, data.length - 1);
            var ratedBooks = data.split(',');
            var ratingValue = '';
            for (var i = 0; i < ratedBooks.length; i++) {
              var element = ratedBooks[i].split('ratingValue');
              ratedBooks[i] = element[0];
              ratingValue = ratingValue + element[1] + ',';
            }
            ratingValue = ratingValue.substring(0, ratingValue.length - 2);
            var ratingValues = ratingValue.split(',');
            var uris = "[";
            for (var i = 0; i < ratedBooks.length; i++) {
              uris = uris + ratedBooks[i].trim();
            }
            Map<String, dynamic> json2 = {"uris": ratedBooks.toString()};
            InfosBook infosBook = await userCont.getInfosBook(json2);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        RatedBooksScreen(infosBook: infosBook)));
          },
        ),
        ListTile(
          leading: Icon(Icons.interests),
          title: Text(
            'Interests',
            style: TextStyle(fontSize: 20),
          ),
          onTap: () async {
            Map<String, dynamic> json = {"webId": webIdExtracted};
            UserInterest userInterest = await userCont.postGenre(json);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        GenreScreen(userInterest: userInterest)));
          },
        ),
      ],
    ));
  }
}
