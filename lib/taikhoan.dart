class TaiKhoan {
  int? id;
  String? username;
  String? password;
  String? hoten;
  String? sdt;
  String? email;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  TaiKhoan(
      {this.id,
      this.username,
      this.password,
      this.hoten,
      this.sdt,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  TaiKhoan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    hoten = json['hoten'];
    sdt = json['sdt'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['hoten'] = this.hoten;
    data['sdt'] = this.sdt;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
