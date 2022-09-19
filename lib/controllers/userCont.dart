import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../model/infosbooks.dart';
import '/model/infoPers.dart';
import 'dart:convert';
import '/model/ratedbooks.dart';
import '/model/recommendations.dart';
import '/model/savedbooks.dart';
import '/model/userInterest.dart';

class UserCont {
  Future<User> getData() async {
    final response = await http
        .get(Uri.parse('https://libtoolapi.herokuapp.com/users/provider'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON or create a class w diri object ta3ha as you want.
      User user = User.fromJson(jsonDecode(response.body));
      return user;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to get data');
    }
  }

  Future<User> postUser(Map<String, dynamic> json) async {
    Response response;
    var dio = Dio();
    response = await dio.post("https://bookmateapi.herokuapp.com/users/getInfo",
        data: json);
    if (response.statusCode == 200) {
      Map<String, dynamic> res = (response.data) as Map<String, dynamic>;
      print("inside fucn " + res.toString());
      User user = User.fromJson(res);
      print(user);
      // then parse the JSON.
      return user;
    } else {
      // then throw an exception.
      throw Exception('Failed to post.');
    }
  }

  Future<UserInterest> postGenre(Map<String, dynamic> json) async {
    Response response;
    var dio = Dio();
    response = await dio
        .post("https://bookmateapi.herokuapp.com/users//getGenres", data: json);
    if (response.statusCode == 200) {
      Map<String, dynamic> res = (response.data) as Map<String, dynamic>;
      UserInterest userInterest = UserInterest.fromJson(res);
      // then parse the JSON.
      return userInterest;
    } else {
      // then throw an exception.
      throw Exception('Failed to post.');
    }
  }

  Future<UsereSavedBooks> getSavedBooks(Map<String, dynamic> json) async {
    Response response;
    var dio = Dio();
    response = await dio.post(
        "https://bookmateapi.herokuapp.com/users/getSavedBooks",
        data: json);
    if (response.statusCode == 200) {
      Map<String, dynamic> res = (response.data) as Map<String, dynamic>;
      UsereSavedBooks usereSavedBooks = UsereSavedBooks.fromJson(res);
      // then parse the JSON.
      return usereSavedBooks;
    } else {
      // then throw an exception.
      throw Exception('Failed to post.');
    }
  }

  Future<UserRatedBooks> getRatedBooks(Map<String, dynamic> json) async {
    Response response;
    var dio = Dio();
    response = await dio.post(
        "https://bookmateapi.herokuapp.com/users/getRatedBooks",
        data: json);
    if (response.statusCode == 200) {
      Map<String, dynamic> res = (response.data) as Map<String, dynamic>;
      UserRatedBooks usereRatedBooks = UserRatedBooks.fromJson(res);
      // then parse the JSON.
      return usereRatedBooks;
    } else {
      // then throw an exception.
      throw Exception('Failed to post.');
    }
  }

  Future<InfosBook> getInfosBook(Map<String, dynamic> json) async {
    Response response;
    var dio = Dio();
    response = await dio.post(
        "https://infosbookapi.herokuapp.com/users/getInfosBook",
        data: json);
    if (response.statusCode == 200) {
      Map<String, dynamic> res = (response.data) as Map<String, dynamic>;
      InfosBook infosBook = InfosBook.fromJson(res);
      // then parse the JSON.
      return infosBook;
    } else {
      // then throw an exception.
      throw Exception('Failed to post.');
    }
  }

  Future<UsereRcommendations> postRecommendations(
      Map<String, dynamic> json) async {
    Response response;
    var dio = Dio();
    response = await dio.post(
        "https://srlods.herokuapp.com/users/recommendationsUser",
        data: json);

    if (response.statusCode == 200) {
      Map<String, dynamic> res = (response.data) as Map<String, dynamic>;
      UsereRcommendations usereRcommendations =
          UsereRcommendations.fromJson(res);
      // then parse the JSON.
      return usereRcommendations;
    } else {
      // then throw an exception.
      throw Exception('Failed to post.');
    }
  }
}
