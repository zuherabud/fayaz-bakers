import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:ration_app/constants/colors.dart';
import 'package:ration_app/model/cart_model.dart';
import 'package:ration_app/model/food_model.dart';
import 'package:ration_app/widgets/cart_bottom_sheet.dart';
import 'package:ration_app/widgets/food_card.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'check_connection.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;

  int value = 0;

  bool firstTimeFetching = true;

  List grainsData = <Food>[];
  List flourData = <Food>[];
  List riceData = <Food>[];
  List fatOilData = <Food>[];
  List spicesData = <Food>[];


  getGrainsData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("biscuits").get();
    snapshot.docs.forEach((element) {
      // print(element.data());
      setState(() {grainsData.add(Food.fromJson(element.data()));});
    });
  }
  getFlourData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("flour").get();
    snapshot.docs.forEach((element) {
      setState(() {flourData.add(Food.fromJson(element.data()));});
    });
  }
  getRiceData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("rice").get();
    snapshot.docs.forEach((element) {
      setState(() {riceData.add(Food.fromJson(element.data()));});
    });
  }
  getFatOilData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("fatoil").get();
    snapshot.docs.forEach((element) {
      setState(() {fatOilData.add(Food.fromJson(element.data()));});
    });
  }
  getSpicesData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("spices").get();
    snapshot.docs.forEach((element) {
      setState(() {spicesData.add(Food.fromJson(element.data()));});
    });
  }

  getAllData()async{
    if(grainsData.isEmpty){
      print("fetching all Data...");
      getGrainsData();
      getFlourData();
      getRiceData();
      getFatOilData();
      getSpicesData();
    }
  }
  showCart() {
    showModalBottomSheet(
      shape: roundedRectangle32,
      context: context,
      builder: (context) => CartBottomSheet(),
    );
  }

  @override
  void initState() {
    super.initState();

    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });

    // getGrainsData();
    // getFlourData();
    // getRiceData();
    // getFatOilData();
    // getSpicesData();

    // setState(() {
    //
    // });
    // print(foodType1Cloud);
  }
  @override
  Widget build(BuildContext context) {
    // String string;
    // switch (_source.keys.toList()[0]) {
    //   case ConnectivityResult.none:
    //     string = "Offline";
    //     break;
    //   case ConnectivityResult.mobile:
    //     string = "Mobile: Online";
    //     break;
    //   case ConnectivityResult.wifi:
    //     string = "WiFi: Online";
    // }

    String string;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.none:
        setState(() {
          string = "Offline";
          print(string);
        });
        break;
      case ConnectivityResult.mobile:
        setState(() {
          string = "Mobile: Online";
          if(firstTimeFetching){
            getAllData();
            print("fetching....");
            firstTimeFetching = false;
          }
          print(string);
        });
        break;
      case ConnectivityResult.wifi:
        setState(() {
          string = "WiFi: Online";
          if(firstTimeFetching){
            getAllData();
            print("fetching....");
            firstTimeFetching = false;
          }
          print(string);
        });
    }

    int items = 0;
    Provider.of<Cart>(context).cartItems.forEach((cart) {
      items += cart.quantity;
    });

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          title: Row(
            children: <Widget>[
              Image(
                height: 50/*ScreenUtil().setHeight(45.0)*/,
                width: 70/*ScreenUtil().setWidth(120.0)*/,
                image: AssetImage('assets/logo.png'),
                fit: BoxFit.cover,
              ),
              Spacer(),
              Stack(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.shopping_cart, color: Colors.black,), onPressed: showCart),
                  Positioned(
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: mainColor),
                      child: Text(
                        '$items',
                        style: TextStyle(fontSize: 12/*ScreenUtil().setSp(12, allowFontScalingSelf: true)*/, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                text: "Biscuits",
              ),
              Tab(
                text: "Cakes",
              ),
              Tab(
                text: "Bread",
              ),
              Tab(
                text: "Savories",
              ),
              Tab(
                text: "Ice Cream",
              ),
              Tab(
                text: "Ice Lollies",
              ),
            ],
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            indicator: RectangularIndicator(
              verticalPadding: 10,
              horizontalPadding: 10,
              color: mainColor,
              bottomLeftRadius: 10,
              bottomRightRadius: 10,
              topLeftRadius: 10,
              topRightRadius: 10,
            ),
          ),
        ),
        body: (string == "Mobile: Online" || string == "WiFi: Online") && grainsData.isNotEmpty ? TabBarView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: <Widget>[
                  buildFoodList(grainsData),
                ],
              ),
            ),
            Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: <Widget>[
                buildFoodList(flourData),
              ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: <Widget>[
                  buildFoodList(riceData),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: <Widget>[
                  buildFoodList(fatOilData),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: <Widget>[
                  buildFoodList(spicesData),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: <Widget>[
                  buildFoodList(spicesData),
                ],
              ),
            ),
          ],
        ) : (string == "Offline") && grainsData.isNotEmpty ? TabBarView(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: <Widget>[
                  buildFoodList(grainsData),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: <Widget>[
                  buildFoodList(flourData),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: <Widget>[
                  buildFoodList(riceData),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: <Widget>[
                  buildFoodList(fatOilData),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: <Widget>[
                  buildFoodList(spicesData),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                children: <Widget>[
                  buildFoodList(spicesData),
                ],
              ),
            ),
          ],
        ) : Center(
          child: Text(
            "No internet connection!",
            style: TextStyle(
                color: Colors.grey[400],
                fontWeight: FontWeight.w600,
                fontSize: 20/*ScreenUtil().setSp(20, allowFontScalingSelf: true)*/
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFoodList(List foods) {
    return Expanded(
      child: GridView.builder(
        itemCount: foods.length,
        physics: BouncingScrollPhysics(),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          return FoodCard(foods[index]);
        },
      ),
    );
  }

  List<Food> foodType1Local = [
    Food(
      name: 'Food 1',
      price: 10,
      image: 'assets/food1.png',
    ),
    Food(
      name: 'Food 2',
      price: 20,
      image: 'assets/food2.png',
    ),
    Food(
      name: 'Food 3',
      price: 30,
      image: 'assets/food3.png',
    ),
  ];
  List<Food> foodType2Local = [
    Food(
      name: 'Food 1',
      price: 10,
      image: 'assets/food1.png',
    ),
    Food(
      name: 'Food 2',
      price: 20,
      image: 'assets/food2.png',
    ),
    Food(
      name: 'Food 3',
      price: 30,
      image: 'assets/food3.png',
    ),
  ];
  List<Food> foodType3Local = [
    Food(
      name: 'Food 1',
      price: 10,
      image: 'assets/food1.png',
    ),
    Food(
      name: 'Food 2',
      price: 20,
      image: 'assets/food2.png',
    ),
    Food(
      name: 'Food 3',
      price: 30,
      image: 'assets/food3.png',
    ),
  ];
}

// Using .forEach
// Future<List<Food>> getFoodData1 () async {
//   QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('foodType1').get();
// print(snapshot);
//   return foodType1Data = snapshot.docs.map((doc) {
//       foodType1Data.add(
//           Food(
//             doc[0]['name'],
//             doc[0]['price'],
//             doc[0]['image'],
//           ),
//       );
//   }).toList();
// }



//Using .map
// Future<List<Food>> getFood1List() async {
//   QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('foodType1').get();
//
//   return foodType1Data = snapshot.docs.map((doc) {
//     Food(
//       name: doc.data['name'],
//       price: doc.data['price'],
//       image: doc.data['image'],
//     );
//   }).toList();
// }

//Working but shows List of Instance of QuerySnapShots
// List foodType1Datas = [];
// getFoodType1Data() async {
//     QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("foodType1").get();
//     setState(() {
//
//       foodType1Datas.addAll(snapshot.docs);
//       var data = foodType1Datas[0]['name'];
//       print(data);
//     });
//
// }

// getFoodType1Data() async {
//   QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("foodType1").get();
//   snapshot.docs.map((food) =>
//       Food(
//         name: food.get('name'),
//         price: food.get('price'),
//         image: food.get('image'),
//       ),
//   );  //addAll(snapshot.docs);
//   print(foodType1Data);
// }

// final db = firestoreInstance.collection("foodType1").get();


// Widget buildAppBar() {
//   int items = 0;
//   Provider.of<Cart>(context).cartItems.forEach((cart) {
//     items += cart.quantity;
//   });
//   return SafeArea(
//     child: Row(
//       children: <Widget>[
//         Text('MENU', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//         Spacer(),
//         // IconButton(icon: Icon(Icons.search), onPressed: () {}),
//         Stack(
//           children: <Widget>[
//             IconButton(icon: Icon(Icons.shopping_cart), onPressed: showCart),
//             Positioned(
//               right: 0,
//               child: Container(
//                 alignment: Alignment.center,
//                 padding: EdgeInsets.all(4),
//                 decoration: BoxDecoration(shape: BoxShape.circle, color: mainColor),
//                 child: Text(
//                   '$items',
//                   style: TextStyle(fontSize: 12, color: Colors.black),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
// Widget buildFoodFilter() {
//   return Material(
//     child: TabBar(
//       indicatorColor: Colors.green,
//       tabs: [
//         Tab(
//           text: "Grains",
//         ),
//         Tab(
//           text: "Fats/Oils",
//         ),
//         Tab(
//           text: "Play",
//         ),
//         Tab(
//           text: "Work",
//         ),
//         Tab(
//           text: "Play",
//         ),
//       ],
//       labelColor: Colors.white,
//       unselectedLabelColor: Colors.black,
//       indicator: RectangularIndicator(
//         bottomLeftRadius: 100,
//         bottomRightRadius: 100,
//         topLeftRadius: 100,
//         topRightRadius: 100,
//       ),
//     ),
//   );
//   //   height: 50,
//   //   //color: Colors.red,
//   //   child: ListView(
//   //     scrollDirection: Axis.horizontal,
//   //     physics: BouncingScrollPhysics(),
//   //     children: List.generate(foodTypes.length, (index) {
//   //       return Padding(
//   //         padding: const EdgeInsets.all(8.0),
//   //         child: ChoiceChip(
//   //           autofocus: true,
//   //           selectedColor: mainColor,
//   //           labelStyle: TextStyle(color: value == index ? Colors.white : Colors.black),
//   //           label: Text(foodTypes[index]),
//   //           selected: value == index,
//   //
//   //           onSelected: (selected) {
//   //             setState(() {
//   //               print('choice chip ${value}');
//   //               value = selected ? index : null;
//   //             });
//   //           },
//   //         ),
//   //       );
//   //     }),
//   //   ),
//   // );
// }
