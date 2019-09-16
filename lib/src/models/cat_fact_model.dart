class CatFactModel {
  final String fact;

  CatFactModel({this.fact});

  factory CatFactModel.fromJson(Map<String, dynamic> json) {
    return CatFactModel(fact: json['fact']);
  }
}