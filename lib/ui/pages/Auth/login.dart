import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heartmonitor/ui/theme/theme.dart';
import 'package:heartmonitor/state/authState.dart';
import 'package:heartmonitor/navigator/utility.dart';
import 'package:heartmonitor/ui/pages/Auth/signup.dart';
import 'package:heartmonitor/widgets/customFlatButton.dart';
import 'package:heartmonitor/widgets/newWidget/customLoader.dart';

class LogIn extends StatefulWidget {
  final VoidCallback? loginCallback;
  const LogIn({super.key, this.loginCallback});
  @override
  State<StatefulWidget> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late CustomLoader loader;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    loader = CustomLoader();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Widget _body(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _heading(context),
            _entryField('Enter email', controller: _emailController),
            _entryField('Enter password',
                controller: _passwordController, isPassword: true),
            _labelButton('Forgot password?', onPressed: () {
              Navigator.pushNamed(context, '/ForgetPasswordPage');
            }),
            _emailLoginButton(context),
            Divider(height: 10),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Text(
                  'New Here?',
                  style: GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                InkWell(
                  onTap: () {
                    var state = Provider.of<AuthState>(context, listen: false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Signup(loginCallback: state.getCurrentUser),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                    child: Text(
                      'Sign Up',
                      style: GoogleFonts.montserrat(
                        fontSize: 15,
                        color: Colorpallete.primary,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _heading(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 45),
        Text(
          "Login",
          style: GoogleFonts.montserrat(
            fontSize: 50,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          "Welcome Back!",
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ),
        SizedBox(height: 45),
      ],
    );
  }

  Widget _entryField(String hint,
      {required TextEditingController controller, bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 7),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        style: GoogleFonts.montserrat(
          color: Colors.black,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.normal,
        ),
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }

  Widget _labelButton(String title, {Function? onPressed}) {
    return TextButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Text(
        title,
        style: GoogleFonts.montserrat(
          color: Colorpallete.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _emailLoginButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 35),
      child: CustomFlatButton(
        label: "Log In",
        borderRadius: 13,
        onPressed: _emailLogin,
      ),
    );
  }

  void _emailLogin() {
    var state = Provider.of<AuthState>(context, listen: false);
    if (state.isbusy) {
      return;
    }
    loader.showLoader(context);
    var isValid = Utility.validateCredentials(
        context, _emailController.text, _passwordController.text);
    if (isValid) {
      state
          .signIn(_emailController.text, _passwordController.text,
              context: context)
          .then(
        (status) {
          if (state.user != null) {
            loader.hideLoader();
            Navigator.pop(context);
            widget.loginCallback!();
          } else {
            loader.hideLoader();
          }
        },
      );
    } else {
      loader.hideLoader();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: _body(context),
    );
  }
}
