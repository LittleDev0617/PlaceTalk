import 'package:equatable/equatable.dart';

class FeedModel extends Equatable {
  final int feedId;
  final int placeId;
  final int userId;
  final String content;
  final String writeTime;
  final List<CustomImage> images;
  final String nickname;

  const FeedModel({
    required this.feedId,
    required this.placeId,
    required this.userId,
    required this.content,
    required this.writeTime,
    required this.images,
    required this.nickname,
  });

  @override
  List<Object?> get props =>
      [feedId, placeId, userId, content, writeTime, images, nickname];

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonImages = json['images'];
    final List<CustomImage> images =
        jsonImages.map((imageJson) => CustomImage.fromJson(imageJson)).toList();

    return FeedModel(
      feedId: json['feed_id'],
      placeId: json['place_id'],
      userId: json['user_id'],
      content: json['content'],
      nickname: json['nickname'],
      writeTime: json['write_time'],
      images: images,
    );
  }
}

class CustomImage {
  final String imageId;
  final int order;

  CustomImage({
    required this.imageId,
    required this.order,
  });

  factory CustomImage.fromJson(Map<String, dynamic> json) {
    return CustomImage(
      imageId: json['image_id'],
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_id': imageId,
      'order': order,
    };
  }
}
