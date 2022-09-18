class UsereRcommendations {
  final String recommendedBooks;
  UsereRcommendations(this.recommendedBooks);

   factory UsereRcommendations.fromJson(Map<String, dynamic> json){
    return UsereRcommendations(
      json["recommendedBooks"].toString(), 
    );
  }
  toJson(UsereRcommendations recommendations){
    return {
      "recommendedBooks" : recommendations.recommendedBooks.toString(), 
    };
  }
}