class User {
  final String firstName, lastName, email, birthday;
  User(this.firstName, this.lastName, this.email, this.birthday);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json["firstName"],
      json["lastName"],
      json["email"],
      json["birthday"],
    );
  }
  toJson(User user) {
    return {
      "firstName": user.firstName,
      "lastName": user.lastName,
      "email": user.email,
      "birthday": user.birthday,
    };
  }
}
