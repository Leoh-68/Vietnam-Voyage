import 'package:template/login.dart';
import 'package:template/profile.dart';
import 'Model/dia_danh.dart';
import 'Api/api.dart';
import 'package:flutter/material.dart';
import 'package:template/ApiFolder/dia_danh_show.dart';

class Search extends StatefulWidget {
  final String name;
  final String username;
  final String password;
  const Search({Key? key, required this.name, required this.username, required this.password}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  int countter = 2;
  bool typing = false;
  String text = "";
  String location = "3";
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
            FutureBuilder<List<DiaDanh>>(
                future: api_Finds_DiaDanh(widget.name),
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
                                                      child:
                                                          Image(image: AssetImage('images/' + snapshot.data![index].hinhAnh!), fit: BoxFit.cover))),
                                              onPressed: () {},
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 10, left: 10),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot.data![index].tenDiaDanh!.toString(),
                                            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                                          ),
                                          Text(snapshot.data![index].viTri!,
                                              style: TextStyle(
                                                color: Colors.black,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (contex) => Detail(
                                                username: widget.username,
                                                password: widget.password,
                                                mota: snapshot.data![index].moTa.toString(),
                                                id: snapshot.data![index].id.toString(),
                                                name: snapshot.data![index].tenDiaDanh.toString(),
                                                location: snapshot.data![index].viTri!,
                                                image: location)));
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
