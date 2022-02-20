import 'dart:async';

import 'package:template/Api/api.dart';
import 'package:template/Model/dia_danh.dart';
import 'package:template/Model/diadanh_homepage.dart';
import 'package:template/login.dart';
import 'package:template/profile.dart';
import 'package:template/taikhoan.dart';
import 'package:flutter/material.dart';
import 'package:template/ApiFolder/dia_danh_show.dart';

class DiaDanhTheoNhuCau extends StatefulWidget {
  final String username;
  final String password;
  final TaiKhoan account;
  final String nhucau;
  const DiaDanhTheoNhuCau({Key? key, required this.nhucau, required this.account, required this.username, required this.password}) : super(key: key);

  @override
  State<DiaDanhTheoNhuCau> createState() => _SearchState();
}

class _SearchState extends State<DiaDanhTheoNhuCau> {
  int countter = 2;
  bool typing = false;
  String text = "";
  String location = "3";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {});
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

  @override
  Widget build(BuildContext context) {
    var dvsize = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(backgroundColor: const Color.fromRGBO(154, 175, 65, 1), title: Text("Tìm kiếm "), actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
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
                        backgroundImage: AssetImage("images/2.jpg"),
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
                leading: Icon(Icons.logout),
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
        body: ListView(
          children: [
            Center(
                child: Text(
              "Những địa điểm " + widget.nhucau,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            )),
            FutureBuilder<List<DiaDanhHome>>(
                future: api_GetAll_DiaDanh_TheoNhuCau(widget.nhucau),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                  }
                  return snapshot.hasData
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (contex, index) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            TextButton(
                                              child: Container(
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                                                  height: 200,
                                                  width: dvsize.width - 32,
                                                  child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(10),
                                                      child: Image.network('http://10.0.2.2:8001/images/' + snapshot.data![index].hinhAnh!,
                                                          fit: BoxFit.cover))),
                                              onPressed: () {},
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.only(bottom: 10, left: 10),
                                        child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                buildString(snapshot.data![index].tenDiaDanh!.toString()),
                                                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                              ),
                                              Text(buildString(snapshot.data![index].viTri!),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                ),
                                                Padding(padding: EdgeInsets.all(10)),
                                                Text(snapshot.data![index].like.toString(),
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                                                const Icon(
                                                  Icons.remove_red_eye,
                                                  color: Colors.green,
                                                ),
                                                Padding(padding: EdgeInsets.all(10)),
                                                Text(snapshot.data![index].share.toString(),
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (contex) => Detail(
                                                account: widget.account,
                                                username: widget.username,
                                                password: widget.password,
                                                mota: snapshot.data![index].moTa.toString(),
                                                id: snapshot.data![index].id.toString(),
                                                name: snapshot.data![index].tenDiaDanh.toString(),
                                                location: snapshot.data![index].viTri!,
                                                image: snapshot.data![index].hinhAnh!))).then(onGoBack);
                                  },
                                )
                              ],
                            );
                          })
                      : const Center(child: Padding(padding: EdgeInsets.only(top: 250), child: CircularProgressIndicator()));
                }),
          ],
        ));
  }
}
