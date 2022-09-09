import 'package:flutter/foundation.dart';

class VariableProvider extends ChangeNotifier {

  String userWebID = "";
  String username = "";
  String password = "";
  String firstName = "";
  String lastName = "";
  String email = "";
  String birthDate = "";
  String gender = "";
  bool isLoading = false;
  late Map<dynamic,dynamic> authData;

  String get getUserWebID => userWebID;
  String get getUsername => username;
  String get getPassword => password;
  String get getFirstName => firstName;
  String get getLastName => lastName;
  String get getEmail => email;
  String get getBirthDate => birthDate;
  String get getGender => gender;
  bool get getIsLoading => isLoading;
  Map<dynamic,dynamic> get getAuthData => authData;

  void updateUserWebID(String webID) {
    userWebID = webID;
    if (kDebugMode) {
      print("webID from data : " + userWebID);
    }
  }

  void updateAuthData(Map<dynamic,dynamic> userAuthData){
    authData = userAuthData;
  }

  void updateUsername(String newUsername) {
    username = newUsername;
    if (kDebugMode) {
      print("Username stored: " + username);
    }
  }

  void updatePassword(String newPassword) {
    password = newPassword;
    if (kDebugMode) {
      print("Password stored: " + password);
    }
  }

  void updateFirstName(String newFirstName) {
    firstName = newFirstName;
    if (kDebugMode) {
      print("FirstName stored: " + firstName);
      notifyListeners();
    }
  }

  void updateLastName(String newLastName) {
    lastName = newLastName;
    if (kDebugMode) {
      print("LastName stored: " + lastName);
      notifyListeners();
    }
  }

  void updateEmail(String newEmail) {
    email = newEmail;
    if (kDebugMode) {
      print("Email stored: " + email);
      notifyListeners();
    }
  }

  void updateBirthDate(String newBirthDate) {
    birthDate = newBirthDate;
    if (kDebugMode) {
      print("BirthDate stored: " + birthDate);
      notifyListeners();
    }
  }

  void updateGender(String newGender) {
    gender = newGender;
    if (kDebugMode) {
      print("Gender stored: " + gender);
    }
  }

  void updateIsLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
