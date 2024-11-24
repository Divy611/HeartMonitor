import '../customWidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heartmonitor/ui/theme/theme.dart';

const double ICON_OFF = -3;
const double ICON_ON = 0;
const double TEXT_OFF = 5;
const double TEXT_ON = 1;
const double ALPHA_OFF = 0;
const double ALPHA_ON = 1;
const int ANIM_DURATION = 200;

class TabItem extends StatelessWidget {
  const TabItem(
      {super.key,
      required this.uniqueKey,
      required this.selected,
      required this.iconData,
      required this.title,
      required this.callbackFunction,
      required this.textColor,
      required this.iconColor,
      required this.isCustomIcon,
      this.customIconCode});
  final UniqueKey uniqueKey;
  final String title;
  final IconData iconData;
  final bool selected;
  final Function(UniqueKey uniqueKey) callbackFunction;
  final Color textColor;
  final Color iconColor;
  final bool isCustomIcon;
  final IconData? customIconCode;
  final double iconYAlign = ICON_ON;
  final double textYAlign = TEXT_OFF;
  final double iconAlpha = ALPHA_ON;
  @override
  Widget build(BuildContext context) {
    if (isCustomIcon) assert(customIconCode != null);
    return Expanded(
      child: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: AnimatedAlign(
                duration: const Duration(milliseconds: ANIM_DURATION),
                alignment: Alignment(0, (selected) ? TEXT_ON : TEXT_OFF),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        color: textColor,
                        fontSize: context.getDimension(context, 12)),
                  ),
                )),
          ),
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: AnimatedAlign(
              duration: const Duration(milliseconds: ANIM_DURATION),
              curve: Curves.easeIn,
              alignment: Alignment(0, (selected) ? ICON_OFF : ICON_ON),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: ANIM_DURATION),
                opacity: (selected) ? ALPHA_OFF : ALPHA_ON,
                child: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  padding: const EdgeInsets.all(0),
                  alignment: const Alignment(0, 0),
                  icon: isCustomIcon
                      ? customIcon(context, icon: customIconCode!)
                      : Icon(
                          iconData,
                          color: Colors.amber[700],
                        ),
                  onPressed: () {
                    callbackFunction(uniqueKey);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
