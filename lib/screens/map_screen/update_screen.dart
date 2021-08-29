import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_hp/utils/functions.dart';

class UpdateScreen extends StatefulWidget {
  UpdateScreen({Key? key}) : super(key: key);

  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('markers').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UtilFuncs.pageLoader,
                Text("Loading"),
              ],
            ),
          );
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['title']),
              subtitle: Text(data['snippet']),
            );
          }).toList(),
        );
      },
    ));
  }
}
