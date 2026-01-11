import 'package:BudgetApp/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

import '../view_model.dart';

class LoginViewWeb extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _emailField = useTextEditingController();
    TextEditingController _passwordField = useTextEditingController();
    final viewModelProvider = ref.watch(viewmodel);
    final double deviceheight = MediaQuery.of(context).size.height;
    final double devicewidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/login_image.png", width: devicewidth / 2.6),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: deviceheight / 5.5),
                  Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                    width: 200.0,
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: _emailField,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black,
                          size: 30,
                        ),
                        hintText: "Email",
                        hintStyle: GoogleFonts.openSans(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: viewModelProvider.isObsecure,
                      controller: _passwordField,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        prefixIcon: InkWell(
                          onTap: () {
                            viewModelProvider.isObsecurePassword();
                          },
                          child: viewModelProvider.isObsecure
                              ? Icon(
                                  Icons.visibility,
                                  color: Colors.black,
                                  size: 30,
                                )
                              : Icon(Icons.visibility_off, color: Colors.black),
                        ),
                        hintText: "password",
                        hintStyle: GoogleFonts.openSans(),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: MaterialButton(
                          onPressed: () {
                            viewModelProvider.Signup(
                              context,
                              _emailField.text,
                              _passwordField.text,
                            );
                          },
                          child: Opensans(
                            text: "Register",
                            size: 25,
                            color: Colors.white,
                          ),
                          splashColor: Colors.grey,
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Text(
                        "Or",
                        style: GoogleFonts.pacifico(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(width: 20),
                      SizedBox(
                        width: 150.0,
                        height: 50.0,
                        child: MaterialButton(
                          onPressed: () {
                            viewModelProvider.Login(
                              context,
                              _emailField.text,
                              _passwordField.text,
                            );
                          },
                          child: Opensans(
                            text: "Login",
                            size: 25.0,
                            color: Colors.white,
                          ),
                          splashColor: Colors.grey,
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  SignInButton(
                    buttonType: ButtonType.google,
                    btnColor: Colors.black,
                    btnTextColor: Colors.white,
                    buttonSize: ButtonSize.medium,
                    onPressed: () {
                      if (kIsWeb) {
                        viewModelProvider.SigninWithGoogleWeb(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
