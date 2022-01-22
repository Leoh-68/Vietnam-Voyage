import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:template/taikhoan.dart';

String urlBaseAPI = "http://10.0.2.2:8000/api/";
Future<String> api_Check_Tai_Khoan(String Username, String Password) async {
  String check = '';
  try {
    final response = await http.post(Uri.parse(urlBaseAPI + "CheckTaiKhoan"),
        body: {"username": "$Username"});
    check = response.body;
  } catch (e) {}

  return check;
}

Future<List<TaiKhoan>> api_lay_ds_tai_khoan() async {
  List<TaiKhoan> TK = [];
  try {
    final response = await http.get(Uri.parse(urlBaseAPI + "LayDSTaiKhoan"));
    List TKlist = json.decode(response.body);
    TK = TKlist.map((e) => TaiKhoan.fromJson(e)).toList();
  } catch (e) {}

  return TK;
}
