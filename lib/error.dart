import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(154, 175, 65, 1),
        body: Stack(
          children: <Widget>[
            Center(
                child: Expanded(
              flex: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 100, 50, 50),
                    child: SizedBox(
                        height: 120,
                        child: Image.asset(
                          "images/error_icon.jpeg",
                          scale: 5,
                        )),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  const Text(
                    "Opps... couldn't Sign In",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 3)),
                  const Text(
                    "Your email and password incorrect.",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 3)),
                  const Text(
                    "Please, try again.",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white70),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 210)),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: SizedBox(
                          height: 50,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                        (states) => Colors.black)),
                            child: const Text(
                              "TRY AGAIN",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      )),
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
