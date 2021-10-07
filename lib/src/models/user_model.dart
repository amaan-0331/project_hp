class UserModel {
  String uid, email, name;
  List<dynamic> upVotedlist, downVotedlist, userMarkers;
  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    this.userMarkers = const [],
    this.upVotedlist = const [],
    this.downVotedlist = const [],
  });
  UserModel.fromJson(Map<String, dynamic> data)
      : email = data['email'],
        name = data['name'],
        uid = data['uid'],
        userMarkers = const [],
        upVotedlist = const [],
        downVotedlist = const [];
}
