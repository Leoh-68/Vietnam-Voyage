import 'package:template/taikhoan.dart';

class Share {
  int? id;
  String? baiViet;
  String? diaDanhId;
  String? taiKhoanId;
  String? liked;
  String? view;
  String? created;
  String? idshare;
  String? isLike;
  String? isFavor;
  String? image;
  Share({this.id, this.baiViet, this.diaDanhId, this.taiKhoanId, this.liked, this.view, this.idshare});

  Share.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    baiViet = json['BaiViet'];
    diaDanhId = json['DiaDanhId'];
    taiKhoanId = json['TaiKhoanId'];
    created = json['created_at'];
    liked = json['Liked'];
    view = json['View'];
    idshare = json['idshare'];
    isLike = json['isFavorite'];
    isFavor = json['isFavor'];
    image = json['hinhanh'];
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
