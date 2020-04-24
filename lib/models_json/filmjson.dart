class FilmJson {
  String filmAciklama;
  String filmBaslik;
  String filmFotoLink;
  String filmLink;

  FilmJson(
      {this.filmAciklama, this.filmBaslik, this.filmFotoLink, this.filmLink});

  FilmJson.fromJson(Map<String, dynamic> json) {
    filmAciklama = json['filmAciklama'];
    filmBaslik = json['filmBaslik'];
    filmFotoLink = json['filmFotoLink'];
    filmLink = json['filmLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filmAciklama'] = this.filmAciklama;
    data['filmBaslik'] = this.filmBaslik;
    data['filmFotoLink'] = this.filmFotoLink;
    data['filmLink'] = this.filmLink;
    return data;
  }
}