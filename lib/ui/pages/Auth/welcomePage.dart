import 'package:flutter/material.dart';
import 'package:heartmonitor/ui/pages/Auth/login.dart';
import 'package:heartmonitor/ui/pages/Auth/signup.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heartmonitor/ui/theme/theme.dart';
import 'package:heartmonitor/state/authState.dart';
import 'package:heartmonitor/navigator/values.dart';
import 'package:heartmonitor/ui/pages/homePage.dart';
import 'package:heartmonitor/widgets/animations.dart';
import 'package:heartmonitor/widgets/customFlatButton.dart';
import 'package:heartmonitor/widgets/newWidget/title_text.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget _signupButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      width: MediaQuery.of(context).size.width,
      child: CustomFlatButton(
        label: "Create an Account",
        onPressed: () {
          var state = Provider.of<AuthState>(context, listen: false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Signup(
                loginCallback: state.getCurrentUser,
              ),
            ),
          );
        },
        borderRadius: 10,
      ),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 45,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width - 80,
              height: 50,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  Image.asset('assets/logo.png'),
                  SizedBox(width: 10),
                  Text(
                    "Heart Monitor",
                    style: GoogleFonts.montserrat(fontSize: 25),
                  ),
                ],
              ),
            ),
            Spacer(),
            SlideAndFadeAnimation(
              duration: Duration(milliseconds: 950),
              child: Text(
                "Welcome!",
                style: GoogleFonts.montserrat(fontSize: 40),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _signupButton(),
            Spacer(),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                TitleText(
                  'Already have an account?',
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
                InkWell(
                  onTap: () {
                    var state = Provider.of<AuthState>(context, listen: false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LogIn(
                          loginCallback: state.getCurrentUser,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                    child: TitleText(
                      ' Log in',
                      fontSize: 15,
                      color: Colorpallete.primary,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AuthState>(context, listen: false);
    return Scaffold(
      body: state.authStatus == AuthStatus.NOT_LOGGED_IN ||
              state.authStatus == AuthStatus.NOT_DETERMINED
          ? _body()
          : const HomePage(),
    );
  }
}
