import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realestate_app/Backend/Config.dart';
import 'package:realestate_app/Screen/CreateAcnt.dart';

import 'package:realestate_app/Screen/Dialogs/ErrorAlert.dart';
import 'package:realestate_app/Screen/HomeScreen.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(10),
            children: [
              Image(image: AssetImage('assets/img1.png')),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: CustomTextField(
                  controller: emailController,
                  data: Icons.mail,
                  hinttext: "Email",
                  isobscure: false,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: CustomTextField(
                  controller: passwordController,
                  data: Icons.person,
                  hinttext: "Password",
                  isobscure: true,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.grey,
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      emailController.text.isNotEmpty &&
                              passwordController.text.isNotEmpty
                          ? loginUser()
                          : showDialog(
                              context: context,
                              builder: (c) {
                                return ErrorAlertDialogue(
                                    Message: "Fill all the fields");
                              });
                    },
                  )),
              Container(
                  child: Row(
                children: <Widget>[
                  Text(
                    'New user?',
                    style: TextStyle(color: Colors.white),
                  ),
                  FlatButton(
                    textColor: Colors.yellow[800],
                    child: Text(
                      'Create Account',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateAcnt()));
                      //signup screen
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ))
            ],
          ),
        ),
      ),
    );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void loginUser() async {
    FirebaseUser firebaseUser;
    await _auth
        .signInWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .then((authUser) {
      firebaseUser = authUser.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialogue(Message: error.message.toString());
          });
    });
    if (firebaseUser != null) {
      readData(firebaseUser).then((s) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => HomeScreen());
        Navigator.push(context, route);
      });
    }
  }
}

Future readData(FirebaseUser fUser) async {
  Firestore.instance
      .collection("user")
      .document(fUser.uid)
      .get()
      .then((DataSnapshot) async {
    await RealEstateApp.sharedPreferences
        .setString("uid", DataSnapshot.data[RealEstateApp.userUID]);
    await RealEstateApp.sharedPreferences
        .setString("uid", DataSnapshot.data[RealEstateApp.userEmail]);
    await RealEstateApp.sharedPreferences
        .setString("uid", DataSnapshot.data[RealEstateApp.userName]);
    List<String> sellerList =
        DataSnapshot.data[RealEstateApp.userSellerList].cast<String>();
    await RealEstateApp.sharedPreferences
        .setStringList(RealEstateApp.userSellerList, sellerList);
    List<String> WishList =
        DataSnapshot.data[RealEstateApp.userwishList].cast<String>();
    await RealEstateApp.sharedPreferences
        .setStringList(RealEstateApp.userwishList, WishList);
  });
}

class CustomTextField extends StatelessWidget {
  final controller, hinttext, data;
  bool isobscure = true;
  CustomTextField(
      {Key key, this.controller, this.data, this.hinttext, this.isobscure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
      obscureText: isobscure,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        prefixIcon: Icon(data, color: Colors.black),
        hintText: hinttext,
        fillColor: Colors.black,
      ),
    );
  }
}
