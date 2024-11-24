import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heartmonitor/ui/theme/theme.dart';
import 'package:heartmonitor/state/authState.dart';
import 'package:heartmonitor/navigator/values.dart';
import 'package:heartmonitor/ui/pages/homePage.dart';
import 'package:heartmonitor/ui/pages/Auth/welcomePage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      timer();
    });
    super.initState();
  }

  void timer() async {
    Future.delayed(Duration(seconds: 1)).then(
      (_) {
        var state = Provider.of<AuthState>(context, listen: false);
        state.getCurrentUser();
      },
    );
  }

  Widget splashScreen(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                width: 95,
                height: 95,
                'assets/logo.png',
              ),
              SizedBox(width: 15),
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

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context);
    return Scaffold(
      backgroundColor: Colorpallete.white,
      body: state.authStatus == AuthStatus.NOT_DETERMINED
          ? splashScreen(context)
          : state.authStatus == AuthStatus.NOT_LOGGED_IN
              ? WelcomePage()
              : HomePage(),
    );
  }
}
