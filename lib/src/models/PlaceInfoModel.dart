class PlaceInfoModel {
  final int infoId;
  final int placeId;
  final String title;
  final String content;

  PlaceInfoModel({
    required this.infoId,
    required this.placeId,
    required this.title,
    required this.content,
  });

  factory PlaceInfoModel.fromJson(Map<String, dynamic> json) {
    return PlaceInfoModel(
      infoId: json['info_id'],
      placeId: json['place_id'],
      title: json['title'],
      content: json['content'],
    );
  }
}
