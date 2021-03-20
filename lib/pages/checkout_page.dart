import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/screenutil.dart';
import 'package:ration_app/constants/colors.dart';
import 'package:ration_app/model/cart_model.dart';
import 'package:ration_app/model/food_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jiffy/jiffy.dart';

class CheckOutPage extends StatefulWidget {
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  var titleStyle = TextStyle(fontSize: 22/*ScreenUtil().setSp(22, allowFontScalingSelf: true), fontWeight: FontWeight.bold*/);
  var now = DateTime.now();

  List orderList;

  get weekDay => Jiffy().format("EEEE");
  get day => Jiffy().format("do");
  get month => Jiffy().format('MMMM');



  List<Food> displayList = [];

  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    displayList.clear();
    return Scaffold(
      body: SingleChildScrollView(
        controller: scrollController,
        physics: BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height:16/*ScreenUtil().setHeight(16)*/),
              SafeArea(
                child: InkWell(onTap: () => Navigator.of(context).pop(), child: Icon(Icons.arrow_back_ios)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 0),
                child: Text('$weekDay, ${day} of $month ', style: titleStyle),
              ),
              FlatButton(
                child: Text('+ Add more Items'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              ListView.builder(
                itemCount: cart.cartItems.length,
                shrinkWrap: true,
                controller: scrollController,
                itemBuilder: (BuildContext context, int index) {
                  // orderList = cart.cartItems[index] as List;
                  return buildCartItemList(cart, cart.cartItems[index]);
                },
              ),
              buildPriceInfo(cart),
              checkoutButton(cart, context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPriceInfo(Cart cart) {
    double total = 0;
    final titleStyle2 = TextStyle(fontSize: 18/*ScreenUtil().setSp(18, allowFontScalingSelf: true)*/, color: Colors.black45);
    for (CartModel cart in cart.cartItems) {
      total += cart.food.price * cart.quantity;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Total:', style: titleStyle2),
        Text('Ksh ${total.toStringAsFixed(2)}', style: titleStyle),
      ],
    );
  }
  Widget checkoutButton(cart, context) {
    // final titleStyle1 = TextStyle(fontSize: 16/*ScreenUtil().setSp(16, allowFontScalingSelf: true)*/,);
    return Container(
      margin: EdgeInsets.only(top: 16, bottom: 64),
      child: Center(
        child: RaisedButton(
          child: Text('Checkout', style: TextStyle(fontSize: 16/*ScreenUtil().setSp(16, allowFontScalingSelf: true)*/, color: Colors.white)),
          onPressed: () {
            String itemsList = '';
            int index = 1;

            String foodName = '';
            double total = 0;
            for (CartModel cart in cart.cartItems) {
              foodName = cart.food.name.replaceAll(' ', '%20');

              itemsList += "${index}.%20${foodName}%0D%0A"
                  "%20%20%20%20quantity%3A%20${cart.quantity}"
                  "%0D%0A"
                  "%20%20%20%20price%3A%20${cart.food.price}%20x%20${cart.quantity}"
                  "%0D%0A";
              index += 1;
              total += cart.food.price * cart.quantity;
            }
            print(itemsList);
            final url = "https://wa.me/254724061136?text=*Fayaz%20Bakery%20Delivery*"
                "%0D%0A%0D%0A"
                "I%20would%20like%20these%20items%20delivered%20to%20my%20house%3A%0D%0A%0D%0A"
                + itemsList +
                "%0D%0A*Total%3A%20${total.toStringAsFixed(2)}%20Ksh*";
            launch(url);

            // "1.%20" + cartModel.food.name + "name%20quantity%20price%0D%0A"
            // "2.%20" + cartModel.food.name + "name%20quantity%20price%0D%0A"
            // "3.%20" + cartModel.food.name + "name%20quantity%20price%0D%0A"
          },
          padding: EdgeInsets.symmetric(horizontal: 64, vertical: 12),
          color: mainColor,
          shape: StadiumBorder(),
        ),
      ),
    );
  }
  Widget buildCartItemList(Cart cart, CartModel cartModel) {
    var titleStyle = TextStyle(fontSize: 16/*ScreenUtil().setSp(16, allowFontScalingSelf: true)*/, fontWeight: FontWeight.bold);
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: Image.network(cartModel.food.image),
            ),
          ),
          Flexible(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 50/*ScreenUtil().setHeight(50)*/,
                  child: Text(
                    cartModel.food.name,
                    style: titleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () => cart.removeItem(cartModel),
                      child: Icon(Icons.remove_circle),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('${cartModel.quantity}', style: titleStyle),
                    ),
                    InkWell(
                      onTap: () => cart.increaseItem(cartModel),
                      child: Icon(Icons.add_circle),
                    ),
                  ],
                )
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 70/*ScreenUtil().setWidth(70)*/,
                  height: 40/*ScreenUtil().setHeight(40)*/,
                  child: Text(
                    'Ksh ${cartModel.food.price}',
                    style: titleStyle,
                    textAlign: TextAlign.end,
                  ),
                ),
                Card(
                  shape: roundedRectangle,
                  color: mainColor,
                  child: InkWell(
                    onTap: () => cart.removeAllInList(cartModel.food),
                    customBorder: roundedRectangle,
                    child: Icon(Icons.close, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
