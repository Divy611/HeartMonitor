import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heartmonitor/models/user.dart';
import 'package:heartmonitor/state/authState.dart';
import 'package:heartmonitor/ui/theme/theme.dart';
import 'package:heartmonitor/widgets/customWidgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heartmonitor/widgets/newWidget/rippleButton.dart';
import 'package:heartmonitor/widgets/newWidget/title_text.dart';
import 'package:provider/provider.dart';

class UserListWidget extends StatelessWidget {
  final List<UserModel> list;
  final String? emptyScreenText;
  final String? emptyScreenSubTileText;
  final Function(UserModel user)? onFollowPressed;
  final bool Function(UserModel user)? isFollowing;
  const UserListWidget({
    super.key,
    required this.list,
    this.emptyScreenText,
    this.emptyScreenSubTileText,
    this.onFollowPressed,
    this.isFollowing,
  });

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context, listen: false);
    final currentUser = state.userModel!;
    return ListView.separated(
      itemBuilder: (context, index) {
        return UserTile(
          user: list[index],
          currentUser: currentUser,
          isFollowing: isFollowing,
          onTrailingPressed: () {
            if (onFollowPressed != null) {
              onFollowPressed!(list[index]);
            }
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider(height: 0);
      },
      itemCount: list.length,
    );
    //:LinearProgressIndicator();
  }
}

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.user,
    required this.currentUser,
    required this.onTrailingPressed,
    this.trailing,
    this.isFollowing,
  });
  final UserModel user;
  final UserModel currentUser;
  final VoidCallback onTrailingPressed;
  final Widget? trailing;
  final bool Function(UserModel user)? isFollowing;
  String? getBio(String? bio) {
    if (bio != null && bio.isNotEmpty && bio != "Edit profile to update bio") {
      if (bio.length > 100) {
        bio = '${bio.substring(0, 100)}...';
        return bio;
      } else {
        return bio;
      }
    }
    return null;
  }

  bool checkIfFollowing() {
    if (isFollowing != null) {
      return isFollowing!(user);
    }
    if (currentUser.followingList != null &&
        currentUser.followingList!.any((x) => x == user.userId)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isFollow = checkIfFollowing();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      color: Colorpallete.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            onTap: () {},
            //leading: RippleButton(
            //  onPressed: () {},
            //  borderRadius: BorderRadius.all(Radius.circular(60)),
            //  child: CircularImage(path: user.profilePic, height: 55),
            //),
            title: Row(
              children: <Widget>[
                ConstrainedBox(
                  constraints:
                      BoxConstraints(minWidth: 0, maxWidth: context.width * .4),
                  child: TitleText(
                    user.displayName!,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 3),
                user.isVerified!
                    ? customIcon(
                        context,
                        icon: FontAwesomeIcons.circleCheck,
                        isIcon: true,
                        iconColor: AppColor.primary,
                        size: 13,
                        paddingIcon: 3,
                      )
                    : SizedBox(width: 0),
              ],
            ),
            subtitle: Text(user.userName!),
            trailing: RippleButton(
              onPressed: onTrailingPressed,
              splashColor: AppColor.primary,
              borderRadius: BorderRadius.circular(25),
              child: trailing ??
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: isFollow ? 15 : 20,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isFollow ? Colorpallete.primary : Colorpallete.white,
                      border: Border.all(color: Colorpallete.primary, width: 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      isFollow ? 'Following' : 'Follow',
                      style: GoogleFonts.montserrat(
                        color: isFollow ? Colorpallete.white : Colors.amber,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            ),
          ),
          getBio(user.bio) == null
              ? SizedBox.shrink()
              : Padding(
                  padding: EdgeInsets.only(left: 90),
                  child: Text(
                    getBio(user.bio)!,
                  ),
                )
        ],
      ),
    );
  }
}
