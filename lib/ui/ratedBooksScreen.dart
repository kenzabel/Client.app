import 'package:flutter/material.dart';
import '/controllers/userCont.dart';
import '/model/infosbooks.dart';
import '/model/ratedbooks.dart';
import 'book_details.dart';

class RatedBooksScreen extends StatefulWidget {
  final InfosBook infosBook;
  RatedBooksScreen({required this.infosBook});

  @override
  State<RatedBooksScreen> createState() => _RatedBooksState();
}

class _RatedBooksState extends State<RatedBooksScreen> {
  Future<UserRatedBooks>? userRatedBooks;
  UserCont userCont = UserCont();

  @override
  Widget build(BuildContext context) {
    var data = widget.infosBook.infosBooks;
    data = data.substring(1, data.length - 2);
    var ratedBooks = data.split('},');

    return Scaffold(
        appBar: AppBar(title: const Text("Rated Books")),
        backgroundColor: const Color(0xffdee2fe),
        body: listBooks(ratedBooks));
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

          return _getCardWithButton(title, author, genre, abstract);
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

  Card _getCard(title, author, genre, abstract) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Title :',
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      Expanded(child: Text(title))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      const Text(
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
                const Padding(
                  padding: EdgeInsets.all(4.0),
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
          ),
        ],
      ),
    );
  }

  Widget _getCardWithButton(title, author, genre, abstract) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BooksDetails(
                  title: title,
                  author: author,
                  description: abstract,
                )));
      },
      child: _getCard(title, author, genre, abstract),
    );
  }
}
