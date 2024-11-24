import 'dart:io'; // ignore_for_file: unused_import
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:heartmonitor/models/user.dart';
import 'package:heartmonitor/state/appState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:heartmonitor/navigator/values.dart';
import 'package:heartmonitor/navigator/utility.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:heartmonitor/ui/pages/common/locator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart' as db;
import 'package:heartmonitor/navigator/shared_prefrence_helper.dart';

class AuthState extends AppState {
  User? user;
  late String userId;
  UserModel? _userModel;
  db.Query? _profileQuery;
  bool isSignInWithGoogle = false;
  UserModel? get userModel => _userModel;
  UserModel? get profileUserModel => _userModel;
  AuthStatus authStatus = AuthStatus.NOT_DETERMINED;
  //final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void logoutCallback() async {
    authStatus = AuthStatus.NOT_LOGGED_IN;
    userId = '';
    _userModel = null;
    user = null;
    _profileQuery!.onValue.drain();
    _profileQuery = null;
    //if (isSignInWithGoogle) {
    //  _googleSignIn.signOut();
    //  Utility.logEvent('google_logout', parameter: {});
    //  isSignInWithGoogle = false;
    //}
    _firebaseAuth.signOut();
    notifyListeners();
    await getIt<SharedPreferenceHelper>().clearPreferenceValues();
  }

  void openSignUpPage() {
    authStatus = AuthStatus.NOT_LOGGED_IN;
    userId = '';
    notifyListeners();
  }

  void databaseInit() {
    try {
      if (_profileQuery == null) {
        _profileQuery = userDatabase.child("profile").child(user!.uid);
        _profileQuery!.onValue.listen(_onProfileChanged);
        _profileQuery!.onChildChanged.listen(_onProfileUpdated);
      }
    } catch (error) {
      cprint(error, errorIn: 'databaseInit');
    }
  }

  Future<String?> signIn(String email, String password,
      {required BuildContext context}) async {
    try {
      isBusy = true;
      var result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = result.user;
      userId = user!.uid;
      return user!.uid;
    } on FirebaseException catch (error) {
      if (error.code == 'firebase_auth/user-not-found') {
        Utility.customSnackBar(context, 'User not found');
      } else {
        Utility.customSnackBar(
          context,
          error.message ?? 'Something went wrong',
        );
      }
      cprint(error, errorIn: 'signIn');
      return null;
    } catch (error) {
      Utility.customSnackBar(context, error.toString());
      cprint(error, errorIn: 'signIn');
      return null;
    } finally {
      isBusy = false;
    }
  }

  void createUserFromGoogleSignIn(User user) {
    var diff = DateTime.now().difference(user.metadata.creationTime!);
    if (diff < const Duration(seconds: 15)) {
      UserModel model = UserModel(
        bio: 'Edit profile to update bio',
        dob: DateTime(1950, DateTime.now().month, DateTime.now().day + 3)
            .toString(),
        location: 'Somewhere in universe',
        profilePic: user.photoURL!,
        displayName: user.displayName!,
        email: user.email!,
        key: user.uid,
        userId: user.uid,
        contact: user.phoneNumber!,
        isVerified: user.emailVerified,
      );
      createUser(model, newUser: true);
    } else {
      cprint('Last login at: ${user.metadata.lastSignInTime}');
    }
  }

  Future<String?> signUp(UserModel userModel,
      {required BuildContext context, required String password}) async {
    try {
      isBusy = true;
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: userModel.email!,
        password: password,
      );
      user = result.user;
      authStatus = AuthStatus.LOGGED_IN;
      //userAnalytics.logSignUp(signUpMethod: 'register');
      result.user!.updateDisplayName(userModel.displayName);
      result.user!.updatePhotoURL(userModel.profilePic);
      _userModel = userModel;
      _userModel!.key = user!.uid;
      _userModel!.userId = user!.uid;
      createUser(_userModel!, newUser: true);
      return user!.uid;
    } catch (error) {
      isBusy = false;
      cprint(error, errorIn: 'signUp');
      Utility.customSnackBar(context, error.toString());
      return null;
    }
  }

  void createUser(UserModel user, {bool newUser = false}) {
    if (newUser) {
      user.userName = Utility.getUserName(
        id: user.userId!,
        name: user.displayName!,
      );
      //userAnalytics.logEvent(name: 'create_newUser');
      user.createdAt = DateTime.now().toUtc().toString();
    }
    userDatabase.child('profile').child(user.userId!).set(user.toJson());
    _userModel = user;
    isBusy = false;
  }

  Future<User?> getCurrentUser() async {
    try {
      isBusy = true;
      Utility.logEvent('get_currentUSer', parameter: {});
      user = _firebaseAuth.currentUser;
      if (user != null) {
        await getProfileUser();
        authStatus = AuthStatus.LOGGED_IN;
        userId = user!.uid;
      } else {
        authStatus = AuthStatus.NOT_LOGGED_IN;
      }
      isBusy = false;
      return user;
    } catch (error) {
      isBusy = false;
      cprint(error, errorIn: 'getCurrentUser');
      authStatus = AuthStatus.NOT_LOGGED_IN;
      return null;
    }
  }

  void reloadUser() async {
    await user!.reload();
    user = _firebaseAuth.currentUser;
    if (user!.emailVerified) {
      userModel!.isVerified = true;
      createUser(userModel!);
      Utility.logEvent(
        'email_verification_complete',
        parameter: {userModel!.userName!: user!.email},
      );
    }
  }

  Future<void> sendEmailVerification(BuildContext context) async {
    User user = _firebaseAuth.currentUser!;
    user.sendEmailVerification().then(
      (_) {
        Utility.logEvent(
          'email_verification_sent',
          parameter: {userModel!.displayName!: user.email},
        );
        Utility.customSnackBar(
          context,
          'An email verification link is send to your email.',
        );
      },
    ).catchError(
      (error) {
        cprint(error.message, errorIn: 'sendEmailVerification');
        Utility.logEvent(
          'email_verification_block',
          parameter: {userModel!.displayName!: user.email},
        );
        Utility.customSnackBar(context, error.message);
      },
    );
  }

  Future<bool> emailVerified() async {
    User user = _firebaseAuth.currentUser!;
    return user.emailVerified;
  }

  Future<void> forgetPassword(String email,
      {required BuildContext context}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email).then(
        (value) {
          Utility.customSnackBar(context,
              'A reset password link is sent yo your mail.You can reset your password from there');
          Utility.logEvent('forgot+password', parameter: {});
        },
      ).catchError(
        (error) {
          cprint(error.message);
        },
      );
    } catch (error) {
      Utility.customSnackBar(context, error.toString());
      //return Future.value(false);
    }
  }

  Future<void> updateUserProfile(UserModel? userModel,
      {File? image, File? bannerImage}) async {
    try {
      if (image == null && bannerImage == null) {
        createUser(userModel!);
      } else {
        if (image != null) {}
        if (bannerImage != null) {}
        if (userModel != null) {
          createUser(userModel);
        } else {
          createUser(_userModel!);
        }
      }
      Utility.logEvent('update_user');
    } catch (error) {
      cprint(error, errorIn: 'updateUserProfile');
    }
  }

  Future<UserModel?> getUserDetail(String userId) async {
    UserModel user;
    var event = await userDatabase.child('profile').child(userId).once();

    final map = event.snapshot.value as Map?;
    if (map != null) {
      user = UserModel.fromJson(map);
      user.key = event.snapshot.key!;
      return user;
    } else {
      return null;
    }
  }

  FutureOr<void> getProfileUser({String? userProfileId}) {
    try {
      userProfileId = userProfileId ?? user!.uid;
      userDatabase.child("profile").child(userProfileId).once().then(
        (DatabaseEvent event) async {
          final snapshot = event.snapshot;
          if (snapshot.value != null) {
            var map = snapshot.value as Map<dynamic, dynamic>?;
            if (map != null) {
              if (userProfileId == user!.uid) {
                _userModel = UserModel.fromJson(map);
                _userModel!.isVerified = user!.emailVerified;
                if (!user!.emailVerified) {
                  reloadUser();
                }
                if (_userModel!.fcmToken == null) {
                  updateFCMToken();
                }
                getIt<SharedPreferenceHelper>().saveUserProfile(_userModel!);
              }
              Utility.logEvent('get_profile', parameter: {});
            }
          }
          isBusy = false;
        },
      );
    } catch (error) {
      isBusy = false;
      cprint(error, errorIn: 'getProfileUser');
    }
  }

  void updateFCMToken() {
    if (_userModel == null) {
      return;
    }
    getProfileUser();
    _firebaseMessaging.getToken().then((String? token) {
      assert(token != null);
      _userModel!.fcmToken = token;
      createUser(_userModel!);
    });
  }

  void _onProfileChanged(DatabaseEvent event) {
    final val = event.snapshot.value;
    if (val is Map) {
      final updatedUser = UserModel.fromJson(val);
      _userModel = updatedUser;
      cprint('UserModel Updated');
      getIt<SharedPreferenceHelper>().saveUserProfile(_userModel!);
      notifyListeners();
    }
  }

  void _onProfileUpdated(DatabaseEvent event) {
    final val = event.snapshot.value;
    if (val is List &&
        ['following', 'followers'].contains(event.snapshot.key)) {
      final list = val.cast<String>().map((e) => e).toList();
      if (event.previousChildKey == 'following') {
        _userModel = _userModel!.copyWith(
          followingList: val.cast<String>().map((e) => e).toList(),
          following: list.length,
        );
      } else if (event.previousChildKey == 'followers') {
        _userModel = _userModel!.copyWith(
          followersList: list,
          followers: list.length,
        );
      }
      getIt<SharedPreferenceHelper>().saveUserProfile(_userModel!);
      notifyListeners();
    }
  }
}
