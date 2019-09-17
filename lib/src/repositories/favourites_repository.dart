import 'package:cat_test_application/src/models/favourites_model.dart';
import 'package:cat_test_application/src/repositories/auth_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FavouritesRepository {
  static const int pageItemLimit = 10;

  Firestore _db = Firestore.instance;
  DocumentSnapshot _lastDocument;

  Future<FavouritesModel> getFavourites(FirebaseUser user) async{
    var query = _db.collection('users').where('uid', isEqualTo: user.uid);
    var snapshot = await query.getDocuments();
    var documents = snapshot.documents;
    _lastDocument = documents.last;

    var result = await query.limit(pageItemLimit).getDocuments();

    var list = result.documents.map((doc) => Favourite.fromMap(doc.data)).toList();
    return FavouritesModel(list);
  }

  Future<FavouritesModel> getMoreFavourites(FirebaseUser user) async{
    var query = _db.collection('users').where('uid', isEqualTo: user.uid).startAfterDocument(_lastDocument).limit(pageItemLimit);
    var snapshot = await query.getDocuments();
    var documents = snapshot.documents;
    _lastDocument = documents.last;

    var list = documents.map((doc) => Favourite.fromMap(doc.data)).toList();
    return FavouritesModel(list);
  }

  addFavourite(Favourite favourite) {
    var collection = _db.collection('users').document(authRepository.currentUser.uid);
    collection.updateData(
      {'favourites': FieldValue.arrayUnion([favourite.toMap()])}
    );
    //authRepository.updateUserData(authRepository.currentUser, favourites: FavouritesModel(localFavourites));
  }
  removeFavourite(Favourite favourite) {
    var collection = _db.collection('users').document(authRepository.currentUser.uid);
    collection.updateData(
      {'favourites': FieldValue.arrayRemove([favourite.toMap()])}
    );
  }
  
  Stream<DocumentSnapshot> isLikedStream(String url) {
    return _db.collection('users').document(authRepository.currentUser.uid).snapshots();
    /*var list = snapshot.data['favourites'] as List<Favourite>;

    bool containsUrl() {
      for (var i in list) {
        if (i.url == url) {
          return true;
        }
      }
      return false;
    }

    yield containsUrl();*/
    
  }
  bool isLiked(DocumentSnapshot snapshot, String url) {
    var list = snapshot.data['favourites'].map((item) => Favourite.fromMap(item));
    for (var i in list) {
        if (i.url == url) {
          return true;
        }
    }
    return false;
  }
}

final favouritesRepository = FavouritesRepository();