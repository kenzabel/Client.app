import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import '/apiwrapper/api_wrapper.dart';
import '/providers/profile_provider.dart';
import '/providers/variable_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateData {
  late String newFirstName, newLastName, newEmail, newBirthDate;
}

class EditProfile extends StatefulWidget {
  const EditProfile({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.birthDate,
  }) : super(key: key);

  final String firstName;
  final String lastName;
  final String email;
  final String birthDate;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  late MediaQueryData _mediaQueryData;

  initializeData() {
    _firstNameController.text = widget.firstName;
    _lastNameController.text = widget.lastName;
    _emailController.text = widget.email;
    _birthDateController.text = widget.birthDate;
  }

  void checkValidations(ProfileProvider provider) {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String email = _emailController.text;
    String birthDate = _birthDateController.text;

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
    } else {
      sendProfileData(firstName, lastName, email, birthDate);
    }
  }

  sendProfileData(firstName, lastName, email, birthDate) async {
    String route = "profile";
    Map<String, dynamic> profileData = {
      "webId":
          Provider.of<VariableProvider>(context, listen: false).getUserWebID,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "birthDate": birthDate,
      "gender": ""
    };

    String jsonData = jsonEncode(profileData);
    if (kDebugMode) {
      print("JSON Data For API : " + jsonData);
    }

    saveProfileData(firstName, lastName, email, birthDate);
    UpdateData updateData = UpdateData();
    updateData.newFirstName = firstName;
    updateData.newLastName = lastName;
    updateData.newEmail = email;
    updateData.newBirthDate = birthDate;

    Navigator.pop(context, updateData);
  }

  void saveProfileData(firstName, lastName, email, birthDate) {
    Provider.of<VariableProvider>(context, listen: false)
        .updateFirstName(firstName);
    Provider.of<VariableProvider>(context, listen: false)
        .updateLastName(lastName);
    Provider.of<VariableProvider>(context, listen: false).updateEmail(email);
    Provider.of<VariableProvider>(context, listen: false)
        .updateBirthDate(birthDate);
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

  @override
  void initState() {
    // implement initState
    super.initState();
    CallAPI.init();
    initializeData();
  }

  @override
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
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(_mediaQueryData.size.width * .85, 40),
                  padding: const EdgeInsets.all(8),
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                onPressed: () => checkValidations(provider),
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
