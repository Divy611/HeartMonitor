import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class UserModel extends Equatable {
  String? key;
  String? email;
  String? phone;
  String? userId;
  String? displayName;
  String? userName;
  String? webSite;
  String? profilePic;
  String? bannerImage;
  String? contact;
  String? bio;
  String? location;
  String? profession;
  String? dob;
  String? createdAt;
  bool? isVerified;
  int? followers;
  int? following;
  int? communities;
  String? fcmToken;
  List<String>? followersList;
  List<String>? followingList;
  List<String>? communityList;
  UserModel({
    this.email,
    this.phone,
    this.userId,
    this.displayName,
    this.profilePic,
    this.bannerImage,
    this.key,
    this.contact,
    this.bio,
    this.dob,
    this.location,
    this.profession,
    this.createdAt,
    this.userName,
    this.followers,
    this.following,
    this.communities,
    this.webSite,
    this.isVerified,
    this.fcmToken,
    this.followersList,
    this.followingList,
    this.communityList,
  });
  UserModel.fromJson(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return;
    }
    followersList ??= [];
    email = map['email'];
    phone = map['phone'];
    userId = map['userId'];
    displayName = map['displayName'];
    profilePic = map['profilePic'];
    bannerImage = map['bannerImage'];
    key = map['key'];
    dob = map['dob'];
    bio = map['bio'];
    location = map['location'];
    profession = map['profession'];
    contact = map['contact'];
    createdAt = map['createdAt'];
    followers = map['followers'];
    communities = map['communities'];
    following = map['following'];
    userName = map['userName'];
    webSite = map['webSite'];
    fcmToken = map['fcmToken'];
    isVerified = map['isVerified'] ?? false;
    if (map['followerList'] != null) {
      followersList = <String>[];
      map['followerList'].forEach(
        (value) {
          followersList!.add(value);
        },
      );
    }
    followers = followersList?.length;
    if (map['followingList'] != null) {
      followingList = <String>[];
      map['followingList'].forEach(
        (value) {
          followingList!.add(value);
        },
      );
    }
    following = followingList?.length;
    if (map['communityList'] != null) {
      communityList = <String>[];
      map['communityList'].forEach(
        (value) {
          communityList!.add(value);
        },
      );
    }
    communities = communityList?.length;
  }
  toJson() {
    return {
      'key': key,
      "userId": userId,
      "email": email,
      "phone": phone,
      'displayName': displayName,
      'profilePic': profilePic,
      'bannerImage': bannerImage,
      'contact': contact,
      'dob': dob,
      'bio': bio,
      'location': location,
      'profession': profession,
      'createdAt': createdAt,
      'followers': followersList?.length,
      'following': followingList?.length,
      'communities': communityList?.length,
      'userName': userName,
      'webSite': webSite,
      'isVerified': isVerified ?? false,
      'fcmToken': fcmToken,
      'followerList': followersList,
      'followingList': followingList,
      'communityList': communityList,
    };
  }

  UserModel copyWith({
    String? email,
    String? phone,
    String? userId,
    String? displayName,
    String? profilePic,
    String? key,
    String? contact,
    String? bio,
    String? dob,
    String? bannerImage,
    String? location,
    String? profession,
    String? createdAt,
    String? userName,
    int? followers,
    int? following,
    String? webSite,
    bool? isVerified,
    String? fcmToken,
    List<String>? followingList,
    List<String>? followersList,
    List<String>? communityList,
  }) {
    return UserModel(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      bio: bio ?? this.bio,
      contact: contact ?? this.contact,
      createdAt: createdAt ?? this.createdAt,
      displayName: displayName ?? this.displayName,
      dob: dob ?? this.dob,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      isVerified: isVerified ?? this.isVerified,
      key: key ?? this.key,
      location: location ?? this.location,
      profession: profession ?? this.profession,
      profilePic: profilePic ?? this.profilePic,
      bannerImage: bannerImage ?? this.bannerImage,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      webSite: webSite ?? this.webSite,
      fcmToken: fcmToken ?? this.fcmToken,
      followersList: followersList ?? this.followersList,
      followingList: followingList ?? this.followingList,
      communityList: communityList ?? this.communityList,
    );
  }

  String get getFollowers {
    return '${followers ?? 0}';
  }

  String get getFollowing {
    return '${following ?? 0}';
  }

  String get getCommunities {
    return '${following ?? 0}';
  }

  @override
  List<Object?> get props => [
        key,
        email,
        phone,
        userId,
        displayName,
        userName,
        webSite,
        profilePic,
        bannerImage,
        contact,
        bio,
        location,
        profession,
        dob,
        createdAt,
        isVerified,
        followers,
        following,
        fcmToken,
        followersList,
        followingList,
        communityList,
      ];
}
