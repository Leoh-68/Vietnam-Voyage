class ViTri {
  int? id;
  String? diaDanhId;
  String? kinhDo;
  String? viDo;

  ViTri({
    this.id,
    this.diaDanhId,
    this.kinhDo,
    this.viDo,
  });

  ViTri.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diaDanhId = json['DiaDanhId'];
    kinhDo = json['KinhDo'];
    viDo = json['ViDo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['DiaDanhId'] = this.diaDanhId;
    data['KinhDo'] = this.kinhDo;
    data['ViDo'] = this.viDo;
    return data;
  }
}
