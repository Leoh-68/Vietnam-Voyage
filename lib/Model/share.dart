class Share {
  int? id;
  String? baiViet;
  String? danhGia;
  String? diaDanhId;
  String? taiKhoanId;
  String? liked;
  String? unliked;

  Share({this.id, this.baiViet, this.danhGia, this.diaDanhId, this.taiKhoanId, this.liked, this.unliked});

  Share.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    baiViet = json['BaiViet'];
    danhGia = json['DanhGia'];
    diaDanhId = json['DiaDanhId'];
    taiKhoanId = json['TaiKhoanId'];
    liked = json['Liked'];
    unliked = json['Unliked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['BaiViet'] = this.baiViet;
    data['DanhGia'] = this.danhGia;
    data['DiaDanhId'] = this.diaDanhId;
    data['TaiKhoanId'] = this.taiKhoanId;
    data['Liked'] = this.liked;
    data['Unliked'] = this.unliked;
    return data;
  }
}
