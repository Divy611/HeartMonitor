// ignore_for_file: unused_local_variable,unused_field
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heartmonitor/navigator/constants.dart';
import 'package:heartmonitor/ui/pages/Auth/login.dart';
import 'package:heartmonitor/widgets/newWidget/customLoader.dart';
import 'package:provider/provider.dart';
import 'package:heartmonitor/models/user.dart';
import 'package:heartmonitor/ui/theme/theme.dart';
import 'package:heartmonitor/state/authState.dart';
import 'package:heartmonitor/navigator/values.dart';
import 'package:heartmonitor/navigator/utility.dart';
import 'package:heartmonitor/widgets/customFlatButton.dart';

class Signup extends StatefulWidget {
  final VoidCallback? loginCallback;
  const Signup({super.key, this.loginCallback});
  @override
  State<StatefulWidget> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmController;
  late CustomLoader loader;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    loader = CustomLoader();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  Widget _body(BuildContext context) {
    return Container(
      color: Colors.white,
      height: context.height - 85,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _heading(context),
            _entryField('Name', controller: nameController),
            _entryField('Enter email',
                controller: emailController, isEmail: true),
            _entryField('Enter password',
                controller: passwordController, isPassword: true),
            _entryField('Confirm password',
                controller: confirmController, isPassword: true),
            _submitButton(context),
            Divider(height: 13),
            SizedBox(height: 7),
            //GoogleLoginButton(
            //  loginCallback: widget.loginCallback,
            //  loader: loader,
            //),
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Text(
                  'Already have an account?',
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
                            LogIn(loginCallback: state.getCurrentUser),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                    child: Text(
                      ' Log in',
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
        Text(
          "Sign Up",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w500,
            fontSize: 40,
          ),
        ),
        Text(
          "Sign Up Today!",
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w300,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 35),
      ],
    );
  }

  Widget _entryField(String hint,
      {required TextEditingController controller,
      bool isPassword = false,
      bool isEmail = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: controller,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        style: GoogleFonts.montserrat(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.normal,
        ),
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.black),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 35),
      child: CustomFlatButton(
        label: "Sign up",
        onPressed: () => _submitForm(context),
        borderRadius: 15,
      ),
    );
  }

  void _submitForm(BuildContext context) {
    if (emailController.text.isEmpty) {
      Utility.customSnackBar(context, 'Please enter a valid name');
      return;
    }
    if (emailController.text.length > 40) {
      Utility.customSnackBar(
          context, 'Email length cannot exceed 40 characters');
      return;
    }
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Utility.customSnackBar(context, 'Please fill all the fields');
      return;
    } else if (passwordController.text != confirmController.text) {
      Utility.customSnackBar(context, 'Your passwords did not match');
      return;
    }
    loader.showLoader(context);
    var state = Provider.of<AuthState>(context, listen: false);
    UserModel user = UserModel(
      email: emailController.text.toLowerCase(),
      bio: 'Edit profile to update bio',
      displayName: nameController.text,
      dob: DateTime(1950, DateTime.now().month, DateTime.now().day + 3)
          .toString(),
      location: 'Unknown',
      profession: "Enter your profession",
      profilePic: Constants.profp,
      isVerified: false,
    );
    state
        .signUp(
      user,
      password: passwordController.text,
      context: context,
    )
        .then(
      (status) {
        // print(status);
      },
    ).whenComplete(
      () {
        loader.hideLoader();
        if (state.authStatus == AuthStatus.LOGGED_IN) {
          Navigator.pop(context);
          if (widget.loginCallback != null) widget.loginCallback!();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(child: _body(context)),
    );
  }
}
