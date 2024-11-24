import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heartmonitor/ui/pages/common/chart.dart';
import 'package:heartmonitor/ui/pages/common/header.dart';
import 'package:heartmonitor/ui/pages/common/sidebar.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: Header(title: 'Welcome, User!'),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              readingTile(context, 'Current Heart Rate', '80bpm'),
              SizedBox(height: 10),
              readingTile(context, 'Previous Reading', '94bpm')
            ],
          ),
        ),
      ),
    );
  }

  Widget readingTile(BuildContext context, String title, String reading) {
    return Container(
      padding: EdgeInsets.all(15),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        border: Border.all(width: 0.5, color: Colors.grey.shade400),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: GoogleFonts.montserrat(fontSize: 17)),
              Text(
                reading,
                style: GoogleFonts.montserrat(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Expanded(child: LineChartSample())
        ],
      ),
    );
  }
}
