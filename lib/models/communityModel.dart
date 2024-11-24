import 'package:heartmonitor/models/feedModel.dart';
import 'package:heartmonitor/models/user.dart';

class CommunityModel {
  List<String>? users;
  UserModel? creator;
  List<FeedModel>? posts;
  FeedModel? post;
  String? name;
  String? description;
  String? key;
  int? userCount;
  String? parentkey;
  late String createdAt;
  String? displayPic;
  String? bannerImage;
  CommunityModel({
    this.users,
    this.creator,
    this.posts,
    this.key,
    this.userCount,
    this.name,
    this.description,
    this.parentkey,
    required this.createdAt,
    this.displayPic,
    this.bannerImage,
  });
  toJson() {
    return {
      "user": creator?.toJson(),
      "post": post?.toJson(),
      'userCount': users?.length,
      "name": name,
      "description": description,
      "parentkey": parentkey,
      'displayPic': displayPic,
      'bannerImage': bannerImage,
    };
  }

  CommunityModel.fromJson(Map<dynamic, dynamic> map) {
    key = map['key'];
    name = map['name'];
    description = map['description'];
    userCount = map['userCount'] ?? 0;
    parentkey = map['parentkey'];
    displayPic = map['displayPic'];
    bannerImage = map['bannerImage'];
  }
  bool get isValid {
    bool isValid = false;
    if (creator != null &&
        creator!.userName != null &&
        creator!.userName!.isNotEmpty) {
      isValid = true;
    } else {}
    return isValid;
  }

  String get getUserCount {
    return '${userCount ?? 0}';
  }
}
