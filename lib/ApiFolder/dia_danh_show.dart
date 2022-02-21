import 'package:template/ApiFolder/list_luu_tru.dart';
import 'package:template/ApiFolder/post_share_detail.dart';
import 'package:template/Model/luu_tru.dart';
import 'package:template/Model/vi_tri.dart';
import 'package:template/login.dart';
import 'package:template/profile.dart';
import 'package:flutter/material.dart';
import 'package:template/ApiFolder/dia_danh_share.dart';
import 'package:template/Api/api.dart';
import 'package:template/taikhoan.dart';
import 'package:map_launcher/map_launcher.dart';

class Detail extends StatefulWidget {
  final String name;
  final String location;
  final String image;
  final String id;
  final String mota;
  final String username;
  final TaiKhoan account;
  final String password;
  const Detail(
      {Key? key,
      required this.account,
      required this.name,
      required this.mota,
      required this.id,
      required this.location,
      required this.image,
      required this.username,
      required this.password})
      : super(key: key);
  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool typing = false;
  TaiKhoan user1 = TaiKhoan();
  ViTri vitri = ViTri();
  @override
  void initState() {
    super.initState();
    api_GetLocation(widget.id).then((value) {
      setState(() {
        vitri = value;
      });
    });
    api_lay_tai_khoan(widget.username, widget.password).then((value1) {
      setState(() {
        user1 = value1;
      });
    });
  }

  void GGMap(String kinhdo, String vido, String title) async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
      coords: Coords(double.parse(kinhdo), double.parse(vido)),
      title: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    var dvsize = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(154, 175, 65, 1),
          title: (typing
              ? Container(
                  alignment: Alignment.centerLeft,
                  child: Text(""),
                )
              : const Text("Travel App")),
          actions: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
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
                        backgroundImage: NetworkImage('http://10.0.2.2:8001/images/' + user1.image.toString()),
                      ),
                      Text(
                        user1.hoTen.toString(),
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
                          return const LoginPage();
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
        body: ListView(children: [
          Stack(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage('http://10.0.2.2:8001/images/' + widget.image), fit: BoxFit.cover),
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
                    boxShadow: [BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 6)]),
              ),
              Positioned(
                  left: 20,
                  bottom: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
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
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              widget.location,
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 50,
                width: ((dvsize.width - 18) / 100) * 25,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.blue),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LuuTruList(
                                  username: widget.username,
                                  password: widget.password,
                                  id: widget.id,
                                )));
                  },
                  icon: const Icon(Icons.list),
                ),
              ),
              Container(
                height: 50,
                width: ((dvsize.width - 18) / 100) * 25,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.blue),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PostDetail(
                                  idPost: widget.id,
                                  username: widget.username,
                                  password: widget.password,
                                  account: widget.account,
                                )));
                  },
                  icon: const Icon(Icons.list_alt_outlined),
                ),
              ),
              Container(
                height: 50,
                width: ((dvsize.width - 18) / 100) * 25,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.blue),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      GGMap(vitri.kinhDo.toString(), vitri.viDo.toString(), widget.name);
                    });
                  },
                  icon: const Icon(Icons.map),
                ),
              ),
              Container(
                height: 50,
                width: ((dvsize.width - 18) / 100) * 25,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.blue),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Sharea(
                                  username: widget.username,
                                  password: widget.password,
                                  id: widget.id,
                                  idaccount: user1.id.toString(),
                                )));
                  },
                  icon: const Icon(Icons.share),
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Text(
              'Giới thiệu',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                widget.mota,
                style: TextStyle(fontSize: 20),
              ))
        ]));
  }
}
