import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_hp/controllers/database_controller.dart';
import 'package:project_hp/screens/map_screen/components/home_screen_title.dart';
import 'package:project_hp/screens/map_screen/components/marker_card.dart';
import 'package:project_hp/screens/map_screen/components/temp_screen.dart';

class UpdateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            HomeScreenTitle(size: size, title: 'Hey User!'),
            HomeScreenList(size: size),
          ],
        ),
      ),
    );
  }
}

class HomeScreenList extends StatelessWidget {
  const HomeScreenList({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.75,
      child: StreamBuilder<QuerySnapshot>(
        stream: DatabaseController().markerStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return TempScreen(size: size, message: 'Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return TempScreen(size: size, message: "Loading");
          }

          return ListView(
            cacheExtent: 15,
            children: snapshot.data!.docs.map(
              (DocumentSnapshot document) {
                Map<String, dynamic> data = DatabaseController()
                    .processDataFromStreambuilder(context, document);
                return MarkerCard(
                  data: data,
                  func: () {},
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
