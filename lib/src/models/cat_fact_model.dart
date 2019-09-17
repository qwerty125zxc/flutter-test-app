class CatFactModel {
  final String text;

  CatFactModel({this.text});

  factory CatFactModel.fromJson(Map<String, dynamic> json) {
    return CatFactModel(text: json['fact']);
  }
}