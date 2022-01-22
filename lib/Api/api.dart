import 'package:template/Model/share.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:template/Model/dia_danh.dart';
import 'package:template/taikhoan.dart';

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
  try {
    final response = await http.post(Uri.parse(urlBaseAPI + "LayDiaDanhHotNhat"));
    if (response.statusCode == 200) {
      final jsonRaw = json.decode(response.body);
      data = DiaDanh.fromJson(jsonRaw);
    } else {
      throw Exception("Something get wrong! Status code ${response.statusCode}");
    }
  } catch (e) {}
  return data;
}

Future<List<DiaDanh>> api_Finds_DiaDanh(String TenDiaDanh) async {
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

Future<String> api_Post(String BaiViet, String DanhGia, String DiaDanhId, String TaiKhoanId) async {
  String result = "Thành công";
  try {
    final response = await http.get(Uri.parse(urlBaseAPI + "PostShare?id=$DiaDanhId&BaiViet=$BaiViet&TaiKhoanID=1&DanhGia=$DanhGia"));
    result = response.body;
  } catch (e) {}
  return result;
}

Future<List<Share>> api_GetShareHome() async {
  List<Share> data = [];
  try {
    final response = await http.get(Uri.parse(urlBaseAPI + "PostShareHome"));
    if (response.statusCode == 200) {
      List jsonRaw = json.decode(response.body);
      final List share = jsonRaw;
      data = share.map((data) => Share.fromJson(data)).toList();
    } else {
      throw Exception("Something get wrong! Status code ${response.statusCode}");
    }
  } catch (e) {}
  return data;
}

Future<String> api_Like(String id) async {
  String result = "";
  try {
    final response = await http.get(Uri.parse(urlBaseAPI + "likePost?id=$id"));
    result = response.body;
  } catch (e) {}
  return result;
}

Future<String> api_reLike(String id) async {
  String result = "";
  try {
    final response = await http.get(Uri.parse(urlBaseAPI + "relikePost?id=$id"));
    result = response.body;
  } catch (e) {}
  return result;
}

Future<String> api_UnLike(String id) async {
  String result = "";
  try {
    final response = await http.get(Uri.parse(urlBaseAPI + "unlikePost?id=$id"));
    result = response.body;
  } catch (e) {}
  return result;
}

Future<String> api_reUnLike(String id) async {
  String result = "";
  try {
    final response = await http.get(Uri.parse(urlBaseAPI + "reunlikePost?id=$id"));
    result = response.body;
  } catch (e) {}
  return result;
}

Future<List<TaiKhoan>> api_lay_ds_tai_khoan() async {
  List<TaiKhoan> TK = [];
  final response = await http.get(Uri.parse(urlBaseAPI + "LayDSTaiKhoan"));
  List tk = json.decode(response.body);
  TK = tk.map((e) => TaiKhoan.fromJson(e)).toList();
  return TK;
}
