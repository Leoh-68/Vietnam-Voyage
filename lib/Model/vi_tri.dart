class ViTri {
  int? id;
  int? kinhDo;
  int? viDo;
  ViTri({
    this.id,
    this.kinhDo,
    this.viDo,
  });

  ViTri.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    kinhDo = json['KinhDo'];
    viDo = json['ViDo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['KinhDo'] = this.kinhDo;
    data['ViDo'] = this.viDo;
    return data;
  }
}
