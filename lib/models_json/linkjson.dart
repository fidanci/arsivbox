import 'dart:collection';

class LinkJson {
  String aciklama;
  String baslik;
  String link;
  String key;

  LinkJson({this.aciklama, this.baslik, this.link});

  LinkJson.fromJson(Map<String, dynamic> json) {
    aciklama = json['aciklama'];
    baslik = json['baslik'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aciklama'] = this.aciklama;
    data['baslik'] = this.baslik;
    data['link'] = this.link;
    return data;
  }
}

class LinkedList {
  List<LinkJson> links = [];

  LinkedList.fromJsonList(Map value) {
    value.forEach((key, value) {
      var link = LinkJson.fromJson(value);
      link.key = key;
      links.add(link);
    });
  }
}