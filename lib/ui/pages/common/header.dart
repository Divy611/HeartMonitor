import 'package:flutter/material.dart';
import 'package:heartmonitor/widgets/circularImage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Function? onActionPressed;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  const Header(
      {super.key, this.scaffoldKey, this.onActionPressed, required this.title});
  final Size appBarHeight = const Size.fromHeight(57);
  @override
  Size get preferredSize => appBarHeight;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        child: TextButton(
          onPressed: () {
            scaffoldKey!.currentState!.openDrawer();
          },
          child: CircularImage(path: 'assets/prof.png', height: 35),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            color: Colors.black,
            FontAwesomeIcons.comment,
          ),
        )
      ],
    );
  }
}
