import 'package:flutter/material.dart';

class User {
  final String backGroundImage;
  final String imagePath;
  final String name;
  final String email;
  final String about;
  const User(
      {required this.backGroundImage,
      required this.imagePath,
      required this.name,
      required this.email,
      required this.about});
}

class UserPreferences {
  static const khanh = User(
      backGroundImage: "images/1.jpg",
      imagePath: "images/2.jpg",
      name: "Trần Phước Khánh",
      email: "kamdmjjj@gmail.com",
      about: "Thích ở nhà");
}

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const user = UserPreferences.khanh;
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            backgroundColor: const Color.fromRGBO(154, 175, 65, 1),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back))),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40)),
                        child: Image.asset(
                          user.backGroundImage,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 110,
                            child: CircleAvatar(
                              radius: 100,
                              backgroundImage: AssetImage(user.imagePath),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Text(
                    user.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Container(
                    decoration: const BoxDecoration(color: Colors.white),
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Text("Email: " + user.email),
                        Text("Sở thích: " + user.about)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
