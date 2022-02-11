import 'package:template/Model/share.dart';

class TaiKhoancoShare {
  int? id;
  String? userName;
  String? password;
  String? hoTen;
  String? email;
  String? sDT;
  String? status;
  String? created;
  List<Share>? share;
  TaiKhoancoShare({this.id, this.userName, this.password, this.hoTen, this.email, this.sDT, this.status});
  TaiKhoancoShare.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['UserName'];
    password = json['Password'];
    hoTen = json['HoTen'];
    email = json['Email'];
    sDT = json['SDT'];
    status = json['Status'];
    List result = json['share'];
    share = result.map((e) => Share.fromJson(e)).toList();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['UserName'] = this.userName;
    data['Password'] = this.password;
    data['HoTen'] = this.hoTen;
    data['Email'] = this.email;
    data['SDT'] = this.sDT;
    data['Status'] = this.status;
    return data;
  }
}
