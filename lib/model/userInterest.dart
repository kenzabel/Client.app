class UserInterest {
  final String interest;
  UserInterest(this.interest);

   factory UserInterest.fromJson(Map<String, dynamic> json){
    return UserInterest(
      json["interest"].toString(), 
    );
  }
  toJson(UserInterest userinterest){
    return {
      "interest" : userinterest.interest.toString(), 
    };
  }
}