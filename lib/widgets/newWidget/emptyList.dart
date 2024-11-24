import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heartmonitor/ui/theme/theme.dart';

class EmptyList extends StatelessWidget {
  const EmptyList(this.title, {super.key, required this.subTitle});
  final String? subTitle;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height - 135,
      color: Colorpallete.mystic,
      child: NotifyText(
        title: title,
        subTitle: subTitle,
      ),
    );
  }
}

class NotifyText extends StatelessWidget {
  final String? subTitle;
  final String? title;
  const NotifyText({super.key, this.subTitle, this.title})
      : assert(title != null || subTitle != null,
            'title and subTitle must not be null');
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        if (title != null)
          Text(
            title!,
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        if (subTitle != null) ...[
          SizedBox(height: 17),
          Text(
            subTitle!,
            style: GoogleFonts.montserrat(
              fontSize: 15,
              color: AppColor.darkGrey,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
