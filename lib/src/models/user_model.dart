class UserModel {
  String uid, email, name;
  List<dynamic> upVotedlist, downVotedlist, userMarkers;
  bool introSeen;
  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.introSeen = false,
    this.userMarkers = const [],
    this.upVotedlist = const [],
    this.downVotedlist = const [],
  });
  UserModel.fromJson(Map<String, dynamic> data)
      : email = data['email'],
        name = data['name'],
        uid = data['uid'],
        introSeen = false,
        userMarkers = const [],
        upVotedlist = const [],
        downVotedlist = const [];
}
