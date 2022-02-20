import 'package:template/Model/luot_share.dart';
import 'package:template/Model/luu_tru.dart';
import 'package:template/Model/share.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:template/Model/dia_danh.dart';
import 'package:template/Model/sharecotk.dart';
import 'package:template/Model/taikhoancoshare.dart';
import 'package:template/Model/vi_tri.dart';
import 'package:template/taikhoan.dart';
import 'package:map_launcher/map_launcher.dart';

String urlBaseAPI = "http://10.0.2.2:8001/api/";
Future<List<DiaDanh>> api_GetAll_DiaDanh() async {
  List<DiaDanh> data = [];
  try {
    final response = await http.get(Uri.parse(urlBaseAPI + "DiaDanh"));
    if (response.statusCode == 200) {
      List jsonRaw = json.decode(response.body);
      data = jsonRaw.map((data) => DiaDanh.fromJson(data)).toList();
    } else {
      throw Exception("Something get wrong! Status code ${response.statusCode}");
    }
  } catch (e) {}
  return data;
}

Future<List<DiaDanh>> api_Get5_DiaDanh() async {
  List<DiaDanh> data = [];
  List<DiaDanh> dataa = [];
  final response = await http.get(Uri.parse(urlBaseAPI + "top"));
  List jsonRaw = json.decode(response.body);
  data = jsonRaw.map((data) => DiaDanh.fromJson(data)).toList();
  dataa = data;
  return dataa;
}

Future<List<DiaDanh>> api_Find_DiaDanh(String TenDiaDanh) async {
  List<DiaDanh> data = [];
  try {
    final response = await http.post(Uri.parse(urlBaseAPI + "TimKiem?TenDiaDanh=$TenDiaDanh"));
    if (response.statusCode == 200) {
      List jsonRaw = json.decode(response.body);
      data = jsonRaw.map((data) => DiaDanh.fromJson(data)).toList();
    } else {
      throw Exception("Something get wrong! Status code ${response.statusCode}");
    }
  } catch (e) {}

  return data;
}

Future<DiaDanh> api_Hot_DiaDanh() async {
  DiaDanh data = DiaDanh();

  final response = await http.post(Uri.parse(urlBaseAPI + "LayDiaDanhHotNhat"));
  if (response.statusCode == 200) {
    final jsonRaw = json.decode(response.body);
    data = DiaDanh.fromJson(jsonRaw);
  } else {
    throw Exception("Something get wrong! Status code ${response.statusCode}");
  }

  return data;
}

Future<List<DiaDanh>> api_Finds_DiaDanh(String TenDiaDanh, String mode) async {
  List<DiaDanh> data = [];
  try {
    final response = await http.post(Uri.parse(urlBaseAPI + "TimKiem"), body: {"name": "$TenDiaDanh"});
    if (response.statusCode == 200) {
      List jsonRaw = json.decode(response.body);
      data = jsonRaw.map((data) => DiaDanh.fromJson(data)).toList();
    } else {
      throw Exception("Something get wrong! Status code ${response.statusCode}");
    }
  } catch (e) {}

  return data;
}

Future<List<Share>> api_GetShare(int IdTaiKhoan) async {
  List<Share> data = [];
  try {
    final response = await http.get(Uri.parse(urlBaseAPI + "TaiKhoan"));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonRaw = json.decode(response.body);
      final List share = jsonRaw["share"];
      data = share.map((data) => Share.fromJson(data)).toList();
    } else {
      throw Exception("Something get wrong! Status code ${response.statusCode}");
    }
  } catch (e) {}

  return data;
}

Future<List<ShareCoAccount>> api_GetShareDetail(int IdTaiKhoan, String idDiaDanh) async {
  List<ShareCoAccount> data = [];

  final response = await http.get(Uri.parse(urlBaseAPI + "PostShare?tkid=$IdTaiKhoan&id=$idDiaDanh"));
  if (response.statusCode == 200) {
    List jsonRaw = json.decode(response.body);
    final List share = jsonRaw;
    data = share.map((data) => ShareCoAccount.fromJson(data)).toList();
  } else {
    throw Exception("Something get wrong! Status code ${response.statusCode}");
  }
  return data;
}

Future<String> api_Post(String BaiViet, String DiaDanhId, String TaiKhoanId, String HinhAnh) async {
  String result = "Thành công";
  try {
    final response = await http.get(Uri.parse(urlBaseAPI + "PostShare?id=$DiaDanhId&BaiViet=$BaiViet&TaiKhoanID=$TaiKhoanId&Image=$HinhAnh"));
    result = response.body;
  } catch (e) {}
  return result;
}

Future<List<ShareCoAccount>> api_GetShareHome(String IdAccount) async {
  List<ShareCoAccount> data = [];

  final response = await http.get(Uri.parse(urlBaseAPI + "PostShareHome?tkid=$IdAccount"));
  if (response.statusCode == 200) {
    List jsonRaw = json.decode(response.body);
    final List share = jsonRaw;
    data = share.map((data) => ShareCoAccount.fromJson(data)).toList();
  } else {
    throw Exception("Something get wrong! Status code ${response.statusCode}");
  }
  return data;
}

Future<LuotShare> api_Like(String id, String idaccount) async {
  LuotShare result = new LuotShare();
  final response = await http.get(Uri.parse(urlBaseAPI + "likePost?id=$id&idaccount=$idaccount"));
  final jsonraw = json.decode(response.body);
  result = LuotShare.fromJson(jsonraw);
  return result;
}

Future<LuotShare> api_reLike(String id, String idaccount) async {
  LuotShare result = new LuotShare();
  final response = await http.get(Uri.parse(urlBaseAPI + "relikePost?id=$id&idaccount=$idaccount"));
  final jsonraw = json.decode(response.body);
  result = LuotShare.fromJson(jsonraw);
  return result;
}

Future<List<TaiKhoan>> api_lay_ds_tai_khoan() async {
  List<TaiKhoan> TK = [];
  final response = await http.get(Uri.parse(urlBaseAPI + "LayDSTaiKhoan"));
  List tk = json.decode(response.body);
  TK = tk.map((e) => TaiKhoan.fromJson(e)).toList();
  return TK;
}

Future<TaiKhoan> api_lay_tai_khoan_id(String username) async {
  TaiKhoan TK = new TaiKhoan();
  final response = await http.post(Uri.parse(urlBaseAPI + "accountinfoid"), body: {'id': "$username"});
  final tk = json.decode(response.body);
  TK = TaiKhoan.fromJson(tk);
  return TK;
}

Future<TaiKhoan> api_lay_tai_khoan(String username, String pass) async {
  TaiKhoan TK = new TaiKhoan();
  final response = await http.post(Uri.parse(urlBaseAPI + "accountinfo"), body: {'username': "$username", 'password': "$pass"});
  final tk = json.decode(response.body);
  TK = TaiKhoan.fromJson(tk);
  return TK;
}

Future<String> api_check_tai_khoan(String username, String pass) async {
  String TK = "";
  final response = await http.post(Uri.parse(urlBaseAPI + "checkTrung"), body: {'username': "$username", 'password': "$pass"});
  TK = response.body;

  return TK;
}

Future<TaiKhoancoShare> api_share_tai_khoan(String id) async {
  TaiKhoancoShare result = TaiKhoancoShare();
  final response = await http.post(Uri.parse(urlBaseAPI + "TaiKhoan"), body: {'id': id});
  final tk = json.decode(response.body);
  result = TaiKhoancoShare.fromJson(tk);
  return result;
}

Future<ViTri> api_GetLocation(String id) async {
  ViTri data = ViTri();
  ViTri dataa = ViTri();
  final response = await http.get(Uri.parse(urlBaseAPI + "ViTri?id=$id"));
  final jsonRaw = json.decode(response.body);
  dataa = ViTri.fromJson(jsonRaw);
  data = dataa;
  return data;
}

Future<String> api_Register(
  String username,
  String password,
  String hoten,
  String email,
  String sdt,
) async {
  String data = "";
  final response = await http.post(Uri.parse(urlBaseAPI + "dangky"),
      body: {'username': "$username", 'password': "$password", 'hoten': "$hoten", 'email': "$email", 'sdt': "$sdt"});
  final jsonRaw = json.decode(response.body);
  data = jsonRaw.toString();
  return data;
}

//đếm số like
Future<String> api_countlike(String iddiadanh, String idpost) async {
  String result = "";
  final response = await http.get(Uri.parse(urlBaseAPI + "countlike?id=$iddiadanh&idpost=$idpost"));
  result = response.body;
  return result;
}

Future<String> api_countunlike(String id) async {
  String result = "";
  final response = await http.get(Uri.parse(urlBaseAPI + "countunlike?id=$id"));
  result = response.body;
  return result;
}

//Check like
Future<String> api_liked(String idaccount, String idshare) async {
  String result = "";
  final response = await http.get(Uri.parse(urlBaseAPI + "liked?idaccount=$idaccount&idshare=$idshare"));
  result = response.body;
  return result;
}

Future<String> api_unliked(String idaccount, String idshare) async {
  String result = "";
  final response = await http.get(Uri.parse(urlBaseAPI + "unliked?idaccount=$idaccount&idshare=$idshare"));
  result = response.body;
  return result;
}

Future<List<LuuTru>> api_get_luutru(String id) async {
  List<LuuTru> result = [];
  final response = await http.get(Uri.parse(urlBaseAPI + "luutru?id=$id"));
  List tk = json.decode(response.body);
  result = tk.map((e) => LuuTru.fromJson(e)).toList();
  return result;
}
