import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Create a CollectionReference called users that references the firestore collection
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  //Function to save user data
  Future<void> saveUserData(
    String name,
    email,
  ) {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'name': name,
          'email': email,
        })
        .then((value) => print("User Added"))
        .catchError(
            (error) => print("\n\n\n Failed to add user: $error \n\n\n\n"));
  }
}
