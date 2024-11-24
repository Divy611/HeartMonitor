import 'package:flutter/foundation.dart';
import 'package:heartmonitor/models/user.dart';

class CommentModel {
  String? key;
  String? parentkey;
  late String userId;
  int? likeCount;
  List<String>? likeList;
  late String? comment;
  late String createdAt;
  String? imagePath;
  List<String>? tags;
  UserModel? user;
  String? reply;
  int? replyCount;
  List<CommentReplyModel>? replies;
  CommentModel({
    this.key,
    required this.userId,
    this.likeCount,
    this.comment,
    required this.createdAt,
    this.likeList,
    this.tags,
    this.user,
    this.imagePath,
    this.parentkey,
    this.replies,
    this.reply,
    this.replyCount,
  });
  toJson() {
    return {
      "userId": userId,
      "likeCount": likeCount,
      "createdAt": createdAt,
      "imagePath": imagePath,
      "likeList": likeList,
      "comment": comment,
      "tags": tags,
      "user": user?.toJson(),
      "parentkey": parentkey,
      "reply": reply,
      "replyCount": replyCount,
      "replies": replies,
    };
  }

  CommentModel.fromJson(Map<dynamic, dynamic> map) {
    key = map['key'];
    userId = map['userId'];
    likeCount = map['likeCount'] ?? 0;
    replyCount = map['replyCount'] ?? 0;
    imagePath = map['imagePath'];
    createdAt = map['createdAt'];
    imagePath = map['imagePath'];
    comment = map['comment'];
    user = UserModel.fromJson(map['user']);
    parentkey = map['parentkey'];
    if (map["likeList"] != null) {
      likeList = <String>[];
      final list = map['likeList'];
      if (list is List) {
        map['likeList'].forEach(
          (value) {
            if (value is String) {
              likeList!.add(value);
            }
          },
        );
        likeCount = likeList!.length;
      } else if (list is Map) {
        list.forEach(
          (key, value) {
            likeList!.add(value["userId"]);
          },
        );
        likeCount = list.length;
      }
    } else {
      likeList = [];
      likeCount = 0;
    }
    if (map["replies"] != null) {
      replies = <CommentReplyModel>[];
      final list = map['replies'];
      if (list is List<CommentReplyModel>) {
        map['replies'].forEach(
          (value) {
            if (value is CommentReplyModel) {
              replies!.add(value);
            }
          },
        );
        replyCount = replies!.length;
      } else if (list is Map) {
        list.forEach(
          (key, value) {
            replies!.add(
              CommentReplyModel(
                userId: value['userId'],
                reply: value['reply'],
                createdAt: value['createdAt'],
                imagePath: value['imagePath'],
                parentkey: value['parentkey'],
              ),
            );
          },
        );
        replyCount = list.length;
      }
    } else {
      replies = [];
      replyCount = 0;
    }
  }

  bool get isValidComment {
    bool isValid = false;
    if (user != null && user!.userName != null && user!.userName!.isNotEmpty) {
      isValid = true;
    } else {
      if (kDebugMode) print("Invalid Comment found. Id:- $key");
    }
    return isValid;
  }
}

class CommentReplyModel {
  String? key;
  String? parentkey;
  late String userId;
  int? likeCount;
  List<String>? likeList;
  late String createdAt;
  String? imagePath;
  List<String>? tags;
  UserModel? user;
  String? reply;
  int? replyCount;
  CommentReplyModel({
    this.key,
    required this.userId,
    this.likeCount,
    required this.createdAt,
    this.likeList,
    this.tags,
    this.user,
    this.imagePath,
    this.parentkey,
    this.reply,
    this.replyCount,
  });
  toJson() {
    return {
      "userId": userId,
      "likeCount": likeCount,
      "createdAt": createdAt,
      "imagePath": imagePath,
      "likeList": likeList,
      "tags": tags,
      "user": user?.toJson(),
      "parentkey": parentkey,
      "reply": reply,
      "replyCount": replyCount,
    };
  }

  CommentReplyModel.fromJson(Map<dynamic, dynamic> map) {
    key = map['key'];
    userId = map['userId'];
    likeCount = map['likeCount'] ?? 0;
    replyCount = map['replyCount'] ?? 0;
    imagePath = map['imagePath'];
    createdAt = map['createdAt'];
    imagePath = map['imagePath'];
    user = UserModel.fromJson(map['user']);
    parentkey = map['parentkey'];
    if (map["likeList"] != null) {
      likeList = <String>[];
      final list = map['likeList'];
      if (list is List) {
        map['likeList'].forEach(
          (value) {
            if (value is String) {
              likeList!.add(value);
            }
          },
        );
        likeCount = likeList!.length;
      } else if (list is Map) {
        list.forEach(
          (key, value) {
            likeList!.add(value["userId"]);
          },
        );
        likeCount = list.length;
      }
    } else {
      likeList = [];
      likeCount = 0;
    }
  }

  bool get isValidReply {
    bool isValid = false;
    if (user != null && user!.userName != null && user!.userName!.isNotEmpty) {
      isValid = true;
    }
    return isValid;
  }
}
