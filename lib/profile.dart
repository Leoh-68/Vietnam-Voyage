import 'package:flutter/material.dart';
import 'package:template/Api/api.dart';
// import 'package:template/Model/taikhoan.dart';
import 'package:template/taikhoan.dart';
import 'package:template/Model/taikhoancoshare.dart';

class User {
  final String backGroundImage;
  final String imagePath;
  final String name;
  final String email;
  final String about;
  const User({required this.backGroundImage, required this.imagePath, required this.name, required this.email, required this.about});
}

class UserPreferences {
  static const khanh =
      User(backGroundImage: "images/1.jpg", imagePath: "images/2.jpg", name: "Trần Phước Khánh", email: "kamdmjjj@gmail.com", about: "Thích ở nhà");
}

class Profile extends StatefulWidget {
  final String username;
  final String password;

  const Profile({Key? key, required this.password, required this.username}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool liked = false;
  bool unliked = false;
  Color likecolor = Colors.black;
  Color unlikecolor = Colors.black;
  TaiKhoan user1 = TaiKhoan();
  TaiKhoancoShare userpost = TaiKhoancoShare();
  @override
  void initState() {
    super.initState();
    api_lay_tai_khoan(widget.username, widget.password).then((value) {
      setState(() {
        user1 = value;
      });
      api_share_tai_khoan(user1.id.toString()).then((value) {
        setState(() {
          userpost = value;
        });
      });
    });
  }

  Widget test() {
    return userpost.share != null
        ? Container(
            height: 500,
            child: ListView.builder(
                itemCount: userpost.share!.length,
                itemBuilder: (contex, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Column(
                      children: [
                        ListTile(
                            title: Text(userpost.hoTen!.toString(), style: TextStyle(fontSize: 20)),
                            subtitle: Text(
                              userpost.share![0].created.toString(),
                              style: TextStyle(fontSize: 16),
                            ),
                            leading: const SizedBox(
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
                              userpost.share![index].baiViet.toString(),
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
                                            // api_Like(snapshot.data![index].id.toString()).then((value) => {like = value});
                                            liked = true;
                                            likecolor = Colors.red;
                                          });
                                        } else {
                                          setState(() {
                                            // api_reLike(snapshot.data![index].id.toString()).then((value) => {like = value});
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
                                Text(userpost.share![index].liked.toString())
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      if (liked == false) {
                                        if (unliked == false) {
                                          setState(() {
                                            // api_UnLike(snapshot.data![index].id.toString()).then((value) => {unlike = value});
                                            unliked = true;
                                            unlikecolor = Colors.red;
                                          });
                                        } else {
                                          setState(() {
                                            // api_reUnLike(snapshot.data![index].id.toString()).then((value) => {
                                            //       unlike = value,
                                            //     });
                                            unliked = false;
                                            unlikecolor = Colors.black;
                                          });
                                        }
                                      } else {
                                        null;
                                      }
                                    },
                                    icon: Icon(Icons.thumb_down_alt, color: unlikecolor)),
                                Text(userpost.share![0].unliked.toString())
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
                  );
                }),
          )
        : CircularProgressIndicator();
  }

  Widget post() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          ListTile(
              title: Text(userpost.hoTen!.toString(), style: TextStyle(fontSize: 20)),
              subtitle: Text(
                userpost.share![0].created.toString(),
                style: TextStyle(fontSize: 16),
              ),
              leading: const SizedBox(
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
                userpost.share![0].baiViet.toString(),
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
                              // api_Like(snapshot.data![index].id.toString()).then((value) => {like = value});
                              liked = true;
                              likecolor = Colors.red;
                            });
                          } else {
                            setState(() {
                              // api_reLike(snapshot.data![index].id.toString()).then((value) => {like = value});
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
                  Text("số like")
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        if (liked == false) {
                          if (unliked == false) {
                            setState(() {
                              // api_UnLike(snapshot.data![index].id.toString()).then((value) => {unlike = value});
                              unliked = true;
                              unlikecolor = Colors.red;
                            });
                          } else {
                            setState(() {
                              // api_reUnLike(snapshot.data![index].id.toString()).then((value) => {
                              //       unlike = value,
                              //     });
                              unliked = false;
                              unlikecolor = Colors.black;
                            });
                          }
                        } else {
                          null;
                        }
                      },
                      icon: Icon(Icons.thumb_down_alt, color: unlikecolor)),
                  Text("Số unliked")
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
    );
  }

  @override
  Widget build(BuildContext context) {
    const user = UserPreferences.khanh;
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
            backgroundColor: const Color.fromRGBO(154, 175, 65, 1),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back))),
        body: user1.hoTen != null
            ? ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                              child: Image.asset(
                                user.backGroundImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 150),
                              child: Center(
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 110,
                                  child: CircleAvatar(
                                    radius: 100,
                                    backgroundImage: AssetImage(user.imagePath),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Text(
                          user1.hoTen.toString(),
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        Container(
                          decoration: const BoxDecoration(color: Colors.white),
                          width: double.maxFinite,
                          child: Column(
                            children: [Text("Email: " + user1.email.toString()), Text("Sở thích: " + user.about)],
                          ),
                        )
                      ],
                    ),
                  ),
                  test()
                ],
              )
            : const Center(
                child: Center(child: CircularProgressIndicator()),
              ),
      ),
    );
  }
}
