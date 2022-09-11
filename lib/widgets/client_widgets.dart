import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar twoButtonsAppbar({
  context,
  String? title,
  IconData? icon1,
  IconData? icon2,
  Function()? route1,
  Function()? route2,
}) {
  return AppBar(
    leading: IconButton(
      onPressed: route1,
      icon: Icon(
        icon1,
        color: Colors.black54,
      ),
    ),
    title: Text(
      title!,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    ),
    backgroundColor: Colors.blue[200],
    elevation: 0,
    actions: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: route2,
          child: Icon(icon2, color: Colors.black54),
        ),
      )
    ],
  );
}

void showError(context) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
              icon: const Icon(
                Icons.cancel,
                size: 40.0,
              ),
              color: Colors.blue[200],
              iconSize: 10,
            ),
            const SizedBox(
              width: 25.0,
            ),
            const Flexible(
                child: Text(
              "Barcode not found",
              style: TextStyle(fontSize: 12),
            )),
          ],
        ),
      );
    },
  );
}

void showDialogBox(context) {
  // flutter defined function
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        content: Row(
          children: const <Widget>[
            CircularProgressIndicator(),
            SizedBox(
              width: 25.0,
            ),
            Text("Please wait..."),
          ],
        ),
      );
    },
  );
}

Widget detailCard({
  context,
  String? img,
  String? title,
  String? author,
  String? description,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15.0),
    child: Card(
      color: kBackgroundColor.withOpacity(0.1),
      elevation: 0,
      child: InkWell(
        highlightColor: kPrimaryColor.withOpacity(0.2),
        onTap: () {},
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  height: screenHeight(context) * 0.25,
                  width: screenWidth(context),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: kPrimaryColor),
                      image: DecorationImage(
                        image: AssetImage(img!),
                        fit: BoxFit.fill,
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8, top: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [],
                    ),
                  ),
                ],
              ),
              const YMargin(7),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                    padding: const EdgeInsets.all(0),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            "Title",
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54),
                          ),
                        ),
                        const YMargin(0),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            "$title",
                            style: GoogleFonts.sourceSansPro(
                              fontWeight: FontWeight.w600,
                              color: kTitleColor.withOpacity(0.6),
                              height: 1.7,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.justify,
                            // textDirection: TextDirection.ltr,
                          ),
                        ),
                        const YMargin(15),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            "Autor",
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black54),
                          ),
                        ),
                        const YMargin(0),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            '$author',
                            style: GoogleFonts.sourceSansPro(
                              fontWeight: FontWeight.w600,
                              color: kTitleColor.withOpacity(0.6),
                              height: 1.7,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.justify,
                            // textDirection: TextDirection.ltr,
                          ),
                        ),
                        const YMargin(15),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            "Description",
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.black45),
                          ),
                        ),
                        const YMargin(0),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "$description",
                              style: GoogleFonts.sourceSansPro(
                                fontWeight: FontWeight.w600,
                                color: kTitleColor.withOpacity(0.6),
                                height: 1.7,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.justify,
                              // textDirection: TextDirection.ltr,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class XMargin extends StatelessWidget {
  final double x;
  const XMargin(this.x);
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: x);
  }
}

class YMargin extends StatelessWidget {
  final double y;
  const YMargin(this.y);
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: y);
  }
}

//SCREEN SIZE
double screenHeight(BuildContext context, {double percent = 1}) =>
    MediaQuery.of(context).size.height * percent;

double screenWidth(BuildContext context, {double percent = 1}) =>
    MediaQuery.of(context).size.width * percent;

const kTitleColor = Color(0xFF23374D);
const kTextColor = Color(0XFF1E2432);
const kMediumTextColor = Color(0XFF53627C);
const kLightColor = Color(0XFFACB1C0);
const kPrimaryColor = Color(0xff008080);
const kFormFillColor = Color(0XFFfdfff5);
const kPrimaryColor2 = Color(0xff123318);
const kBackgroundColor = Color(0xFFEbf5f0);

// Style for subTitle
var mSubTitleStyle =
    GoogleFonts.inter(color: kTitleColor.withOpacity(0.6), fontSize: 12);

Widget productCategory({
  context,
  String? img,
  String? title,
}) {
  return Padding(
    padding: const EdgeInsets.only(right: 10.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Stack(
        children: <Widget>[
          Image.asset(
            img!,
            fit: BoxFit.fill,
            height: screenHeight(context) / 6,
            width: screenWidth(context) * 0.6,
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                // Add one stop for each color. Stops should increase from 0 to 1
                stops: [0.2, 0.7],
                colors: [
                  Color.fromARGB(100, 0, 0, 0),
                  Color.fromARGB(100, 0, 0, 0),
                ],
                // stops: [0.0, 0.1],
              ),
            ),
            height: screenHeight(context) / 6,
            width: screenWidth(context) * 0.6,
          ),
          Center(
            child: Container(
              width: screenWidth(context) * .6,
              padding: const EdgeInsets.all(1),
              child: Center(
                child: Text(
                  title!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
