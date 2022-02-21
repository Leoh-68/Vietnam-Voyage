import 'dart:async';

import 'package:template/Api/api.dart';
import 'package:template/Model/luot_share.dart';
import 'package:template/Model/sharecotk.dart';
import 'package:template/api.dart';
import 'package:template/login.dart';
import 'package:template/profile.dart';
import 'package:flutter/material.dart';
import 'package:template/Model/share.dart';
import 'package:template/profileclick.dart';
import 'package:template/taikhoan.dart';

class PostShareDetail extends StatefulWidget {
  final String username;
  final String password;
  final TaiKhoan account;
  final ShareCoAccount share;

  const PostShareDetail({Key? key, required this.share, required this.username, required this.password, required this.account}) : super(key: key);
  @override
  State<PostShareDetail> createState() => _PostState();
}

class _PostState extends State<PostShareDetail> {
  LuotShare ls = new LuotShare();
  String aaa = "";
  int countter = 2;
  bool typing = false;
  String text = "";
  String location = "3";
  late String like;
  late String view;
  String unlike = "0";
  Color likecolor = Colors.black;
  Color unlikecolor = Colors.black;

  @override
  void initState() {
    super.initState();
    // api_lay_tai_khoan(widget.username, widget.password).then((value) {
    //   setState(() {
    //     user1 = value;
    //   });
    // });
  }

  String buildString(String word) {
    final arr = word.split('');
    String a = "";
    if (arr.length > 100) {
      for (int i = 0; i < 100; i++) {
        a = a + "" + arr[i];
      }
      return a;
    } else {
      return arr.join("");
    }
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var dvsize = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(backgroundColor: const Color.fromRGBO(154, 175, 65, 1), title: const Text("Bài đăng"), actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ]),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 95,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Color.fromRGBO(154, 175, 65, 1)),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage('http://10.0.2.2:8001/images/' + widget.account.image.toString()),
                      ),
                      Text(
                        widget.account.hoTen.toString(),
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: const Text('Thông tin người dùng'),
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
                        return Profile(username: widget.username, password: widget.password);
                      },
                      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
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
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Đăng xuất'),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
                          return LoginPage();
                        },
                        transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        },
                      ),
                      (Route route) => false);
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              ListTile(
                  title: Text(widget.share.tk!.hoTen.toString(), style: TextStyle(fontSize: 20)),
                  subtitle: Text(
                    DateTime.parse(widget.share.created.toString()).toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  leading: SizedBox(
                    height: 50,
                    width: 50,
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
                                return ProfileClick(
                                  username: widget.username,
                                  password: widget.password,
                                  idAccount: widget.share.tk!.id.toString(),
                                );
                              },
                              transitionsBuilder:
                                  (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
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
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage('http://10.0.2.2:8001/images/' + widget.share.tk!.image.toString()),
                        )),
                  )),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    buildString(widget.share.baiViet.toString()),
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              widget.share.image != ""
                  ? Padding(
                      padding: EdgeInsets.all(10),
                      child: SizedBox(
                        height: 350,
                        child: Image(image: NetworkImage('http://10.0.2.2:8001/images/' + widget.share.image.toString())),
                      ),
                    )
                  : Container(),
              FutureBuilder<String>(
                  future: api_countlike(widget.share.diaDanhId.toString(), widget.share.id.toString()),
                  builder: (contex, snapshot3) {
                    snapshot3.data == null ? Text("Loading........") : aaa = snapshot3.data!;
                    return Row(
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  if (widget.share.isFavor.toString() == "co") {
                                    api_reLike(widget.share.id.toString(), widget.account.id.toString()).then((value) {
                                      setState(() {});
                                    });
                                  } else {
                                    api_Like(widget.share.id.toString(), widget.account.id.toString()).then((value) {
                                      setState(() {});
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.favorite,
                                  color: widget.share.isFavor.toString() == "co" ? Colors.red : Colors.black,
                                )),
                            aaa != null ? Text(aaa) : CircularProgressIndicator()
                          ],
                        ),
                        Container(
                          child: Row(
                            children: [const Icon(Icons.remove_red_eye), Text(widget.share.view.toString())],
                          ),
                          alignment: Alignment.topRight,
                        )
                      ],
                    );
                  })
            ],
          ),
        ));
  }
}
