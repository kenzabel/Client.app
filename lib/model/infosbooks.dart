class InfosBook {
  final String infosBooks;
  InfosBook(this.infosBooks);

   factory InfosBook.fromJson(Map<String, dynamic> json){
    return InfosBook(
      json["infosBooks"].toString(),
    );
  }
  toJson(InfosBook infosBook){
    return {
       "uri" : infosBook.infosBooks.toString(),

    
    };
  }
}

