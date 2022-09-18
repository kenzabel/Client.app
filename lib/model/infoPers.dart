class User {
  final String firstName, lastName, BookCaseName;
  User(this.firstName, this.lastName, this.BookCaseName);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json["firstName"],
      json["lastName"],
      json["BookCaseName"],
    );
  }
  toJson(User user) {
    return {
      "firstName": user.firstName,
      "lastName": user.lastName,
      "BookCaseName": user.BookCaseName,
    };
  }
}
