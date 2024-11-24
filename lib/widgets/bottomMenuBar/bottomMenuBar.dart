import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heartmonitor/state/appState.dart';
import 'package:heartmonitor/widgets/bottomMenuBar/tabItem.dart';
import 'package:provider/provider.dart';
import '../customWidgets.dart';
import 'package:heartmonitor/ui/theme/theme.dart';

class BottomMenubar extends StatefulWidget {
  const BottomMenubar({super.key});
  @override
  _BottomMenubarState createState() => _BottomMenubarState();
}

class _BottomMenubarState extends State<BottomMenubar> {
  @override
  void initState() {
    super.initState();
  }

  void onTapNew(BuildContext context, double height, Widget child) async {
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: height,
          decoration: BoxDecoration(
            color: Colorpallete.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: child,
        );
      },
    );
  }

  void choiceList(BuildContext context) {
    onTapNew(
      context,
      100,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 5),
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Colorpallete.paleSky50,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, bottom: 7.5),
                  child: TextButton(
                    child: Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.plus,
                            color: Colors.black,
                          ),
                          SizedBox(width: 15),
                          Text(
                            "Take a New Reading",
                            style: GoogleFonts.montserrat(
                              fontSize: 17.5,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _iconList() {
    var state = Provider.of<AppState>(
      context,
    );
    return Container(
      height: 60,
      decoration: BoxDecoration(color: Colors.white),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          onPressed: () {
            choiceList(context);
          },
          backgroundColor: AppColor.primary,
          child: customIcon(
            context,
            icon: FontAwesomeIcons.plus,
            isIcon: true,
            iconColor: Colors.white,
            size: 25,
            paddingIcon: 3,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(),
          notchMargin: 5,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _icon(
                null,
                0,
                icon: 0 == state.pageIndex
                    ? FontAwesomeIcons.house
                    : FontAwesomeIcons.house,
                isCustomIcon: true,
              ),
              _icon(
                null,
                1,
                icon: 1 == state.pageIndex
                    ? FontAwesomeIcons.bookOpen
                    : FontAwesomeIcons.book,
                isCustomIcon: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _icon(IconData? iconData, int index,
      {bool isCustomIcon = false, IconData? icon}) {
    if (isCustomIcon) {
      assert(icon != null);
    } else {
      assert(iconData != null);
    }
    var state = Provider.of<AppState>(
      context,
    );
    return Expanded(
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: AnimatedAlign(
          duration: Duration(milliseconds: ANIM_DURATION),
          curve: Curves.easeIn,
          alignment: Alignment(0, ICON_ON),
          child: AnimatedOpacity(
            duration: Duration(milliseconds: ANIM_DURATION),
            opacity: ALPHA_ON,
            child: IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              padding: EdgeInsets.all(0),
              alignment: Alignment(0, 0),
              icon: isCustomIcon
                  ? customIcon(
                      context,
                      icon: icon!,
                      size: 22,
                      isIcon: true,
                      isEnable: index == state.pageIndex,
                    )
                  : Icon(
                      iconData,
                      color: index == state.pageIndex
                          ? AppColor.primary
                          // ? Theme.of(context).primaryColor
                          : Theme.of(context).textTheme.bodySmall!.color,
                    ),
              onPressed: () {
                setState(
                  () {
                    state.setPageIndex = index;
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _iconList();
  }
}
