import 'package:flutter/material.dart';
import 'package:interface_connection/providers/categories_provider.dart';
import 'package:interface_connection/providers/profile_provider.dart';
import 'package:interface_connection/providers/variable_provider.dart';
import 'package:interface_connection/ui/homepage.dart';
import 'package:interface_connection/ui/intro_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  // This is called the app level implementation of provider..
  // Multiple provider means we can add as many we want
  // Like one provider for profile, another for data etc.

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final bool showHomePage = preferences.getBool('showHomePage') ?? false;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ChangeNotifierProvider(create: (_) => VariableProvider()),
      ChangeNotifierProvider(create: (_) => CategoriesProvider()),
    ],
    child: MyApp(showHomePage: showHomePage,),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.showHomePage}) : super(key: key);
  final bool showHomePage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login app',
        home: showHomePage ? const HomePage() : const IntroScreen());
  }
}
