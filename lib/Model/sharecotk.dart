import 'package:template/taikhoan.dart';

class ShareCoAccount {
  int? id;
  String? baiViet;
  String? diaDanhId;
  String? taiKhoanId;
  String? liked;
  String? view;
  String? created;
  String? idshare;
  String? isLike;
  TaiKhoan? tk;
  String? isFavor;
  String? image;
  ShareCoAccount({this.id, this.baiViet, this.diaDanhId, this.taiKhoanId, this.liked, this.view, this.idshare});

  ShareCoAccount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    baiViet = json['BaiViet'];
    diaDanhId = json['DiaDanhId'];
    taiKhoanId = json['TaiKhoanId'];
    created = json['created_at'];
    liked = json['Liked'];
    view = json['View'];
    idshare = json['idshare'];
    isLike = json['isFavorite'];
    image = json['hinhanh'];
    tk = TaiKhoan.fromJson(json['tai_khoan']);
    isFavor = json['isFavor'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['BaiViet'] = this.baiViet;
    data['DiaDanhId'] = this.diaDanhId;
    data['TaiKhoanId'] = this.taiKhoanId;
    data['Liked'] = this.liked;
    data['Unliked'] = this.view;
    return data;
  }
}
