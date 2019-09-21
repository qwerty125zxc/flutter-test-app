import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _AuthRepository {
  final facebookLogin = FacebookLogin();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
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
    final result = await facebookLogin.logInWithReadPermissions(['email']);
    AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: result.accessToken.token);

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
    updateUserData(user);

    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('signedIn', true);
    prefs.setString('signedInWith', 'facebook');

    return user;
  }

  updateUserData(FirebaseUser user) async {
    currentUser = user;
    
    DocumentReference ref = _db.collection('users').document(user.uid);
    
    ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName,
    }, merge: true);

    var snapshot = await ref.get();
    if (snapshot.data['favourites'] == null) {
      ref.updateData({'favourites': []});
    }
  }

  Future<void> signOut() async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('signedIn', false);
    currentUser = null;
    _auth.signOut();
  }
}

final authRepository = _AuthRepository();