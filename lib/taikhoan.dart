class TaiKhoan {
  int? id;
  String? userName;
  String? password;
  String? hoTen;
  String? email;
  String? sDT;
  int? status;
  String? createdAt;
  Null? updatedAt;
  Null? deletedAt;

  TaiKhoan(
      {this.id,
      this.userName,
      this.password,
      this.hoTen,
      this.email,
      this.sDT,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  TaiKhoan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['UserName'];
    password = json['Password'];
    hoTen = json['HoTen'];
    email = json['Email'];
    sDT = json['SDT'];
    status = json['Status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
