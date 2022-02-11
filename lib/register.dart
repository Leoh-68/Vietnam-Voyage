import 'package:flutter/painting.dart';
import 'package:template/Api/api.dart';
import 'package:template/error.dart';
import 'package:template/loading.dart';
import 'package:flutter/material.dart';
import 'package:template/taikhoan.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<Register> {
  late TextEditingController username;
  late TextEditingController password;
  late TextEditingController password2;
  late TextEditingController hoten;
  late TextEditingController email;
  late TextEditingController sdt;
  String state = "";
  String check = "2";
  String warrning = "";
  bool isLoading = false;
  void initState() {
    super.initState();
    username = TextEditingController();
    password = TextEditingController();
    password2 = TextEditingController();
    hoten = TextEditingController();
    email = TextEditingController();
    sdt = TextEditingController();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    password2.dispose();
    email.dispose();
    hoten.dispose();
    sdt.dispose();
    super.dispose();
  }

  String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length != 10) {
      return 'fail';
    } else if (!regExp.hasMatch(value)) {
      return 'fail';
    }
    return "ok";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(backgroundColor: const Color.fromRGBO(154, 175, 65, 1), title: const Text("Đăng ký")),
        drawer: Drawer(
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          ),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromRGBO(154, 175, 65, 1),
        body: Stack(
          children: <Widget>[
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
                    child: Column(
                      children: [
                        // Container(
                        //   decoration: BoxDecoration(
                        //     image: DecorationImage(fit: BoxFit.cover, image: AssetImage("images/VV_icon.png")),
                        //     border: Border.all(color: Colors.white, width: 5),
                        //     borderRadius: BorderRadius.all(Radius.circular(250)),
                        //   ),
                        //   height: 100,
                        //   width: 100,
                        // ),
                        const Padding(padding: EdgeInsets.only(bottom: 50)),
                        TextField(
                            controller: username,
                            decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                labelText: 'Tên đăng nhập',
                                labelStyle: TextStyle(color: Colors.black))),
                        const Padding(padding: EdgeInsets.only(bottom: 10)),
                        TextField(
                          obscureText: true,
                          controller: password,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelText: 'Mật khẩu',
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 10)),
                        TextField(
                          obscureText: true,
                          controller: password2,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelText: 'Nhập lại mật khẩu',
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 10)),
                        TextField(
                          controller: hoten,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelText: 'Họ tên',
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 10)),
                        TextField(
                          controller: email,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 10)),
                        TextField(
                          controller: sdt,
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              labelText: 'Số điện thoại',
                              labelStyle: TextStyle(color: Colors.black)),
                        ),
                        Text(
                          warrning,
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: SizedBox(
                              height: 50,
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    api_check_tai_khoan(username.text, password.text).then((value) {
                                      setState(() {
                                        check = value;
                                        if (username.text == "" ||
                                            password2.text == "" ||
                                            password.text == "" ||
                                            hoten.text == "" ||
                                            email.text == "" ||
                                            sdt.text == "") {
                                          warrning = "Vui lòng nhập đầy đủ thông tin";
                                        } else if (validateMobile(sdt.text) == "fail") {
                                          warrning = "Số điện thoại phải là số và có 10 số";
                                        } else if (email.text.contains("@") == false) {
                                          warrning = "Vui lòng nhập đúng định dạng mail";
                                        } else if (password.text != password2.text) {
                                          warrning = "Vui lòng xác nhận đúng mật khẩu";
                                        } else if (check != "0") {
                                          warrning = "Tài khoản đã được sữ dụng";
                                        } else {
                                          state = "0";
                                          warrning = "";
                                          api_Register(username.text, password.text, hoten.text, email.text, sdt.text).then((value) {
                                            state = value.toString();
                                            setState(() {});
                                          });
                                        }
                                      });
                                    });
                                  });
                                },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.black)),
                                child: state == ""
                                    ? Text(
                                        "Đăng ký",
                                        style: TextStyle(color: Colors.white, fontSize: 20),
                                      )
                                    : state == "0"
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : Text('Đăng ký thành công'),
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
