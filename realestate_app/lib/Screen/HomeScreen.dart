import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:realestate_app/Screen/Details.dart';
import 'package:realestate_app/Screen/Profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Center(
                    child: Container(
                      height: 80,
                      child: Image(image: AssetImage('assets/img1.png'),
                      ),
                    ),
                  ),
                  SizedBox(

                    width: 125,
                  ),
                  Text(
                    "Location ↓",
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Kerala,India",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                width: 140,
              ),
              Container(
                padding: EdgeInsets.only(top: 40),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.notifications_active,
                        color: Colors.greenAccent,
                        size: 30,
                      ),
                      onPressed: () {
                        print("icon pressed");
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.account_circle_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return Profile();
                        }));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                textColor: Colors.black,
                color: Colors.yellow,
                child: Text(
                  "Flats",
                  style: TextStyle(),
                ),
                onPressed: () {},
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(80.0),
                ),
              ),
              RaisedButton(
                textColor: Colors.white,
                color: Colors.blueGrey,
                child: Text("Homes"),
                onPressed: () {},
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(80.0),
                ),
              ),
              RaisedButton(
                textColor: Colors.black,
                color: Colors.yellow,
                child: Text("Land"),
                onPressed: () {},
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(80.0),
                ),
              ),
              RaisedButton(
                textColor: Colors.black,
                color: Colors.yellow,
                child: Text("Commercial"),
                onPressed: () {},
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(80.0),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    )),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Realtor",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Verified",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontStyle: FontStyle.italic),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        StreamBuilder(
                            stream: Firestore.instance
                                .collection('items')
                                .snapshots(),
                            // ignore: missing_return
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Text("No data");
                              }
                              return SizedBox(
                                height: 300,
                                width: MediaQuery.of(context).size.width,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  //physics: NeverScrollableScrollPhysics(),
                                  children:
                                      snapshot.data.documents.map((model) {
                                    return buildColumnWithRow(
                                      ImgPath: model['image'],
                                      name: model['name'],
                                      mrp: model['Price'],
                                      cat: model['category'],
                                      long_description: model['details'],
                                      rating: model['Rating'],
                                      place: model['Address'],
                                      sellername: model['SellerName'],
                                      sellerrating: model['SellerRating'],
                                    );
                                  }).toList(),
                                ),
                              );
                            })
                        /*  buildColumnWithRow("1", "Nikal Apartments", "100",
                            "Kozhikode", "4.5", context),
                        buildColumnWithRow("2", "Nikal Apartments", "100",
                            "Kozhikode", "4.5", context),
                        buildColumnWithRow("3", "Nikal Apartments", "100",
                            "Kozhikode", "4.5", context),
                        buildColumnWithRow("4", "Nikal Apartments", "100",
                            "Kozhikode", "4.5", context),*/
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Recommended ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "For You",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    StreamBuilder(
                        stream:
                            Firestore.instance.collection('items').snapshots(),
                        // ignore: missing_return
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Text("No data");
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
                                sellerrating: model['SellerRating'],
                              );
                            }).toList(),
                          );
                        })
                    /*Column(
                      //mainAxisAlignment: MainAxisAlignment. spaceBetween,
                      children: [
                        buildRowwithColumn("4", "Nikal Apartmnets", "Kozhikode",
                            "4.5", "400.5", context),
                        SizedBox(
                          height: 20,
                        ),
                        buildRowwithColumn("3", "Nikal Apartmnets", "Kozhikode",
                            "4.5", "400.5", context),
                        SizedBox(
                          height: 20,
                        ),
                        buildRowwithColumn("2", "Nikal Apartmnets", "Kozhikode",
                            "4.5", "400.5", context),
                        SizedBox(
                          height: 20,
                        ),
                        buildRowwithColumn("6", "Nikal Apartmnets", "Kozhikode",
                            "4.5", "400.5", context),
                        SizedBox(
                          height: 20,
                        ),
                        buildRowwithColumn("1", "Nikal Apartmnets", "Kozhikode",
                            "4.5", "400.5", context),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    )*/
                  ],
                ),
              ),
            ),
          ),
        ],
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

  @override
  Widget build(BuildContext context) {
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
                                    fontSize: 15, fontWeight: FontWeight.bold))
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
  }
}

class buildColumnWithRow extends StatelessWidget {
  const buildColumnWithRow(
      {Key key,
      this.ImgPath,
      this.name,
      this.mrp,
      this.cat,
      this.long_description,
      this.place,
      this.sellername,
      this.rating,
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
  final sname = 'Steve J';

  @override
  Widget build(BuildContext context) {
    if (name == null) {
      return Container(
        width: 0,
        height: 0,
      );
    }
    if (sellername == sname) {
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10),
                height: 250,
                width: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.network(
                        ImgPath,
                        fit: BoxFit.fitWidth,
                        height: 110,
                      ),
                    ),
                    Text(
                      mrp,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 2,
                      width: 140,
                      color: Colors.grey,
                    ),
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      place,
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(rating,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        height: 0,
        width: 0,
      );
    }
  }
}
