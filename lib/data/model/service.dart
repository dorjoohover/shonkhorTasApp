class Service {

  String? sId;
  String? img;
  int? count;
  String? text;

  Service({this.img, this.sId, this.count, this.text});

  Service.fromJson(Map<String, dynamic> json) {
    img = json['img'];
    sId = json['_id'];
    count = json['count'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['img'] = this.img;
    data['sId'] = this.sId;
    data['count'] = this.count;
    data['text'] = this.text;
    return data;
  }
}