class LuuTru {
  int? id;
  String? diaDanhId;
  String? tenLuuTru;
  String? diaChi;
  String? sDT;

  LuuTru({this.id, this.diaDanhId, this.tenLuuTru, this.diaChi, this.sDT});

  LuuTru.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diaDanhId = json['DiaDanhId'];
    tenLuuTru = json['TenLuuTru'];
    diaChi = json['DiaChi'];
    sDT = json['SDT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['DiaDanhId'] = this.diaDanhId;
    data['TenLuuTru'] = this.tenLuuTru;
    data['DiaChi'] = this.diaChi;
    data['SDT'] = this.sDT;
    return data;
  }
}