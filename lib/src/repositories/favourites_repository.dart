import 'package:cat_test_application/src/models/cat_model.dart';
import 'package:cat_test_application/src/repositories/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavouritesRepository {
  static const int pageItemLimit = 10;

  Firestore _db = Firestore.instance;
  var _currentFavouritesList = <CatItemModel>[];
  bool _downloaded = false;

  Future<List<CatItemModel>> getFavourites(int page) async{
    if (!_downloaded) {
      _downloaded = true;
      var query = _db.collection('users').where('uid', isEqualTo: authRepository.currentUser.uid);
      var snapshot = await query.getDocuments();
      var documents = snapshot.documents;
      var document = documents.first.data;

      List<Map> list = List.from(document['favourites']);
      _currentFavouritesList = list.map((item) => CatItemModel.fromMap(item)).toList();
    }
    return _currentFavouritesList.skip(pageItemLimit * page).take(pageItemLimit).toList();
  }

  addFavourite(CatItemModel favourite) {
    var collection = _db.collection('users').document(authRepository.currentUser.uid);
    collection.updateData(
      {
        'favourites': FieldValue.arrayUnion([favourite.toMap()])
      }
    );
  }
  removeFavourite(CatItemModel favourite) {
    var collection = _db.collection('users').document(authRepository.currentUser.uid);
    collection.updateData(
      {'favourites': FieldValue.arrayRemove([favourite.toMap()])}
    );
  }
  
  Stream<DocumentSnapshot> isLikedStream() {
    return _db.collection('users').document(authRepository.currentUser.uid).snapshots();
  }
  bool isLiked(DocumentSnapshot snapshot, String imageUrl) {
    var list = snapshot.data['favourites'].map((item) => CatItemModel.fromMap(item));
    for (var i in list) {
      if (i.imageUrl == imageUrl) {
        return true;
      }
    }
    return false;
  }
}

final favouritesRepository = FavouritesRepository();