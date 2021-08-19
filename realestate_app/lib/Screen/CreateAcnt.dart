import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:realestate_app/Backend/Config.dart';
import 'package:realestate_app/Screen/CreateAcnt.dart';

import 'package:realestate_app/Screen/Dialogs/ErrorAlert.dart';
import 'package:realestate_app/Screen/HomeScreen.dart';
import 'package:realestate_app/Screen/LoginPage.dart';

class CreateAcnt extends StatefulWidget {
  CreateAcnt({Key key}) : super(key: key);

  @override
  _CreateAcntState createState() => _CreateAcntState();
}

class _CreateAcntState extends State<CreateAcnt> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController cpasswordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(

          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/img8.jpg"),fit: BoxFit.fitWidth)
          ),
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          //color: Colors.yellow[100],
          child: Column(
            children: [
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pop();
                    },
                      child: Icon(Icons.arrow_back_ios)),
                  Text("Create Account",
                      style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold,color: Colors.white)),
                  SizedBox(width: 10,)
                ],
              ),
              SizedBox(
                height: 80,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: CustomTextField(
                  controller: nameController,
                  data: Icons.person,
                  hinttext: "Name",
                  isobscure: false,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                // padding: EdgeInsets.all(10),
                child: CustomTextField(
                  controller: emailController,
                  data: Icons.email,
                  hinttext: "Email",
                  isobscure: false,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                // padding: EdgeInsets.all(10),
                child: CustomTextField(
                  controller: passwordController,
                  data: Icons.person,
                  hinttext: "Password",
                  isobscure: true,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                //padding: EdgeInsets.all(10),
                child: CustomTextField(
                  controller: cpasswordController,
                  data: Icons.person,
                  hinttext: "Confirm Password",
                  isobscure: true,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  color: Colors.black,
                  onPressed: () {
                    print("the acnt is creating\n\n");
                    uploadAndsave();
                    Navigator.pop(context);
                    Route route =
                        MaterialPageRoute(builder: (c) => HomeScreen());
                    Navigator.push(context, route);
                  },
                  child: Text("Create Account",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> uploadAndsave() async {
    if (passwordController.text.isNotEmpty) {
      passwordController.text == cpasswordController.text
          ? nameController.text.isNotEmpty &&
                  emailController.text.isNotEmpty &&
                  passwordController.text.isNotEmpty &&
                  cpasswordController.text.isNotEmpty
              ? uploadStorage()
              : DisplayDialogue("Please fill all the feilds")
          : DisplayDialogue("Please fill all the feilds");
    } else {
      DisplayDialogue("Password miss match found");
    }
  }

  DisplayDialogue(String Msg) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialogue(Message: Msg);
        });
  }

  uploadStorage() async {
    _registerUser();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void _registerUser() async {
    FirebaseUser firebaseUser;
    final authuser = await _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim())
        .catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialogue(
              Message: error.message.toString(),
            );
          });
    });
    final user = await _auth.currentUser;
    firebaseUser = authuser.user;
    print(user);
    if (user != null) {
      saveUserInfoToFireStore(firebaseUser).then((value) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => HomeScreen());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future saveUserInfoToFireStore(FirebaseUser fUser) async {
    Firestore.instance.collection("user").document(fUser.uid).setData({
      "uid": fUser.uid,
      "email": fUser.email,
      "name": nameController.text.trim(),
      RealEstateApp.userSellerList: ["garbageValue"],
      RealEstateApp.userwishList: ["garbageValue"]
    });
    await RealEstateApp.sharedPreferences.setString("uid", fUser.uid);
    await RealEstateApp.sharedPreferences
        .setString(RealEstateApp.userEmail, fUser.email);
    await RealEstateApp.sharedPreferences
        .setString(RealEstateApp.userName, nameController.text);
    await RealEstateApp.sharedPreferences
        .setStringList(RealEstateApp.userSellerList, ["garbageValue"]);
    await RealEstateApp.sharedPreferences
        .setStringList(RealEstateApp.userwishList, ["garbageValue"]);
  }
}
