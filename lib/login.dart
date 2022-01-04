import 'package:template/error.dart';
import 'package:template/loading.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  late TextEditingController _username;
  late TextEditingController _pass;
  @override
  void initState() {
    super.initState();
    _username = TextEditingController();
    _pass = TextEditingController();
  }

  @override
  void dispose() {
    _username.dispose();
    _pass.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(154, 175, 65, 1),
        body: Stack(
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("images/VV_icon.png")),
                            border: Border.all(color: Colors.white, width: 10),
                            borderRadius:
                                BorderRadius.all(Radius.circular(250)),
                          ),
                          height: 250,
                          width: 250,
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 50)),
                        TextField(
                            controller: _username,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                labelText: 'Tên đăng nhập',
                                labelStyle: TextStyle(color: Colors.black))),
                        const Padding(padding: EdgeInsets.only(bottom: 10)),
                        TextField(
                          controller: _pass,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelText: 'Mật khẩu',
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: SizedBox(
                            height: 50,
                            child: TextButton(
                              onPressed: () {
                                setState(() {});
                                if (_username.text == "a" &&
                                    _pass.text == "a") {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      PageRouteBuilder(pageBuilder:
                                          (BuildContext context,
                                              Animation animation,
                                              Animation secondaryAnimation) {
                                        return const LoadingScreen();
                                      }, transitionsBuilder: (BuildContext
                                              context,
                                          Animation<double> animation,
                                          Animation<double> secondaryAnimation,
                                          Widget child) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(1.0, 0.0),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: child,
                                        );
                                      }),
                                      (Route route) => false);
                                } else {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (BuildContext context,
                                          Animation animation,
                                          Animation secondaryAnimation) {
                                        return const ErrorPage();
                                      },
                                      transitionsBuilder: (BuildContext context,
                                          Animation<double> animation,
                                          Animation<double> secondaryAnimation,
                                          Widget child) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(1.0, 0.0),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: child,
                                        );
                                      },
                                    ),
                                  );
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) => Colors.black)),
                              child: const Text(
                                "Sign in",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
