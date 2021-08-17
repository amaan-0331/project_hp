import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class DatabaseController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //Function to save user data
  Future<void> saveUserData(String name, email, uid) {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(uid)
        .set({
          'uid': uid,
          'name': name,
          'email': email,
        })
        .then((value) => Logger().d("User Added"))
        .catchError((error) =>
            Logger().e("\n\n\n Failed to add user: $error \n\n\n\n"));
  }
}
