// TODO: Make this link class a module
class Link {
  String? q;
  int? rating;
  String? title;
  String? source;
  String? description;
  String? imageUrl;
  String? link;
  int? userId;


  Link({this.q, this.rating, this.title, this.source, this.link, this.userId, this.description, this.imageUrl});

  Link.fromJson(Map<String, dynamic> json) {
    q = json['q'];
    rating = json['rating'];
    title = json['title'];
    source = json['source'];
    link = json['link'];
    userId = json['userId'];
    description = json['description'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final linkData = <String, dynamic>{};
    linkData['q'] = q;
    linkData['rating'] = rating;
    linkData['title'] = title;
    linkData['source'] = source;
    linkData['link'] = link;
    linkData['userId'] = userId;
    linkData['description'] = description;
    linkData['imageUrl'] = imageUrl;
    return linkData;
  }
}