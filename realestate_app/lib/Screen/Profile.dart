import 'package:flutter/material.dart';
import 'package:realestate_app/Backend/Config.dart';
import 'package:realestate_app/Screen/HomeScreen.dart';
import 'package:realestate_app/Screen/wishlist.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Realtor",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width ,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40,),
              Text(
                "Name : " +
                    RealEstateApp.sharedPreferences
                        .getString(RealEstateApp.userName),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Email : " +
                    RealEstateApp.sharedPreferences
                        .getString(RealEstateApp.userEmail),
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Address: Edappally,Kochi,Kerala",style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
              SizedBox(height: 30,),
              Container(
               // width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Divider(
                      height: 10,
                      color: Colors.black,
                      thickness: 10,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ListTile(
                      leading: Icon(Icons.home, color: Colors.black),
                      title: Text(
                        "Home",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Route route =
                            MaterialPageRoute(builder: (c) => HomeScreen());
                        Navigator.push(context, route);
                      },
                    ),
                    Divider(
                      height: 10,
                      color: Colors.black,
                      thickness: 10,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ListTile(
                      leading: Icon(Icons.favorite, color: Colors.red),
                      title: Text(
                        "WishList",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Route route =
                            MaterialPageRoute(builder: (c) => My_Wishes());
                        Navigator.push(context, route);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
