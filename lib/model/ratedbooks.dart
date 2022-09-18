class UserRatedBooks {
  final String ratedBooks;
  UserRatedBooks(this.ratedBooks);

   factory UserRatedBooks.fromJson(Map<String, dynamic> json){
    return UserRatedBooks(
      json["ratedBooks"].toString(), 
    );
  }
  toJson(UserRatedBooks ratedBooks){
    return {
      "ratedBooks" : ratedBooks.ratedBooks.toString(), 
    };
  }
}