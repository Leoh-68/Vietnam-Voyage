class TaiKhoan {
  int? id;
  String? username;
  String? password;
  String? hoTen;
  String? sdt;
  String? email;
  String? image;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  TaiKhoan({this.id, this.username, this.password, this.hoTen, this.sdt, this.email, this.createdAt, this.updatedAt, this.deletedAt});

  TaiKhoan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['UserName'];
    password = json['Password'];
    hoTen = json['HoTen'];
    sdt = json['SDT'];
    email = json['Email'];
    image = json['hinhanh'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['hoten'] = this.hoTen;
    data['sdt'] = this.sdt;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
