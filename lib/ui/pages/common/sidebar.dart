import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heartmonitor/ui/theme/theme.dart';
import 'package:heartmonitor/state/authState.dart';
import 'package:heartmonitor/navigator/constants.dart';
import 'package:heartmonitor/widgets/circularImage.dart';
import 'package:heartmonitor/widgets/customWidgets.dart';
import 'package:heartmonitor/ui/pages/Auth/welcomePage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heartmonitor/widgets/url_text/customUrlText.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key, this.scaffoldKey});
  final GlobalKey<ScaffoldState>? scaffoldKey;
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  Widget _menuHeader() {
    final state = context.watch<AuthState>();
    if (state.userModel == null) {
      return ConstrainedBox(
        constraints: BoxConstraints(minWidth: 200, minHeight: 100),
        child: Center(
          child: Text(
            'Login to continue',
            style: GoogleFonts.montserrat(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ).ripple(
        () {
          _logOut();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => WelcomePage()),
            ),
          );
        },
      );
    } else {
      return Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 15),
            Container(
              height: 57,
              width: 57,
              margin: EdgeInsets.only(left: 17, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(27),
                border: Border.all(width: 2, color: Colors.white),
                image: DecorationImage(
                  image: customAdvanceNetworkImage(
                    state.userModel!.profilePic ?? Constants.profp,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                //Navigator.push(
                //  context,
                //  ProfilePage.getRoute(profileId: state.userModel!.userId!),
                //);
              },
              title: Center(
                child: Row(
                  children: <Widget>[
                    UrlText(
                      text: state.userModel!.displayName ?? "",
                      style: TextStyles.onPrimaryTitleText.copyWith(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    state.userModel!.isVerified ?? false
                        ? customIcon(
                            context,
                            icon: FontAwesomeIcons.circleCheck,
                            isIcon: true,
                            iconColor: AppColor.primary,
                            size: 18,
                            paddingIcon: 3,
                          )
                        : SizedBox(width: 0),
                  ],
                ),
              ),
              subtitle: customText(
                state.userModel!.userName,
                style: TextStyles.onPrimarySubTitleText.copyWith(
                  fontSize: 15,
                  color: AppColor.darkGrey,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: () {
                  //var state = context.read<AuthState>();
                  //Navigator.push(
                  //  context,
                  //  ProfilePage.getRoute(profileId: state.userId),
                  //);
                },
                child: Row(
                  children: [
                    Text(
                      "View Profile",
                      style: GoogleFonts.montserrat(fontSize: 17),
                    ),
                    Icon(
                      FontAwesomeIcons.chevronRight,
                      size: 15,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  ListTile _menuListRowButton(String title,
      {Function? onPressed, IconData? icon, bool isEnable = false}) {
    return ListTile(
      onTap: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      leading: icon == null
          ? null
          : Padding(
              padding: EdgeInsets.only(top: 5),
              child: customIcon(
                context,
                icon: icon,
                size: 25,
                iconColor: isEnable ? Colors.black : AppColor.lightGrey,
              ),
            ),
      title: customText(
        title,
        style: GoogleFonts.montserrat(
          fontSize: 20,
          color: isEnable ? AppColor.secondary : AppColor.lightGrey,
        ),
      ),
    );
  }

  Positioned _footer() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        children: <Widget>[
          SizedBox(height: 6),
          Row(
            children: <Widget>[
              SizedBox(width: 10, height: 45),
              Spacer(),
              TextButton(
                onPressed: () {
                  //Navigator.push(
                  //  context,
                  //  ScanScreen.getRoute(
                  //    context.read<AuthState>().profileUserModel!,
                  //  ),
                  //);
                },
                child: Image.asset(
                  "assets/qr.png",
                  height: 25,
                ),
              ),
              SizedBox(
                width: 0,
                height: 45,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _logOut() {
    final state = Provider.of<AuthState>(context, listen: false);
    Navigator.pop(context);
    state.logoutCallback();
  }

  void _navigateTo(String path) {
    Navigator.pop(context);
    Navigator.of(context).pushNamed('/$path');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Container(child: _menuHeader()),
                  SizedBox(height: 30),
                  _menuListRowButton(
                    'Saved Readings',
                    icon: FontAwesomeIcons.bookmark,
                    isEnable: true,
                    onPressed: () {
                      //Navigator.push(
                      //  context,
                      //  BookmarkPage.getRoute(),
                      //);
                    },
                  ),
                  SizedBox(height: 30),
                  _menuListRowButton(
                    'Premium',
                    icon: FontAwesomeIcons.boltLightning,
                    isEnable: true,
                    onPressed: () {
                      _navigateTo('Premium');
                    },
                  ),
                  SizedBox(height: 30),
                  _menuListRowButton(
                    'Help Center',
                    icon: FontAwesomeIcons.handshake,
                    isEnable: true,
                    onPressed: () {
                      _navigateTo('Help');
                    },
                  ),
                  SizedBox(height: 30),
                  _menuListRowButton(
                    'Settings and privacy',
                    icon: FontAwesomeIcons.gear,
                    isEnable: true,
                    onPressed: () {
                      _navigateTo('SettingsAndPrivacyPage');
                    },
                  ),
                  SizedBox(height: 30),
                  _menuListRowButton(
                    'Logout',
                    icon: FontAwesomeIcons.arrowRightFromBracket,
                    onPressed: _logOut,
                    isEnable: true,
                  ),
                ],
              ),
            ),
            _footer()
          ],
        ),
      ),
    );
  }
}
