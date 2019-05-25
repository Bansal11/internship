import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'flipkart.dart';
import 'amazon.dart';
import 'walmart.dart';
import 'myData.dart';
import 'package:firebase_database/firebase_database.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApphome(),
    );
  }
}

class MyApphome extends StatefulWidget {

  @override
  MyAppHomeState createState() => MyAppHomeState();
}
class MyAppHomeState extends State<MyApphome>{

  List<myData> allData = [];

  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var devices = ref.child('Posts');
    devices.once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var data = snap.value;
      for (var key in keys) {
        myData d = new myData(
          data[key]['url']
        );
        allData.add(d);
      }
      setState(() {
        print('Length : ${allData.length}');
      });
    });
  }


  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: ListView(
            children: <Widget>[
              Container(
            height: 150.0,
          ),
//              Container(
//                child: Text('CHOOSE YOUR YOUR RETAILER WISELY!'),
////                height: 250.0,
//          ),
//              Container(
//                height: 50.0,
//              ),
              CarouselSlider(items: [
                Container(
                  child: GestureDetector(

                    child: Image.network(allData[4].url),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context) => Amazon(),
                      ),
                      );
                    },
                  ),
                ),
                Container(
                  child: GestureDetector(

                    child: Image.network(allData[3].url),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Flipkart(),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  child: GestureDetector(

                    child: Image.network(allData[0].url),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Walmart(),
                        ),
                      );
                    },
                  ),
                ),
              ]),

//              RaisedButton(
//                  onPressed: () {
//                    print(allData);
//                    print(allData[1].url);
//                  })
            Text(allData[0].url),
            Container(height: 50.0,),
            Text(allData[1].url),
              Container(height: 50.0,),
          Text(allData[2].url),
            ],
          ),
        ),
      ),
    );
  }


  }