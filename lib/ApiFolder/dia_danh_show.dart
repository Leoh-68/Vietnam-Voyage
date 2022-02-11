import 'package:template/login.dart';
import 'package:template/profile.dart';
import 'package:flutter/material.dart';
import 'package:template/ApiFolder/dia_danh_share.dart';

class Detail extends StatelessWidget {
  final String name;
  final String location;
  final String image;
  final String id;
  final String mota;
  Detail({Key? key, required this.mota, required this.name, required this.id, required this.location, required this.image}) : super(key: key);
  bool typing = false;

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
                        "   Trần Phước Khánh",
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
                        return const Profile();
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
                    image: DecorationImage(image: AssetImage('images/' + image), fit: BoxFit.cover),
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
                        name,
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
                              location,
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
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.grey),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.thumb_up),
                ),
              ),
              Container(
                height: 50,
                width: ((dvsize.width - 18) / 100) * 25,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.grey),
                child: IconButton(
                  onPressed: () {
                    //  Navigator.push(context, MaterialPageRoute(builder: (context) => Search(name: _controller.text)));
                  },
                  icon: const Icon(Icons.thumb_down),
                ),
              ),
              Container(
                height: 50,
                width: ((dvsize.width - 18) / 100) * 25,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.grey),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.map),
                ),
              ),
              Container(
                height: 50,
                width: ((dvsize.width - 18) / 100) * 25,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.grey),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Sharea(
                                  id: id,
                                  idaccount: "1",
                                )));
                  },
                  icon: const Icon(Icons.share),
                ),
              )
            ],
          ),
          Container(
              padding: EdgeInsets.all(10),
              child: Text(
                mota,
                style: TextStyle(fontSize: 20),
              ))
        ]));
  }
}
