import 'package:flutter/material.dart';
import 'package:template/Api/api.dart';
import 'package:template/Model/luot_share.dart';
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
  LuotShare ls = new LuotShare();
  String aaa = "";
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
                  return userpost.share![index].idshare == "0"
                      ? Padding(
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
                              FutureBuilder<String>(
                                  future: api_countlike(userpost.share![index].diaDanhId.toString(), userpost.share![index].id.toString()),
                                  builder: (contex, snapshot3) {
                                    snapshot3.data == null ? Text("Loading........") : aaa = snapshot3.data!;

                                    return Row(
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  late String unlike;
                                                  late String like;
                                                  api_liked(userpost.id.toString(), userpost.share![index].id.toString()).then((value) {
                                                    setState(() {
                                                      like = value;
                                                      if (like == "1") {
                                                        api_reLike(userpost.share![index].id.toString(), userpost.id.toString()).then((value) {
                                                          ls = value;
                                                        });
                                                      } else {
                                                        api_Like(userpost.share![index].id.toString(), userpost.id.toString()).then((value) {
                                                          ls = value;
                                                        });
                                                      }
                                                    });
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.favorite,
                                                  color: likecolor,
                                                )),
                                            aaa != null ? Text(aaa) : CircularProgressIndicator()
                                          ],
                                        ),
                                        Container(
                                          child: Row(
                                            children: [const Icon(Icons.remove_red_eye), Text("25")],
                                          ),
                                          alignment: Alignment.topRight,
                                        )
                                      ],
                                    );
                                  })
                            ],
                          ),
                        )
                      : Container();
                }),
          )
        : CircularProgressIndicator();
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
