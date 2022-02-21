import 'package:template/Model/luu_tru.dart';
import 'package:template/Model/vi_tri.dart';
import 'package:template/login.dart';
import 'package:template/profile.dart';
import 'package:flutter/material.dart';
import 'package:template/ApiFolder/dia_danh_share.dart';
import 'package:template/Api/api.dart';
import 'package:template/taikhoan.dart';
import 'package:map_launcher/map_launcher.dart';

class LuuTruList extends StatefulWidget {
  final String id;
  final String username;
  final String password;

  const LuuTruList({Key? key, required this.id, required this.username, required this.password}) : super(key: key);
  @override
  State<LuuTruList> createState() => _LuuTruListState();
}

class _LuuTruListState extends State<LuuTruList> {
  bool typing = false;
  TaiKhoan user1 = TaiKhoan();
  ViTri vitri = ViTri();
  int lengh = 0;
  List<LuuTru> result = [];
  @override
  void initState() {
    super.initState();
    api_lay_tai_khoan(widget.username, widget.password).then((value) {
      setState(() {
        user1 = value;
      });
    });
    api_get_luutru(widget.id).then((value) {
      setState(() {
        result = value;
        lengh = result.length;
      });
    });
  }

  void GGMap(String kinhdo, String vido) async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
      coords: Coords(double.parse(kinhdo), double.parse(vido)),
      title: "Ocean Beach",
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
                        backgroundImage: AssetImage("images/2.jpg"),
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
        body: ListView(
          children: [
            Column(
              children: [
                Text(
                  "Danh sách nơi lưu trú",
                  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                lengh == 0
                    ? Text(
                        "Data rỗng",
                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: result.length,
                        itemBuilder: (contex, index) {
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.only(bottom: 10, left: 10),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.network(
                                        'http://10.0.2.2:8001/images/rei.jpg',
                                        fit: BoxFit.fill,
                                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress.expectedTotalBytes != null
                                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                                  : null,
                                            ),
                                          );
                                        },
                                      ),
                                      Text(
                                        result[index].tenLuuTru!.toString(),
                                        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                      Text(result[index].sDT!.toString() + ", " + result[index].diaChi!.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                          ))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        }),
              ],
            )
          ],
        ));
  }
}
