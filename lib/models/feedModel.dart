import 'package:heartmonitor/models/user.dart';
import 'package:heartmonitor/models/commentModel.dart';

class FeedModel {
  String? key;
  String? parentkey;
  String? childRepostkey;
  String? description;
  String? pollHeading;
  late String userId;
  int? likeCount;
  int? voteCount;
  int? option1Votes;
  int? option2Votes;
  int? option3Votes;
  int? option4Votes;
  int? commentLikeCount;
  List<String>? likeList;
  List<String>? commentLikeList;
  int? commentCount;
  int? replyCount;
  String? comment;
  String? reply;
  int? repostCount;
  late String createdAt;
  String? imagePath;
  List<String>? tags;
  List<CommentModel?>? comments;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  String? lanCode;
  Map<String, int>? votes;
  int? pollVoters;
  List<String>? option1Voters;
  List<String>? option2Voters;
  List<String>? option3Voters;
  List<String>? option4Voters;
  UserModel? user;
  FeedModel({
    this.key,
    this.description,
    this.pollHeading,
    required this.userId,
    this.likeCount,
    this.commentLikeCount,
    this.commentCount,
    this.voteCount,
    this.option1Votes,
    this.option2Votes,
    this.option3Votes,
    this.option4Votes,
    this.replyCount,
    this.repostCount,
    this.comment,
    this.reply,
    required this.createdAt,
    this.imagePath,
    this.likeList,
    this.commentLikeList,
    this.tags,
    this.user,
    this.comments,
    this.parentkey,
    this.lanCode,
    this.childRepostkey,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.pollVoters,
    this.option1Voters,
    this.option2Voters,
    this.option3Voters,
    this.option4Voters,
    this.votes,
  });
  toJson() {
    return {
      "userId": userId,
      "description": description,
      "pollHeading": pollHeading,
      "likeCount": likeCount,
      "commentLikeCount": commentLikeCount,
      "votes": votes ?? 0,
      //"commentCount": commentCount ?? 0,
      "commentCount": comments?.length,
      "replyCount": replyCount ?? 0,
      "repostCount": repostCount ?? 0,
      "voteCount": voteCount ?? 0,
      "option1Votes": option1Votes ?? 0,
      "option2Votes": option2Votes ?? 0,
      "option3Votes": option3Votes ?? 0,
      "option4Votes": option4Votes ?? 0,
      "createdAt": createdAt,
      "imagePath": imagePath,
      "likeList": likeList,
      "pollVotersList": pollVoters ?? 0,
      "option1voters": option1Voters,
      "option2Voters": option2Voters,
      "option3Voters": option3Voters,
      "option4Voters": option4Voters,
      "commentLikeList": commentLikeList,
      "comment": comment,
      "reply": reply,
      "tags": tags,
      "comments": comments,
      "user": user?.toJson(),
      "parentkey": parentkey,
      "lanCode": lanCode,
      "childRepostkey": childRepostkey,
      "firstoption": option1,
      "secondoption": option2,
      "thirdoption": option3,
      "fourthoption": option4,
    };
  }

  FeedModel.fromJson(Map<dynamic, dynamic> map) {
    key = map['key'];
    description = map['description'];
    pollHeading = map['pollHeading'];
    option1 = map['firstoption'];
    option2 = map['secondoption'];
    option3 = map['thirdoption'];
    option4 = map['fourthoption'];
    userId = map['userId'];
    likeCount = map['likeCount'] ?? 0;
    voteCount = map['voteCount'] ?? 0;
    option1Votes = map['option1Votes'] ?? 0;
    option2Votes = map['option2Votes'] ?? 0;
    option3Votes = map['option3Votes'] ?? 0;
    option4Votes = map['option4Votes'] ?? 0;
    pollVoters = map['pollVoters'] ?? 0;
    repostCount = map["repostCount"] ?? 0;
    imagePath = map['imagePath'];
    createdAt = map['createdAt'];
    imagePath = map['imagePath'];
    comment = map['comment'];
    reply = map['reply'];
    commentCount = map['commentCount'] ?? 0;
    replyCount = map['replyCount'] ?? 0;
    lanCode = map['lanCode'];
    user = UserModel.fromJson(map['user']);
    parentkey = map['parentkey'];
    childRepostkey = map['childRepostkey'];
    if (map['tags'] != null) {
      tags = <String>[];
      map['tags'].forEach(
        (value) {
          tags!.add(value);
        },
      );
    }
    if (map["option1Voters"] != null) {
      option1Voters = <String>[];
      final list = map['option1Voters'];
      if (list is List<String>) {
        map['option1Voters'].forEach(
          (value) {
            if (value is String) {
              option1Voters!.add(value);
            }
          },
        );
        option1Votes = option1Voters!.length;
      } else if (list is Map) {
        list.forEach(
          (key, value) {
            option1Voters!.add(value["userId"]);
          },
        );
        option1Votes = list.length;
      }
    } else {
      option1Voters = [];
      option1Votes = 0;
    }
    if (map["option2Voters"] != null) {
      option2Voters = <String>[];
      final list = map['option2Voters'];
      if (list is List<String>) {
        map['option2Voters'].forEach(
          (value) {
            if (value is String) {
              option2Voters!.add(value);
            }
          },
        );
        option2Votes = option2Voters!.length;
      } else if (list is Map) {
        list.forEach(
          (key, value) {
            option2Voters!.add(value["userId"]);
          },
        );
        option2Votes = list.length;
      }
    } else {
      option2Voters = [];
      option2Votes = 0;
    }
    if (map["option3Voters"] != null) {
      option3Voters = <String>[];
      final list = map['option3Voters'];
      if (list is List<String>) {
        map['option3Voters'].forEach(
          (value) {
            if (value is String) {
              option3Voters!.add(value);
            }
          },
        );
        option3Votes = option3Voters!.length;
      } else if (list is Map) {
        list.forEach(
          (key, value) {
            option3Voters!.add(value["userId"]);
          },
        );
        option3Votes = list.length;
      }
    } else {
      option3Voters = [];
      option3Votes = 0;
    }
    if (map["option4Voters"] != null) {
      option4Voters = <String>[];
      final list = map['option4Voters'];
      if (list is List<String>) {
        map['option4Voters'].forEach(
          (value) {
            if (value is String) {
              option4Voters!.add(value);
            }
          },
        );
        option4Votes = option4Voters!.length;
      } else if (list is Map) {
        list.forEach(
          (key, value) {
            option4Voters!.add(value["userId"]);
          },
        );
        option4Votes = list.length;
      }
    } else {
      option4Voters = [];
      option4Votes = 0;
    }
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
    if (map["commentLikeList"] != null) {
      commentLikeList = <String>[];
      final list1 = map['commentLikeList'];
      if (list1 is List) {
        map['commentLikeList'].forEach(
          (value) {
            if (value is String) {
              commentLikeList!.add(value);
            }
          },
        );
        commentLikeCount = commentLikeList!.length;
      } else if (list1 is Map) {
        list1.forEach(
          (key, value) {
            commentLikeList!.add(value["userId"]);
          },
        );
        commentLikeCount = list1.length;
      }
    } else {
      commentLikeList = [];
      commentLikeCount = 0;
    }
    if (map["comments"] != null) {
      comments = <CommentModel>[];
      final list = map['comments'];
      if (list is List<CommentModel>) {
        map['comments'].forEach(
          (value) {
            if (value is CommentModel) {
              comments!.add(value);
            }
          },
        );
        commentCount = comments!.length;
      } else if (list is Map) {
        list.forEach(
          (key, value) {
            comments!.add(
              CommentModel(
                userId: value['userId'],
                comment: value['comment'],
                createdAt: value['createdAt'],
                imagePath: value['imagePath'],
                parentkey: value['parentkey'],
              ),
            );
          },
        );
        commentCount = list.length;
      }
    } else {
      comments = [];
      commentCount = 0;
    }
  }

  bool get isValidTweet {
    bool isValid = false;
    if (user != null && user!.userName != null && user!.userName!.isNotEmpty) {
      isValid = true;
    } else {}
    return isValid;
  }

  String get getPostKeyToRepost {
    if (description == null &&
        pollHeading == null &&
        imagePath == null &&
        childRepostkey != null) {
      return childRepostkey!;
    } else {
      return key!;
    }
  }
}
