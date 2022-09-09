import 'package:flutter/foundation.dart';

// this is the place where our variable operates
// Instead of setState we simply get variable value from here and update it using this function
class ProfileProvider extends ChangeNotifier {
  String? gender;
  DateTime? birthDate;
  String birthDateString = "";

  String? get getGender => gender;
  DateTime? get getBirthDate => birthDate;
  String get getBirthDateString => birthDateString;

  void updateGender(String value) {
    gender = value;
    // Once we update the value we simply call notifyListeners..
    // To inform that our value is updated
    // and once it's notifies the listeners
    notifyListeners();
  }

  void updateBirthDate(newDate) {
    birthDate = newDate;
  }

  void updateBirthDateString(newString) {
    birthDateString = newString;
  }
}
