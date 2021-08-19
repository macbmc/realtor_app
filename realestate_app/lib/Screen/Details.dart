import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:realestate_app/Backend/Config.dart';
import 'package:realestate_app/Counters/CartItemCounter.dart';

class Detail_Screen extends StatelessWidget {
  const Detail_Screen(
      {Key key,
      this.category,
      this.name,
      this.img,
      this.price,
      // this.place,
      this.rating,
      this.sname,
      this.srate,
      this.description,
      this.Address})
      : super(key: key);
  final String img, name, category, description;
  final String price;
  //final String place;
  final String rating;
  final String sname;
  final String srate;

  final String Address;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "Realtor",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.black,

          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(15.0),
                  width: MediaQuery.of(context).size.width,
                  height: 400,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text(price,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                      InkWell(
                          onTap: () {
                            checkItemInWish(name, context);
                          },
                          child: Container(
                            height: 40,
                              decoration: BoxDecoration(
                                border:
                                Border.all(color: Colors.orange, width: 5),
                                color: Colors.deepOrange,
                              ),
                              child: Center(
                                  child: Text(
                                    "Add To Favourites",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(name,
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text("Realtor",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Description:",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(Address),
                      ],
                    )),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  width: MediaQuery.of(context).size.width,
                  height: 3,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Details-",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 20,
                ),
                Detarow("House Type", category),
                SizedBox(
                  height: 20,
                ),
                Detarow("Locations", Address),
                SizedBox(
                  height: 20,
                ),
                Detarow("Ratings / 5", rating),
                SizedBox(
                  height: 20,
                ),
                Detarow("SellerName", sname),
                SizedBox(
                  height: 20,
                ),
                Detarow("SellerRating", srate),
                SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.indigo[900],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                        bottomRight: Radius.circular(25.0),
                        bottomLeft: Radius.circular(25.0),
                      )),
                  child: TextButton(
                    onPressed: () {
                      print("chat");
                    },
                    child: Text("Contact Seller",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          )),
    );
  }
  void checkItemInWish( String name, BuildContext context)
  {
    RealEstateApp.sharedPreferences.getStringList(RealEstateApp.userwishList).contains(name)
        ?Fluttertoast.showToast(msg: "Item is already in Favourites")
        : addItemToWish(name,context);
  }
  addItemToWish(String name, BuildContext context){

    List tempWishList = RealEstateApp.sharedPreferences.getStringList(RealEstateApp.userwishList);

    tempWishList.add(name);

    RealEstateApp.firestore
        .collection(RealEstateApp.collectionUser)
        .document(
        RealEstateApp.sharedPreferences.getString(RealEstateApp.userUID))
        .updateData({
      RealEstateApp.userwishList: tempWishList,
    }).then((v){
      Fluttertoast.showToast(msg: "Item Added to Favourites Successfully");
      RealEstateApp.sharedPreferences
          .setStringList(RealEstateApp.userwishList, tempWishList);
      Provider.of<CartItemCounter>(context,listen: false).displayResult();
    });
  }

  Row Detarow(String prop, String ans) {
    return Row(
      children: [
        SizedBox(
          width: 15,
        ),
        Text("$prop",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey)),
        SizedBox(
          width: 150,
        ),
        Expanded(
          child: Text("$ans",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
        ),
        SizedBox(
          width: 15,
        ),
      ],
    );
  }
}
