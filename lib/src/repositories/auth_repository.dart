import 'package:cat_test_application/src/models/cat_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _AuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _db = Firestore.instance;
  FirebaseUser currentUser;
  
  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    updateUserData(user);

    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('signedIn', true);
    prefs.setString('signedInWith', 'google');

    return user;
  }

  Future<FirebaseUser> signInWithFacebook() async {
    final facebookLogin = FacebookLogin();
    final result = await facebookLogin.logInWithReadPermissions(['email']);
    AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);
    FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    updateUserData(user);

    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('signedIn', true);
    prefs.setString('signedInWith', 'facebook');

    return user;
  }

  updateUserData(FirebaseUser user, {CatItemModel favourites}) async {
    currentUser = user;
    
    DocumentReference ref = _db.collection('users').document(user.uid);

    var snapshot = await ref.get();
    if (snapshot.data['favourites'] == null) {
      ref.setData({'favourites': []}, merge: true);
    }
    
    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
    }, merge: true);
  }

  Future<void> signOut() async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('signedIn', false);
    _auth.signOut();
  }
}

final authRepository = _AuthRepository();