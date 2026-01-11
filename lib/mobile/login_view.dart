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

class LoginViewMobile extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    TextEditingController _emailField=useTextEditingController();
    TextEditingController _passwordField=useTextEditingController();
     final viewModelProvider=ref.watch(viewmodel);
     final double deviceheight=MediaQuery.of(context).size.height;
     return SafeArea(
         child: Scaffold(
           body: SingleChildScrollView(
             child: Column(
               children: [
                 SizedBox(height: deviceheight/5.5,),
                  Image.asset("assets/logo.png",
                  width: 210,
                    fit: BoxFit.contain,
                  ),
                SizedBox(height: 20,),
                 SizedBox(
                   width: 310,
                   child:   TextFormField(
                     controller: _emailField,

                    keyboardType: TextInputType.emailAddress,
                     textAlign: TextAlign.center,
                     decoration: InputDecoration(
                       enabledBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10.0),
                       ),
                       focusedBorder: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10.0),
                       ),
                       prefixIcon: Icon(Icons.email,color: Colors.black,size: 30.0,),
                       hintText: "Email",
                       hintStyle: GoogleFonts.openSans()
                     ),
                   ),
                 ),
                 SizedBox(height: 20,),
                 SizedBox(
                   width: 310,
                   child:   TextFormField(
                     controller: _passwordField,
                       obscureText: viewModelProvider.isObsecure,
                     keyboardType: TextInputType.emailAddress,
                     textAlign: TextAlign.center,
                     decoration: InputDecoration(
                         enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10.0),
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10.0),
                         ),
                         prefixIcon: Icon(Icons.lock,color: Colors.black,size: 30.0,),
                         hintText: "Password",
                         suffixIcon: IconButton(
                             onPressed: (){
                               viewModelProvider.isObsecurePassword();
                             },
                             icon: Icon(viewModelProvider.isObsecure?Icons.visibility:Icons.visibility_off,color: Colors.black,size: 30,)
                         ),
                         hintStyle: GoogleFonts.openSans()
                     ),
                   ),
                 ),
                 SizedBox(height: 20,),
                 Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                   SizedBox(width: 150.0, height: 50,
                   child: MaterialButton(
                     child: Opensans(
                         text: "Register",
                         color: Colors.white,
                         size: 25,
                       fontWeight: null,

                     ),
                       splashColor: Colors.grey,
                       color: Colors.black,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadiusGeometry.circular(10.0)
                       ),
                       onPressed: ()async{
                     await  viewModelProvider.Signup(context, _emailField.text, _passwordField.text);
                       }
                   ),
                   ),
                   SizedBox(width: 20,),
                   Text("Or", style: GoogleFonts.pacifico(
                     color: Colors.black,
                     fontSize: 15.0
                   ),),
                   SizedBox(width: 20,),
                   SizedBox(width: 150.0,height: 50.0,
                   child: MaterialButton(
                       onPressed: ()async{
                      await   viewModelProvider.Login(context, _emailField.text, _passwordField.text);
                       },
                     child: Opensans(
                         text: "Login",
                         size: 25.0,
                       color: Colors.white,
                     ),
                     splashColor: Colors.grey,
                     color: Colors.black,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10.0)
                     ),
                   ),
                   )
                 ],),
                 SizedBox(height: 30,),
                 SignInButton(
                     buttonType: ButtonType.google,
                     btnColor: Colors.black,
                     btnTextColor: Colors.white,
                     buttonSize: ButtonSize.medium,
                     onPressed: (){
                     if(kIsWeb){
                viewModelProvider.SigninWithGoogleWeb(context);
                     }
                     }
                 )
               ],
             ),
           ),
         )
     );

  }

}