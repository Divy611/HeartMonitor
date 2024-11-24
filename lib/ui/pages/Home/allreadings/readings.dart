import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heartmonitor/ui/pages/common/chart.dart';
import 'package:heartmonitor/ui/pages/common/header.dart';

class AllReadings extends StatefulWidget {
  const AllReadings({super.key});
  @override
  State<AllReadings> createState() => _AllReadingsState();
}

class _AllReadingsState extends State<AllReadings> {
  late bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: 'All Readings'),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [for (var i = 0; i <= 8; i++) readingTile(context)],
        ),
      ),
    );
  }

  Widget readingTile(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      child: TextButton(
        onPressed: () {
          setState(() {
            isOpen = !isOpen;
          });
        },
        child: Container(
          height: isOpen ? 245 : 80,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          padding: EdgeInsets.all(7.5),
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 7.5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    Icon(
                      size: 17,
                      color: Colors.black,
                      isOpen
                          ? FontAwesomeIcons.chevronUp
                          : FontAwesomeIcons.chevronDown,
                    )
                  ],
                ),
                isOpen
                    ? Container(
                        width: 350,
                        height: 200,
                        padding: EdgeInsets.only(top: 10),
                        child: LineChartSample(),
                      )
                    : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
