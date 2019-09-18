class CatItemModel {
  final String id;
  final String imageUrl;
  final String fact;

  CatItemModel(this.id, this.imageUrl, this.fact);

  factory CatItemModel.fromMap(map) {
    return CatItemModel(
      map['id'],
      map['url'],
      map['fact'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'url': imageUrl,
    'fact': fact,
  };

  @override
  String toString() {
    return 'id: $id, url: $imageUrl, fact: $fact';
  }
}