class Favourite {
  final String url;
  final String fact;

  Favourite(this.url, this.fact);

  factory Favourite.fromMap(map) {
    return Favourite(
      map['url'],
      map['fact'],
    );
  }

  Map<String, dynamic> toMap() => {
    'url': url,
    'fact': fact,
  };
}

class FavouritesModel {
  final List<Favourite> list;
  
  FavouritesModel(this.list);

  toFirestoreList() => list.map((fav) => fav.toMap()).toList();
}