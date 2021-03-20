import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/screenutil.dart';
import 'package:ration_app/constants/colors.dart';
import 'package:ration_app/model/cart_model.dart';
import 'package:ration_app/model/food_model.dart';
import 'package:provider/provider.dart';

class FoodCard extends StatefulWidget {
  final Food food;
  FoodCard(this.food);

  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  Food get food => widget.food;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        // color: Colors.purple,
        border: new Border.all(color: Colors.grey[300], width: 1.0, style: BorderStyle.solid),
        borderRadius: new BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildImage(),
              buildTitle(),
            ],
          ),
          buildPriceInfo(),
        ],
      ),
    );
  }

  Widget buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      child: Image.network(
        food.image,
        fit: BoxFit.cover,
        height: 115/*ScreenUtil().setHeight(115)*/,
        loadingBuilder: (context, Widget child, ImageChunkEvent progress) {
          if (progress == null) return child;
          return Padding(
              padding: EdgeInsets.all(32),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor : AlwaysStoppedAnimation(Colors.black),
                  value: progress.expectedTotalBytes != null ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes : null,
                ),
              ));
        },
      ),
      // child: Image(
      //   height: 100,
      //   image: food.image == null ? AssetImage('assets/groceri_logo.png') : NetworkImage(food.image),
      //   //image: = null ? Image.network('https://picsum.photos/250?image=9') AssetImage(food.image),
      //   fit: BoxFit.fill,
      // ),
    );
  }
  Widget buildTitle() {
    return Container(
      padding: const EdgeInsets.only(top: 5.0, left: 5, right: 16),
      child: Text(
        food.name,
        // maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 13/*ScreenUtil().setSp(13, allowFontScalingSelf: true)*/, fontWeight: FontWeight.w500),
      ),
    );
  }
  Widget buildPriceInfo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, top: 5.0, left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Ksh ${food.price}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16/*ScreenUtil().setSp(16, allowFontScalingSelf: true)*/,
            ),
          ),
          Container(
            width: 35/*ScreenUtil().setWidth(35)*/,
            height: 30/*ScreenUtil().setHeight(30)*/,
            decoration: new BoxDecoration(
              color: mainColor,
              borderRadius: new BorderRadius.circular(5.0),
            ),
            child: Consumer<Cart>(
              builder: (context, myModel, child) {
                return InkWell(
                  onTap: () {
                    final snackBar = SnackBar(
                      content: Text('${food.name} added to cart'),
                      duration: Duration(milliseconds: 1000),
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                    CartModel cartModel = CartModel(food: food, quantity: 1);
                    myModel.addItem(cartModel);
                  },
                  customBorder: roundedRectangle,
                  child: Icon(Icons.add, size: 30,color: Colors.white),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}
