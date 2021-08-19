import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:realestate_app/Backend/Config.dart';
import 'package:realestate_app/Screen/Details.dart';

class My_Wishes extends StatefulWidget {
  const My_Wishes({Key key}) : super(key: key);

  @override
  _My_WishesState createState() => _My_WishesState();
}

class _My_WishesState extends State<My_Wishes> {
  @override
  Widget build(BuildContext context) {
    List<String> Items = RealEstateApp.sharedPreferences
        .getStringList(RealEstateApp.userwishList);
    int wish_Items = RealEstateApp.sharedPreferences
        .getStringList(RealEstateApp.userwishList)
        .length;
    print(Items);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(

          "WishList",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              StreamBuilder(
                  stream: Firestore.instance.collection('items').snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Text("No items Yet");
                    }
                    return ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: snapshot.data.documents.map((model) {
                        return buildRowwithColumn(
                          ImgPath: model['image'],
                          name: model['name'],
                          mrp: model['Price'],
                          cat: model['category'],
                          long_description: model['details'],
                          rating: model['Rating'],
                          place: model['Address'],
                          sellername: model['SellerName'],
                          wished: Items,
                          sellerrating: model['SellerRating'],
                        );
                      }).toList(),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class buildRowwithColumn extends StatelessWidget {
  const buildRowwithColumn(
      {Key key,
      this.ImgPath,
      this.name,
      this.mrp,
      this.cat,
      this.long_description,
      this.place,
      this.sellername,
      this.rating,
      this.wished,
      this.sellerrating})
      : super(key: key);
  final String ImgPath,
      name,
      long_description,
      cat,
      mrp,
      place,
      sellername,
      rating,
      sellerrating;
  final List<String> wished;
  final String Mywish='Lake view ';

  @override
  Widget build(BuildContext context) {
    print(wished);
    if (name == Null) {
      return Container(height: 0,width: 0,);
    }
    if (name ==Mywish) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return Detail_Screen(
              category: cat,
              Address: place,
              img: ImgPath,
              price: mrp,
              rating: rating,
              sname: sellername,
              srate: sellerrating,
              name: name,
              description: long_description,
            );
          }));
        },
        child: Column(
          children: [
            Center(
              child: Container(
                height: 190,
                padding: EdgeInsets.only(left: 5),
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.network(
                          ImgPath,
                          fit: BoxFit.fitHeight,
                          height: 180,
                          width: 200,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(name,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold)),
                          Text(place,
                              style: TextStyle(
                                fontSize: 15,
                              )),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(rating,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                          Text(mrp,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    }else {
      return Container(
        height: 0,
        width: 0,
      );
    }
  }
}
