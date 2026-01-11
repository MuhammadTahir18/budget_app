import 'package:BudgetApp/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/legacy.dart';
import 'package:logger/logger.dart';
import 'package:google_sign_in/google_sign_in.dart';

final viewmodel =
ChangeNotifierProvider.autoDispose<ViewModel>((ref) => ViewModel());

class ViewModel with ChangeNotifier {
  bool isLogin = false;
  bool isObsecure = true;

  CollectionReference collectionReference =
  FirebaseFirestore.instance.collection("users");

  final _auth = FirebaseAuth.instance;
  var logger = Logger();

  List expenseName = [];
  List expenseAmount = [];
  List incomeName = [];
  List incomeAmount = [];

  Future<void> isLogedin() async {
    _auth.authStateChanges().listen((User? user) {
      isLogin = user != null;
      notifyListeners();
    });
  }

  isObsecurePassword() {
    isObsecure = !isObsecure;
    notifyListeners();
  }

  Future<void> Signup(
      BuildContext context, String email, String password) async {
    await _auth
        .createUserWithEmailAndPassword(
        email: email, password: password)
        .then((value) {
      snakBar(context, "Register successful");
    }).onError((error, stackTrace) {
      DialogBox(
          context, error.toString().replaceAll(RegExp("\\[.*?\\]"), " "));
    });
    notifyListeners();
  }

  Future<void> Login(
      BuildContext context, String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      snakBar(context, "Login successful");
    }).onError((error, stackTrace) {
      DialogBox(
          context, error.toString().replaceAll(RegExp("\\[.*?\\]"), " "));
    });
    notifyListeners();
  }

  Future<void> SigninWithGoogleWeb(BuildContext context) async {
    GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
    await _auth.signInWithPopup(googleAuthProvider).onError(
          (error, stackTrace) => DialogBox(
        context,
        error.toString().replaceAll(RegExp("\\[.*?\\]"), " "),
      ),
    );
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  // ================= EXPENSE =================

  Future<void> addExpense(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final TextEditingController controllerName = TextEditingController();
    final TextEditingController controllerAmount = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Form(
            key: formKey,
            child: Row(
              children: [
                TextForm(
                  text: "Name",
                  containerWidth: 130,
                  hintText: "Name",
                  controller: controllerName,
                  validator: (v) => v!.isEmpty ? "Required" : null,
                ),
                const SizedBox(width: 10),
                TextForm(
                  text: "Amount",
                  containerWidth: 130,
                  hintText: "Amount",
                  controller: controllerAmount,
                  validator: (v) => v!.isEmpty ? "Required" : null,
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: MaterialButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await collectionReference
                        .doc(_auth.currentUser!.uid)
                        .collection("expenses") // ✅ FIX
                        .add({
                      "name": controllerName.text.trim(), // ✅ FIX
                      "amount": controllerAmount.text.trim(), // ✅ FIX
                    });
                    Navigator.pop(context);
                  }
                },
                color: Colors.black,
                child: Opensans(
                  text: "Save",
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ================= INCOME =================

  Future<void> addIncome(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    final TextEditingController controllerName = TextEditingController();
    final TextEditingController controllerAmount = TextEditingController();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Form(
            key: formKey,
            child: Row(
              children: [
                TextForm(
                  text: "Name",
                  containerWidth: 130,
                  hintText: "Name",
                  controller: controllerName,
                  validator: (v) => v!.isEmpty ? "Required" : null,
                ),
                const SizedBox(width: 10),
                TextForm(
                  text: "Amount",
                  containerWidth: 130,
                  hintText: "Amount",
                  controller: controllerAmount,
                  validator: (v) => v!.isEmpty ? "Required" : null,
                ),
              ],
            ),
          ),
          actions: [
            Center(
              child: MaterialButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    await collectionReference
                        .doc(_auth.currentUser!.uid)
                        .collection("incomes") // ✅ FIX
                        .add({
                      "name": controllerName.text.trim(), // ✅ FIX
                      "amount": controllerAmount.text.trim(), // ✅ FIX
                    });
                    Navigator.pop(context);
                  }
                },
                color: Colors.black,
                child: Opensans(
                  text: "Save",
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  ///////////////// addExpenseStream/////////////
   void ExpenseStream()async {
    await for(var snapshot in collectionReference.doc(_auth.currentUser!.uid).collection("expenses").snapshots() ){
      expenseAmount=[];
     expenseName=[];

     for(var expense in snapshot.docs){
       expenseName.add(expense.data()["name"]);
       expenseAmount.add(expense.data()["amount"]);
     }
     notifyListeners();
    }
}
   void IncomeStream()async {
    await for(var snapshot in collectionReference.doc(_auth.currentUser!.uid).collection("incomes").snapshots() ){
      incomeAmount=[];
      incomeName=[];

      for(var income in snapshot.docs){
        incomeName.add(income.data()["name"]);
        incomeAmount.add(income.data()["amount"]);
      }
      notifyListeners();
    }
  }
  //////////   for reset/////////////

 Future<void> reset()async{
    await collectionReference.doc(_auth.currentUser!.uid).collection("expenses").get().then((snapshot){
      for( DocumentSnapshot ds in snapshot.docs ){
        ds.reference.delete();
      }
    });
    await collectionReference.doc(_auth.currentUser!.uid).collection("incomes").get().then((snapshot){
      for( DocumentSnapshot ds in snapshot.docs ){
        ds.reference.delete();
      }
    });
 }
}

// Mobile Google Sign-In
// Future<void> SigninWithGoogleMobile(BuildContext context) async {
//   try {
//     // ✅ correct GoogleSignIn usage
//     final GoogleSignInAccount? googleUser =
//     await GoogleSignIn().signIn();
//
//     if (googleUser == null) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Sign in cancelled")),
//       );
//       return;
//     }
//
//     final GoogleSignInAuthentication googleAuth =
//     await googleUser.authentication;
//
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//
//     final userCredential =
//     await FirebaseAuth.instance.signInWithCredential(credential);
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Login Successful: ${userCredential.user!.email}")),
//     );
//   } catch (e) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Error: $e")),
//     );
//   }
// }




