import 'package:firebase_auth/firebase_auth.dart';
import 'package:yourwellbeing/Modal/user.dart';

// Creating a class for authentication
class AuthMethods {
  // calling the instance of FirebaseAuth for further use
  //
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserData? _userFromFirebaseUser(User user) {
    return user != null ? UserData(userId: user.uid) : null;
  }

  //Function future function because it might take some time calling the data from firebase
  Future signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    // To handle exception for crash issue
    try {
      // getting the result of email and password which user has inputted firebase_auth package
      // await help to wait for this function be passed before calling another function
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser!);
    } catch (e) {
      print('wrong password');
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser!);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
