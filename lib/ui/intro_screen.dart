import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '/ui/homepage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final String bookImage = 'images/book.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            title: 'DZ_Lib',
            body: 'Trouvez votre prochain livre',
            image: Image(
              image: AssetImage(bookImage),
            ),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'DZ_Lib',
            body: 'ayez des recommandations personnalisées ',
            image: Image(
              image: AssetImage(bookImage),
            ),
            decoration: getPageDecoration(),
          ),
          PageViewModel(
            title: 'DZ_Lib',
            body:
                'en fonction de vos genres préférés et des livres que vous avez déjà lus',
            image: Image(
              image: AssetImage(bookImage),
            ),
            decoration: getPageDecoration(),
          )
        ],
        done: const Text(
          'Done',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onDone: () async {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setBool('showHomePage', true);
          goHome(context);
        },
        next: const Icon(Icons.arrow_forward),
        nextFlex: 0,
        showSkipButton: true,
        skip: const Text('skip'),
        showBackButton: false,
        back: const Icon(Icons.arrow_back),
        skipOrBackFlex: 0,
        dotsDecorator: getDotsDecorator(),
        animationDuration: 200, // augmenter = ralentir
        isProgressTap:
            true, //false = no action no animation no switching page on click dot just in scrolling
        isProgress: true,
        freeze: false, // if true no switching just with next or back
        onChange: (index) {
          if (kDebugMode) {
            print(index);
          }
        }, //model page numver
      ),
    ); // allow us to implemant a basic layout and set up other widgets
  }

  DotsDecorator getDotsDecorator() {
    return DotsDecorator(
      color: Colors.yellow,
      size: const Size(10, 10),
      activeSize: const Size(22, 10),
      activeColor: Colors.blue,
      activeShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
      bodyTextStyle: TextStyle(fontSize: 20),
      imagePadding: EdgeInsets.all(20),
      titlePadding: EdgeInsets.all(30),
      pageColor: Colors.white,
    );
  }

  void goHome(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    ); // intro une seule fois no back
  }
}
