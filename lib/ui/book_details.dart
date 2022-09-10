import 'package:flutter/material.dart';

import '../widgets/client_widgets.dart';

class BooksDetails extends StatefulWidget {
  const BooksDetails({super.key, this.title, this.author, this.description});
  final String? title;
  final String? author;
  final String? description;

  @override
  State<BooksDetails> createState() => _BooksDetailsState();
}

class _BooksDetailsState extends State<BooksDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: twoButtonsAppbar(
        context: context,
        icon1: Icons.arrow_back_ios_new,
        route1: () => Navigator.of(context).pop(),
        title: "Book Details",
      ),
      body: ListView(
        children: [
          detailCard(
            context: context,
            title: widget.title,
            author: widget.author,
            img: "images/book.jpg",
            description: widget.description,
          ),
        ],
      ),
    );
  }
}
