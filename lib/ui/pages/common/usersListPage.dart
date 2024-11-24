import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heartmonitor/models/user.dart';
import 'package:heartmonitor/ui/theme/theme.dart';

class UsersListPage extends StatelessWidget {
  const UsersListPage({
    super.key,
    this.pageTitle = "",
    required this.emptyScreenText,
    required this.emptyScreenSubTileText,
    this.userIdsList,
    this.onFollowPressed,
    this.isFollowing,
  });
  final String pageTitle;
  final String emptyScreenText;
  final String emptyScreenSubTileText;
  final bool Function(UserModel user)? isFollowing;
  final List<String>? userIdsList;
  final Function(UserModel user)? onFollowPressed;

  @override
  Widget build(BuildContext context) {
    //List<UserModel>? userList;
    return Scaffold(
      backgroundColor: Colorpallete.mystic,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          pageTitle,
          style: GoogleFonts.montserrat(color: Colors.black),
        ),
      ),
      //body: Consumer<SearchState>(
      //  builder: (context, state, child) {
      //    if (userIdsList != null && userIdsList!.isNotEmpty) {
      //      userList = state.getuserDetail(userIdsList!);
      //    }
      //    return userList != null && userList!.isNotEmpty
      //        ? UserListWidget(
      //            list: userList!,
      //            emptyScreenText: emptyScreenText,
      //            emptyScreenSubTileText: emptyScreenSubTileText,
      //            onFollowPressed: onFollowPressed,
      //            isFollowing: isFollowing,
      //          )
      //        : Container(
      //            width: context.width,
      //            padding: EdgeInsets.only(top: 0, left: 30, right: 30),
      //            child: NotifyText(
      //              title: emptyScreenText,
      //              subTitle: emptyScreenSubTileText,
      //            ),
      //          );
      //  },
      //),
    );
  }
}
