// ignore: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';

import 'package:template/Api/api.dart';
import 'package:template/Model/luot_share.dart';
// import 'package:template/Model/taikhoan.dart';
import 'package:template/taikhoan.dart';
import 'package:template/Model/taikhoancoshare.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'dart:ffi';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';

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

class ProfileClick extends StatefulWidget {
  final String username;
  final String password;
  final String idAccount;
  const ProfileClick({Key? key, required this.password, required this.username, required this.idAccount}) : super(key: key);
  @override
  State<ProfileClick> createState() => _ProfileClickState();
}

class _ProfileClickState extends State<ProfileClick> {
  bool liked = false;
  bool unliked = false;
  Color likecolor = Colors.black;
  Color unlikecolor = Colors.black;
  TaiKhoan user1 = TaiKhoan();
  TaiKhoan userlog = TaiKhoan();
  TaiKhoancoShare userpost = TaiKhoancoShare();
  LuotShare ls = LuotShare();
  String aaa = "";
  File? image;
  @override
  void initState() {
    super.initState();
    api_lay_tai_khoan(widget.username, widget.password).then((value) {
      setState(() {
        userlog = value;
      });
    });
    api_lay_tai_khoan_id(widget.idAccount).then((value1) {
      setState(() {
        user1 = value1;
      });
      api_share_tai_khoan(widget.idAccount.toString()).then((value) {
        setState(() {
          userpost = value;
        });
      });
    });
  }

  upload(File imageFile, String idTk) async {
    // open a bytestream
    var stream = new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse("http://10.0.2.2:8001/api/ThayAnh?id=$idTk");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    // ignore: unnecessary_new
    var multipartFile = new http.MultipartFile('file', stream, length, filename: basename(imageFile.path));
    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  Future getImagefromGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Fail: $e');
    }
  }

  Widget test() {
    return userpost.share != null
        ? SizedBox(
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
                                  leading: SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage('http://10.0.2.2:8001/images/' + user1.image.toString()),
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
                              userpost.share![index].image != ""
                                  ? Padding(
                                      padding: EdgeInsets.all(10),
                                      child: SizedBox(
                                        child: Image(image: NetworkImage('http://10.0.2.2:8001/images/' + userpost.share![index].image.toString())),
                                      ),
                                    )
                                  : Container(),
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
                                                  if (userpost.share![index].isFavor.toString() == "co") {
                                                    api_reLike(userpost.share![index].id.toString(), userlog.id.toString()).then((value) {
                                                      setState(() {});
                                                    });
                                                  } else {
                                                    api_Like(userpost.share![index].id.toString(), userlog.id.toString()).then((value) {
                                                      setState(() {});
                                                    });
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.favorite,
                                                  color: userpost.share![index].isFavor.toString() == "co" ? Colors.red : Colors.black,
                                                )),
                                            aaa != null ? Text(aaa) : CircularProgressIndicator()
                                          ],
                                        ),
                                        Container(
                                          child: Row(
                                            children: [const Icon(Icons.remove_red_eye), Text(userpost.share![index].view.toString())],
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
        : Container(
            padding: EdgeInsets.only(top: 20),
            child: const Center(
                child: Text(
              "Tài khoản này chưa có bài viết",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )));
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
                                  child: TextButton(
                                onPressed: () {},
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 110,
                                  child: CircleAvatar(
                                    radius: 100,
                                    backgroundImage: NetworkImage('http://10.0.2.2:8001/images/' + user1.image.toString()),
                                  ),
                                ),
                              )),
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
            : const Center(),
      ),
    );
  }
}
