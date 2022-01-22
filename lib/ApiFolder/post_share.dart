import 'package:template/Api/api.dart';
import 'package:template/login.dart';
import 'package:template/profile.dart';
import 'package:flutter/material.dart';
import 'package:template/Model/share.dart';
class Post extends StatefulWidget {
  const Post({
    Key? key,
  }) : super(key: key);
  @override
  State<Post> createState() => _PostState();
}
class _PostState extends State<Post> {
  int countter = 2;
  bool typing = false;
  String text = "";
  String location = "3";
  String like = "0";
  String unlike = "0";
  bool liked = false;
  bool unliked = false;
  Color likecolor = Colors.black;
  Color unlikecolor = Colors.black;
  @override
  Widget build(BuildContext context) {
    var dvsize = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(backgroundColor: const Color.fromRGBO(154, 175, 65, 1), title: const Text("Bài đăng"), actions: [
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
                    children: const [
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
        body: FutureBuilder<List<Share>>(
            future: api_GetShareHome(),
            builder: (contex, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, int index) {
                        like = snapshot.data![index].liked.toString();
                        unlike = snapshot.data![index].unliked.toString();
                        return snapshot.hasData
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Column(
                                  children: [
                                    const ListTile(
                                        title: Text("Trần Phước Khánh", style: TextStyle(fontSize: 20)),
                                        subtitle: Text(
                                          "11/11/2001",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        leading: SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: CircleAvatar(
                                            backgroundImage: AssetImage('images/3.jpg'),
                                          ),
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          snapshot.data![index].baiViet.toString(),
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: SizedBox(
                                        child: Image(image: AssetImage('images/1.jpg')),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  if (unliked == false) {
                                                    if (liked == false) {
                                                      setState(() {
                                                        api_Like(snapshot.data![index].id.toString()).then((value) => {like = value});
                                                        liked = true;
                                                        likecolor = Colors.red;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        api_reLike(snapshot.data![index].id.toString()).then((value) => {like = value});
                                                        liked = false;
                                                        likecolor = Colors.black;
                                                      });
                                                    }
                                                  } else {
                                                    null;
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.favorite,
                                                  color: likecolor,
                                                )),
                                            Text(like)
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  if (liked == false) {
                                                    if (unliked == false) {
                                                      setState(() {
                                                        api_UnLike(snapshot.data![index].id.toString()).then((value) => {unlike = value});
                                                        unliked = true;
                                                        unlikecolor = Colors.red;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        api_reUnLike(snapshot.data![index].id.toString()).then((value) => {
                                                              unlike = value,
                                                            });
                                                        unliked = false;
                                                        unlikecolor = Colors.black;
                                                      });
                                                    }
                                                  } else {
                                                    null;
                                                  }
                                                },
                                                icon: Icon(Icons.thumb_down_alt, color: unlikecolor)),
                                            Text(unlike)
                                          ],
                                        ),
                                        Container(
                                          child: Row(
                                            children: const [Icon(Icons.remove_red_eye), Text("100")],
                                          ),
                                          alignment: Alignment.topRight,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            : const CircularProgressIndicator();
                      })
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            }));
  }
}
