class UsereSavedBooks {
  final String savedBooks;
  UsereSavedBooks(this.savedBooks);

   factory UsereSavedBooks.fromJson(Map<String, dynamic> json){
    return UsereSavedBooks(
      json["savedBooks"].toString(), 
    );
  }
  toJson(UsereSavedBooks savedBooks){
    return {
      "savedBooks" : savedBooks.savedBooks.toString(), 
    };
  }
}