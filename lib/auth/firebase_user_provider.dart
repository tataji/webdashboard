import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class WebappFirebaseUser {
  WebappFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

WebappFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<WebappFirebaseUser> webappFirebaseUserStream() => FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<WebappFirebaseUser>(
      (user) {
        currentUser = WebappFirebaseUser(user);
        return currentUser!;
      },
    );
