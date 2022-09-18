import 'package:flutter/material.dart';
import '/controllers/userCont.dart';
import '/model/recommendations.dart';
import '/model/infosbooks.dart';

class RecommendedBooksScreen extends StatefulWidget {
  final InfosBook infosBook;
  RecommendedBooksScreen({required this.infosBook});

  @override
  State<RecommendedBooksScreen> createState() => _RecommendedBooksState();
}

class _RecommendedBooksState extends State<RecommendedBooksScreen> {
  Future<UsereRcommendations>? usereRcommendations;
  UserCont userCont = UserCont();

  @override
  Widget build(BuildContext context) {
    var data = widget.infosBook.infosBooks;

    data = data.substring(1, data.length - 2);
    var recommendedBooks = data.split('},');

    return Scaffold(
        backgroundColor: const Color(0xffdee2fe),
        body: listBooks(recommendedBooks));
  }

  Widget listBooks(List<String> books) {
    return ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          var elem = books[index].split(',');
          var uri = elem[0].substring(6, elem[0].length);
          var title = elem[1].substring(7, elem[1].length);
          var author = elem[2].substring(9, elem[2].length);
          var genre = elem[3].substring(6, elem[3].length);
          if (genre.split('http').length > 1) genre = genre.split('/')[4];
          var abstract = elem[5].substring(10, elem[5].length);
          return Card(
            elevation: 5.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Text(
                              'Title :',
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(title)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          children: [
                            Text(
                              'Author :',
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(author)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          'Description :',
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Expanded(child: Text(abstract))),
                    ],
                  ),
                ), //Text(ratingValue[index])
              ],
            ),
          );
        });
  }

  Widget listProfile(IconData icon, String text2) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(
            width: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text2,
                style: const TextStyle(
                  color: Colors.black87,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
