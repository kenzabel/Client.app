import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '/apiwrapper/api_wrapper.dart';
import '/feateure/access_sharedpref.dart';
import '/providers/profile_provider.dart';
import '/providers/variable_provider.dart';
import '/ui/categories.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // We can't keep these controllers like this all the time..
  // So whenver our app or page closed we should close or dispose these controllers
  // for that we use dispose method to perform any task before closing the page.
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();

  late MediaQueryData _mediaQueryData;

  // This method or function is used to check entered data is valid or not
  // Like if we're passing blank name, or invalid email address etc.
  void checkValidations(ProfileProvider provider) {
    // Fluttertoast is used to show some message at bottom for a second
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String email = _emailController.text;
    String birthDate = _birthDateController.text;
    String gender = provider.getGender ?? "";
    // Using ?? means It will check if the value is null or not
    // If value is null then it will return value given after ??

    if (firstName.isEmpty) {
      Fluttertoast.showToast(
          msg: "Enter First Name",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (lastName.isEmpty) {
      Fluttertoast.showToast(
          msg: "Enter Last Name",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (email.isEmpty) {
      Fluttertoast.showToast(
          msg: "Enter email",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (!EmailValidator.validate(email)) {
      Fluttertoast.showToast(
          msg: "Enter valid email address",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (birthDate.isEmpty) {
      Fluttertoast.showToast(
          msg: "Select Birthdate From Calender",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else if (gender == "") {
      Fluttertoast.showToast(
          msg: "Select Gender",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 16.0);
      return;
    } else {
      // After checking all errors if everything is okay then we save this data.

      sendProfileData(firstName, lastName, email, birthDate, gender);

      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const CategoriesPage()));
    }
  }

  sendProfileData(firstName, lastName, email, birthDate, gender) async {
    String route = "profile";
    Map<String, dynamic> profileData = {
      "webId":
          Provider.of<VariableProvider>(context, listen: false).getUserWebID,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "birthDate": birthDate,
      "gender": gender
    };

    final prefs = AccessSharedpref(await SharedPreferences.getInstance());

    await prefs.setBool(false);
    await prefs.setId(
        Provider.of<VariableProvider>(context, listen: false).getUserWebID);
    await prefs.storeData(
        fname: firstName,
        lname: lastName,
        email: email,
        bDay: birthDate,
        gender: gender);

    saveProfileData(firstName, lastName, email, birthDate, gender);
  }

  void saveProfileData(firstName, lastName, email, birthDate, gender) {
    Provider.of<VariableProvider>(context, listen: false)
        .updateFirstName(firstName);
    Provider.of<VariableProvider>(context, listen: false)
        .updateLastName(lastName);
    Provider.of<VariableProvider>(context, listen: false).updateEmail(email);
    Provider.of<VariableProvider>(context, listen: false)
        .updateBirthDate(birthDate);
    Provider.of<VariableProvider>(context, listen: false).updateGender(gender);
  }

  void openDatePicker(ProfileProvider provider) async {
    final datePick = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (datePick != null && datePick != provider.getBirthDate) {
      provider.updateBirthDate(datePick);
      provider.updateBirthDateString(
          "${provider.getBirthDate!.month}/${provider.getBirthDate!.day}/${provider.getBirthDate!.year}");
      _birthDateController.text = provider.getBirthDateString;
    }
  }

  void setControllers() async {
    final map = AccessSharedpref(await SharedPreferences.getInstance())
        .getProfileData();
    _firstNameController.text = map['fname']!;
    _lastNameController.text = map['lname']!;
    _birthDateController.text = map['bday']!;
    _emailController.text = map['email']!;
  }

  @override
  void initState() {
    super.initState();
    CallAPI.init();
    setControllers();
  }

  @override
  //dispose method calls whenever we leave the page or close the app..
  //so basically we need to close all controllers before it leave the page so we disposed all controllers inside dispose method
  void dispose() {
    // implement dispose
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Here we made instance of our ProfileProvider using which we can access our data.
    ProfileProvider provider = Provider.of<ProfileProvider>(context);

    _mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Personal Information',
                style: GoogleFonts.josefinSans(
                  textStyle: const TextStyle(color: Colors.black, fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextField(
                  controller: _firstNameController,
                  cursorColor: Colors.blue,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                    labelText: 'First Name',
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'Enter First Name',
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextField(
                  controller: _lastNameController,
                  cursorColor: Colors.blue,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                    labelText: 'Last Name',
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'Enter Last Name',
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextField(
                  controller: _emailController,
                  cursorColor: Colors.blue,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'Enter Email',
                    hintStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: TextField(
                  controller: _birthDateController,
                  readOnly: true,
                  cursorColor: Colors.blue,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                    labelText: 'Birth Date',
                    labelStyle: const TextStyle(color: Colors.black),
                    hintText: 'Pick date from calender',
                    hintStyle: const TextStyle(color: Colors.black),
                    suffixIcon: IconButton(
                        onPressed: () => openDatePicker(provider),
                        icon: const Icon(Icons.calendar_today)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Row(
                  children: [
                    const Text(
                      'Gender : ',
                      style: TextStyle(fontSize: 15),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: RadioListTile(
                        title: const Text('Male'),
                        value: "Male",
                        // Here we will get data from provider
                        // Using this we got the value of gender
                        // our provider.getGender will fetch new value..
                        groupValue: provider.getGender,
                        onChanged: (value) {
                          // now  we need to change the value
                          //when the radio button selected or changed

                          // setState is used to change the variable value that depends on ui
                          // This is called state management.. but this is not recommended to use
                          // Because setState method reloads the complete build method

                          // Now we no longer need setState
                          // This will update variable value
                          provider.updateGender(value.toString());

                          if (kDebugMode) {
                            print("Gender : " + provider.getGender!);
                          }
                        },
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: RadioListTile(
                        title: const Text('Female'),
                        value: "Female",
                        groupValue: provider.getGender,
                        onChanged: (value) {
                          provider.updateGender(value.toString());

                          if (kDebugMode) {
                            print("Gender : " + provider.getGender!);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(_mediaQueryData.size.width * .85, 40),
                  padding: const EdgeInsets.all(8),
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                onPressed: () => checkValidations(provider),
                // onPressed: () {
                //   Navigator.of(context).push(MaterialPageRoute(
                //       builder: (context) => const CategoriesPage()));
                // },
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
