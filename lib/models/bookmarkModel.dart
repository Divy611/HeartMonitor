class BookmarkModel {
  String key;
  String postId;
  String createdAt;
  BookmarkModel({
    required this.key,
    required this.postId,
    required this.createdAt,
  });
  factory BookmarkModel.fromJson(Map<dynamic, dynamic> json) => BookmarkModel(
        key: json["postId"],
        postId: json["postId"],
        createdAt: json["created_at"],
      );
  Map<String, dynamic> toJson() => {
        "key": key,
        "postId": postId,
        "created_at": createdAt,
      };
}
