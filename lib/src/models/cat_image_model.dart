class CatImageModel {
  final String id;
  final String url;

  CatImageModel({this.id, this.url});

  factory CatImageModel.fromJson(Map<String, dynamic> json) {
    return CatImageModel(
      id: json['id'],
      url: json['url'],
    );
  }
}