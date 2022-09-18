import 'package:flutter/material.dart';
import '/controllers/userCont.dart';
import '/model/userInterest.dart';

class GenreScreen extends StatefulWidget {
  final UserInterest userInterest;
  GenreScreen({required this.userInterest});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  Future<UserInterest>? userinterest;
  UserCont userCont = UserCont();

  @override
  Widget build(BuildContext context) {
    var data = widget.userInterest.interest
        .substring(1, widget.userInterest.interest.length - 1);
    var interest = data.split(',');

    return Scaffold(
      backgroundColor: const Color(0xffdee2fe),
      body: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Interests",
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 24,
                        right: 24,
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var elem in interest)
                                listProfile(Icons.interests, elem),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

/*
  Widget Profile(UserInterest userInterest) {
 
            var data = userinterest.interest;
            var interest = data.split(',');
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for( var elem in interest) listProfile(Icons.interests, elem),
              ],
            );
          
        
  }
*/
  Widget listProfile(IconData icon, String text2) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
          ),
          const SizedBox(
            width: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text2,
                style: const TextStyle(
                  color: Colors.black87,
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
