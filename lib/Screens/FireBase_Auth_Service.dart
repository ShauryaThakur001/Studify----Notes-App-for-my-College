import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {

      // Force to Choose
      await _googleSignIn.signOut();
      await _auth.signOut();


      // Open Google Account Picker
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("Google Sign In Cancelled");
        return null; 
      }

      // Get Authentication Tokens (accessToken & idToken)
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create Firebase Credential using tokens
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase using the credential
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      return userCredential.user; // SUCCESS

    } catch (e) {
      print("Google Sign-In Error: $e");
      return null; 
    }
  }

  /// Logout from Google + Firebase
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    print("Logged out successfully");
  }
}
