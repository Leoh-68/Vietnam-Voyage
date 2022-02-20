import 'dart:async';

import 'package:template/ApiFolder/dia_danh_theo_nhu_cau.dart';
import 'package:template/taikhoan.dart';
import 'package:image_network/image_network.dart';
import 'Model/diadanh_homepage.dart';
import 'login.dart';
import 'profile.dart';
import 'Model/dia_danh.dart';
import 'Api/api.dart';
import 'ApiFolder/post_share.dart';
import 'package:flutter/material.dart';
import 'ApiFolder/dia_danh_show.dart';
import 'dia_danh_search.dart';

class MyHomePage extends StatefulWidget {
  final String username;
  final String password;
  final TaiKhoan taiKhoan;
  const MyHomePage({Key? key, required this.username, required this.password, required this.taiKhoan}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<DiaDanh> top5 = [];
  int _counter = 1;
  int countter = 2;
  int a = 0;
  bool typing = false;
  String text = "";
  String findchoose = 'Tên địa danh';
  String hint = 'Tìm kiếm';
  String location = "3";
  late TextEditingController _controller;
  TaiKhoan account = new TaiKhoan();
  @override
  void initState() {
    super.initState();
    setState(() {
      // api_lay_tai_khoan(widget.username, widget.password).then((value1) {
      //   account = value1;
      // });
      api_Get5_DiaDanh().then((value) {
        top5 = value;
      });
    });
    _controller = TextEditingController();
  }

  FutureOr onGoBack(dynamic value) {
    a++;
    setState(() {});
  }

  String buildString(String word) {
    final arr = word.split('');
    String a = "";
    if (arr.length > 15) {
      for (int i = 0; i < 15; i++) {
        a = a + "" + arr[i];
      }
      return a;
    } else {
      return arr.join("");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var dvsize = MediaQuery.of(context).size;
    Widget allDiaDanh() {
      return Expanded(
          child: FutureBuilder<List<DiaDanhHome>>(
              future: api_GetAll_DiaDanh(),
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
                                              account: widget.taiKhoan,
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
              }));
    }

    Widget hotDiaDanh() {
      return FutureBuilder<DiaDanh>(
          future: api_Hot_DiaDanh(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Stack(
                    children: [
                      TextButton(
                          onPressed: () {
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contex) => Detail(
                                          account: widget.taiKhoan,
                                          username: widget.username,
                                          password: widget.password,
                                          mota: snapshot.data!.moTa.toString(),
                                          id: snapshot.data!.id.toString(),
                                          name: snapshot.data!.tenDiaDanh.toString(),
                                          location: snapshot.data!.viTri!,
                                          image: snapshot.data!.hinhAnh!))).then(onGoBack);
                            }
                          },
                          child: Container(
                            height: 300,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                image:
                                    DecorationImage(image: NetworkImage('http://10.0.2.2:8001/images/' + snapshot.data!.hinhAnh!), fit: BoxFit.cover),
                                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                                boxShadow: const [BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 6)]),
                          )),
                      Positioned(
                          left: 20,
                          bottom: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.tenDiaDanh.toString(),
                                style: const TextStyle(letterSpacing: 1.5, color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.location_city,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(
                                      snapshot.data!.viTri.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                    ],
                  )
                : const CircularProgressIndicator();
          });
    }

    _counter++;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(154, 175, 65, 1),
          title: (typing
              ? Container(
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: _controller,
                    decoration: InputDecoration(border: InputBorder.none, hintText: hint, hintStyle: TextStyle(color: Colors.white)),
                    onChanged: (String value) {
                      setState(
                        () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>Search(dd: snapshot2.data!)));
                        },
                      );
                    },
                  ),
                )
              : const Text("Bạn muốn đi đâu ?")),
          actions: [
            typing
                ? DropdownButton<String>(
                    items: <String>['Tên địa danh', 'Vùng miền'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: findchoose = value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (findchoose) {
                      setState(() {
                        hint = findchoose!;
                      });
                    },
                  )
                : Container(),
            IconButton(
              icon: Icon(typing ? Icons.done : Icons.search),
              onPressed: () {
                setState(() {
                  if (typing == true) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Search(
                                account: widget.taiKhoan,
                                username: widget.username,
                                password: widget.password,
                                name: _controller.text,
                                mode: findchoose))).then(onGoBack);
                  }
                  typing = !typing;
                });
              },
            )
          ],
        ),
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
                        backgroundImage: NetworkImage('http://10.0.2.2:8001/images/' + account.image.toString()),
                      ),
                      Text(
                        widget.taiKhoan.hoTen.toString(),
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
                        return Profile(
                          username: widget.username,
                          password: widget.password,
                        );
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
            hotDiaDanh(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  width: ((dvsize.width - 18) / 100) * 25,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color.fromRGBO(191, 255, 252, 1)),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.home),
                  ),
                ),
                Container(
                  height: 50,
                  width: ((dvsize.width - 18) / 100) * 25,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color.fromRGBO(240, 227, 255, 1)),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DiaDanhTheoNhuCau(
                                  nhucau: "Phượt", account: widget.taiKhoan, username: widget.username, password: widget.password))).then(onGoBack);
                    },
                    icon: Image.asset('images/mountain.png'),
                  ),
                ),
                Container(
                  height: 50,
                  width: ((dvsize.width - 18) / 100) * 25,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color.fromRGBO(255, 255, 255, 1)),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DiaDanhTheoNhuCau(
                                  nhucau: "Nghĩ dưỡng",
                                  account: widget.taiKhoan,
                                  username: widget.username,
                                  password: widget.password))).then(onGoBack);
                    },
                    icon: Image.asset('images/sea.png'),
                  ),
                ),
                Container(
                  height: 50,
                  width: ((dvsize.width - 18) / 100) * 25,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color.fromRGBO(191, 255, 252, 1)),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Post(account: widget.taiKhoan, username: widget.username, password: widget.password)))
                          .then(onGoBack);
                    },
                    icon: Icon(Icons.content_paste_outlined),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Top thịnh hành",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
            ),
            FutureBuilder<List<DiaDanh>>(
                future: api_Get5_DiaDanh(),
                builder: (context, snapshot5) {
                  return snapshot5.hasData
                      ? Container(
                          height: 145,
                          child: Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot5.data!.length,
                                  itemBuilder: (BuildContext contex, int index) {
                                    _counter++;
                                    return SizedBox(
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (contex) => Detail(
                                                        account: widget.taiKhoan,
                                                        username: widget.username,
                                                        password: widget.password,
                                                        mota: snapshot5.data![index].moTa.toString(),
                                                        id: snapshot5.data![index].id.toString(),
                                                        name: snapshot5.data![index].tenDiaDanh.toString(),
                                                        location: snapshot5.data![index].viTri!,
                                                        image: snapshot5.data![index].hinhAnh!))).then(onGoBack);
                                          },
                                          child: SizedBox(
                                            height: 200,
                                            child: Padding(
                                                padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
                                                child: Column(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Container(
                                                          height: 80,
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                                                                  height: 100,
                                                                  width: 100,
                                                                  child: ClipRRect(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      child: Image.network(
                                                                          'http://10.0.2.2:8001/images/' + snapshot5.data![index].hinhAnh!,
                                                                          fit: BoxFit.cover))),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      child: Column(
                                                        children: [
                                                          Text(buildString(snapshot5.data![index].tenDiaDanh!)),
                                                          Text(buildString(snapshot5.data![index].moTa!))
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          )),
                                    );
                                  })),
                        )
                      : CircularProgressIndicator();
                }),
            allDiaDanh()
          ],
        ));
  }
}
