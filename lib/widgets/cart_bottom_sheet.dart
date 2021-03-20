import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/screenutil.dart';
import 'package:ration_app/constants/colors.dart';
import 'package:ration_app/model/cart_model.dart';
import 'package:ration_app/model/food_model.dart';
import 'package:ration_app/pages/checkout_page.dart';
import 'package:provider/provider.dart';

class CartBottomSheet extends StatelessWidget {
  final titleStyle = TextStyle(fontSize: 22/*ScreenUtil().setSp(22, allowFontScalingSelf: true)*/, fontWeight: FontWeight.bold);
  final titleStyle1 = TextStyle(fontSize: 16/*ScreenUtil().setSp(16, allowFontScalingSelf: true)*/, color: Colors.white);
  final titleStyle2 = TextStyle(fontSize: 18/*ScreenUtil().setSp(18, allowFontScalingSelf: true)*/, color: Colors.black45);
  final titleStyle4 = TextStyle(fontSize: 14/*ScreenUtil().setSp(14, allowFontScalingSelf: true)*/, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);
    // return DraggableScrollableSheet(
    //   initialChildSize: 1,
    //   maxChildSize: 1,
    //   minChildSize: 0.5,
    //   builder: (context, scrollController) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: Container(
              width: 90/*ScreenUtil().setWidth(90)*/,
              height: 8/*ScreenUtil().setHeight(8)*/,
              decoration: ShapeDecoration(shape: StadiumBorder(), color: Colors.black26),
            ),
          ),
          buildTitle(cart),
          Divider(),
          if (cart.cartItems.length <= 0) noItemWidget() else buildItemsList(cart),
          Divider(),
          buildPriceInfo(cart),
          SizedBox(height: 8/*ScreenUtil().setHeight(8)*/),
          proceedToCheckoutButton(cart, context),
        ],
      ),
    );
    //});
  }

  Widget buildTitle(cart) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'Your Order',
          style: titleStyle,
        ),
        Consumer<Cart>(
          builder: (context, myModel, child) {
            return IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){myModel.clearCart();}
            );
          },
        ),
      ],
    );
  }
  Widget buildItemsList(Cart cart) {
    return Expanded(
      child: ListView.builder(
        itemCount: cart.cartItems.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(cart.cartItems[index].food.image)),
              title: Text('${cart.cartItems[index].food.name}', style: titleStyle4),
              subtitle: Text('Ksh ${cart.cartItems[index].food.price}'),
              trailing: Text('x ${cart.cartItems[index].quantity}'),
            ),
          );
        },
      ),
    );
  }
  Widget noItemWidget() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('No items in cart!!', style: titleStyle2),
            SizedBox(height: 16/*ScreenUtil().setHeight(16)*/),
            Icon(Icons.remove_shopping_cart, size: 64),
          ],
        ),
      ),
    );
  }
  Widget buildPriceInfo(Cart cart) {
    double total = 0;
    for (CartModel cartModel in cart.cartItems) {
      total += cartModel.food.price * cartModel.quantity;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('Total:', style: titleStyle2),
        Text('Ksh ${total.toStringAsFixed(2)}', style: titleStyle),
      ],
    );
  }
  Widget proceedToCheckoutButton(cart, context) {
    return Center(
      child: RaisedButton(
        child: Text('Proceed to Checkout', style: titleStyle1,),
        onPressed: cart.cartItems.length == 0
            ? null
            : () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => CheckOutPage()));
              },
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        color: mainColor,
        shape: StadiumBorder(),
      ),
    );
  }
}
