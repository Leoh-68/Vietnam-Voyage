class LuotShare {
  int? id;
  int? diaDanhId;
  int? liked;
  int? view;

  LuotShare({this.id, this.diaDanhId, this.liked, this.view});

  LuotShare.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diaDanhId = json['DiaDanhId'];
    liked = json['Liked'];
    view = json['View'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['DiaDanhId'] = this.diaDanhId;
    data['Liked'] = this.liked;
    data['View'] = this.view;
    return data;
  }
}
