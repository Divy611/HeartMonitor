import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heartmonitor/ui/theme/theme.dart';

class CustomLoader {
  static CustomLoader? _customLoader;
  CustomLoader._createObject();
  factory CustomLoader() {
    if (_customLoader != null) {
      return _customLoader!;
    } else {
      _customLoader = CustomLoader._createObject();
      return _customLoader!;
    }
  }

  //static OverlayEntry _overlayEntry;
  OverlayState? _overlayState; //= new OverlayState();
  OverlayEntry? _overlayEntry;

  _buildLoader() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return SizedBox(
          height: context.height,
          width: context.width,
          child: buildLoader(context),
        );
      },
    );
  }

  showLoader(context) {
    _overlayState = Overlay.of(context);
    _buildLoader();
    _overlayState!.insert(_overlayEntry!);
  }

  hideLoader() {
    try {
      _overlayEntry?.remove();
      _overlayEntry = null;
    } catch (e) {}
  }

  buildLoader(BuildContext context, {Color? backgroundColor}) {
    backgroundColor ??= const Color(0xffa8a8a8).withOpacity(.5);
    var height = 150.0;
    var text = "Heart Monitor";
    return CustomScreenLoader(
      height: height,
      width: height,
      text: text,
      backgroundColor: backgroundColor,
    );
  }
}

class CustomScreenLoader extends StatelessWidget {
  final Color backgroundColor;
  final double height;
  final double width;
  final String text;
  const CustomScreenLoader({
    super.key,
    this.backgroundColor = const Color(0xfff8f8f8),
    this.height = 30,
    this.width = 30,
    this.text = "Heart Monitor",
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.all(50),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Platform.isIOS
                      ? CupertinoActivityIndicator(radius: 35)
                      : CircularProgressIndicator(strokeWidth: 2),
                  Image.asset('assets/logo.png', height: 45, width: 45),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Heart Monitor',
                style: GoogleFonts.montserrat(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
