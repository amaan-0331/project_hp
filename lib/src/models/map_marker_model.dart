class MarkerModel {
  String? markerId, uid;
  double latitude, longitude;
  String title, snippet;
  List<dynamic> upVoterslist, downVoterslist;

  MarkerModel({
    required this.markerId,
    required this.uid,
    required this.latitude,
    required this.longitude,
    required this.title,
    required this.snippet,
    this.upVoterslist = const [],
    this.downVoterslist = const [],
  });
  MarkerModel.fromJson(Map<String, dynamic> data)
      : markerId = data['markerId'],
        uid = data['uid'],
        latitude = data['latitude'],
        longitude = data['longitude'],
        title = data['title'],
        snippet = data['snippet'],
        upVoterslist = const [],
        downVoterslist = const [];
}
