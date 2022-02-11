import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:template/taikhoan.dart';

String urlBaseAPI = "http://10.0.2.2:8001/api/";
Future<String> api_Check_Tai_Khoan(String Username, String Password) async {
  String check = '';
  try {
    final response = await http.post(Uri.parse(urlBaseAPI + "CheckTaiKhoan"), body: {"username": "$Username"});
    check = response.body;
  } catch (e) {}

  return check;
}


