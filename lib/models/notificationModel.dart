import 'dart:convert';
import 'package:heartmonitor/models/user.dart';

class NotificationModel {
  String? id;
  String? tweetKey;
  String? updatedAt;
  String? createdAt;
  late String? type;
  Map<String, dynamic>? data;
  NotificationModel({
    this.id,
    this.tweetKey,
    required this.type,
    required this.createdAt,
    this.updatedAt,
    required this.data,
  });
  NotificationModel.fromJson(String postId, Map<dynamic, dynamic> map) {
    id = postId;
    Map<String, dynamic> data = {};
    if (map.containsKey('data')) {
      data = json.decode(json.encode(map["data"])) as Map<String, dynamic>;
    }
    tweetKey = postId;
    updatedAt = map["updatedAt"];
    type = map["type"];
    createdAt = map["createdAt"];
    this.data = data;
  }
}

extension NotificationModelHelper on NotificationModel {
  UserModel get user => UserModel.fromJson(data);
  DateTime? get timeStamp => updatedAt != null || createdAt != null
      ? DateTime.tryParse(updatedAt ?? createdAt!)
      : null;
}
