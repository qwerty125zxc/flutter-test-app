import 'package:google_sign_in/google_sign_in.dart';

class _UserRepository {
  var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount userAccount;
  
  signInwithGoogle() async {
    userAccount = await _googleSignIn.signIn();
  }
}

final userRepository = _UserRepository();