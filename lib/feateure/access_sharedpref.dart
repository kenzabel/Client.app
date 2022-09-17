import 'package:shared_preferences/shared_preferences.dart';

class AccessSharedpref {
  final _firstName = "fname";
  final _lastName = 'lname';
  final _email = 'email';
  final _dob = 'bday';
  final _gender = "gender";
  final _id = 'id';
  final _loadFlag = 'loadProfile';

  final SharedPreferences sp;
  AccessSharedpref(this.sp);

  ///Stores the profile in SharedPrefence
  Future<void> storeData({
    required String fname,
    required String lname,
    required String email,
    required String bDay,
    required String gender,
  }) async {
    await sp.setString(_firstName, fname);
    await sp.setString(_lastName, lname);
    await sp.setString(_email, email);
    await sp.setString(_dob, bDay);
    await sp.setString(_gender, gender);
  }

  ///Returns map with [fname, lname, email, bday, gender] keys
  Map<String, String> getProfileData() {
    Map<String, String> map = {};
    map['fname'] = sp.getString(_firstName) ?? "";
    map['lname'] = sp.getString(_lastName) ?? "";
    map['email'] = sp.getString(_email) ?? "";
    map['bday'] = sp.getString(_dob) ?? "";
    map['gender'] = sp.getString(_gender) ?? "";

    return map;
  }

  ///Sets the flag
  Future<void> setBool(bool flag) async {
    await sp.setBool(_loadFlag, flag);
  }

  ///getter for flag
  bool getBool() => sp.getBool(_loadFlag) ?? true;

  ///webId setter
  Future<void> setId(String id) async {
    await sp.setString(_id, id);
  }

  ///WebId getter
  String getId() => sp.getString(_id) ?? "";
}
