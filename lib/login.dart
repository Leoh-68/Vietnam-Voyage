import 'package:flutter/painting.dart';
import 'package:template/Api/api.dart';
import 'package:template/error.dart';
import 'package:template/loading.dart';
import 'package:flutter/material.dart';
import 'package:template/register.dart';
import 'package:template/taikhoan.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  late TextEditingController _username;
  late TextEditingController _pass;
  bool isLoading = false;
  List<TaiKhoan> TK = [];
  late TaiKhoan taiKhoan;
  @override
  void initState() {
    super.initState();
    _username = TextEditingController(text: "admin");
    _pass = TextEditingController(text: "admin");
    api_lay_ds_tai_khoan().then((value) {
      setState(() {
        TK = value;
      });
    });
  }

  bool LoginCheck(String username, String password) {
    bool check = false;
    for (TaiKhoan taiK in TK) {
      if (taiK.username!.contains(username) && taiK.password!.contains(password)) {
        check = true;
        taiKhoan = taiK;
      }
    }
    return check;
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
      debugShowCheckedModeBanner: false,
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
                            image: DecorationImage(fit: BoxFit.cover, image: AssetImage("images/VV_icon.png")),
                            border: Border.all(color: Colors.white, width: 10),
                            borderRadius: BorderRadius.all(Radius.circular(250)),
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
                          obscureText: true,
                          controller: _pass,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelText: 'Mật khẩu',
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Register()));
                            },
                            child: Align(
                              child: Text(
                                "Đăng ký",
                                style: TextStyle(color: Colors.black),
                              ),
                              alignment: Alignment.topLeft,
                            ))
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
                                  if (isLoading) {
                                    return;
                                  }
                                  if (_username.text.isEmpty || _pass.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Vui lòng nhập Username và Password")));
                                    return;
                                  }
                                  if (LoginCheck(_username.text, _pass.text)) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        PageRouteBuilder(pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
                                          return LoadingScreen(
                                            taiKhoan: taiKhoan,
                                            username: _username.text,
                                            password: _pass.text,
                                          );
                                        }, transitionsBuilder:
                                            (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                                          return SlideTransition(
                                            position: Tween<Offset>(
                                              begin: const Offset(1.0, 0.0),
                                              end: Offset.zero,
                                            ).animate(animation),
                                            child: child,
                                          );
                                        }),
                                        (Route route) => false);
                                  }
                                  setState(() {});
                                },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.black)),
                                child: const Text(
                                  "Sign in",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                              )),
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
// if (_username == "1") {
//                                     Navigator.pushAndRemoveUntil(
//                                         context,
//                                         PageRouteBuilder(pageBuilder:
//                                             (BuildContext context,
//                                                 Animation animation,
//                                                 Animation secondaryAnimation) {
//                                           return const LoadingScreen();
//                                         }, transitionsBuilder:
//                                             (BuildContext context,
//                                                 Animation<double> animation,
//                                                 Animation<double>
//                                                     secondaryAnimation,
//                                                 Widget child) {
//                                           return SlideTransition(
//                                             position: Tween<Offset>(
//                                               begin: const Offset(1.0, 0.0),
//                                               end: Offset.zero,
//                                             ).animate(animation),
//                                             child: child,
//                                           );
//                                         }),
//                                         (Route route) => false);
//                                     _username.clear();
//                                   } else {
//                                     Navigator.push(
//                                       context,
//                                       PageRouteBuilder(
//                                         pageBuilder: (BuildContext context,
//                                             Animation animation,
//                                             Animation secondaryAnimation) {
//                                           return const ErrorPage();
//                                         },
//                                         transitionsBuilder:
//                                             (BuildContext context,
//                                                 Animation<double> animation,
//                                                 Animation<double>
//                                                     secondaryAnimation,
//                                                 Widget child) {
//                                           return SlideTransition(
//                                             position: Tween<Offset>(
//                                               begin: const Offset(1.0, 0.0),
//                                               end: Offset.zero,
//                                             ).animate(animation),
//                                             child: child,
//                                           );
//                                         },
//                                       ),
//                                     );
//                                   }