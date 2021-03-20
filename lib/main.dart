import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/screenutil.dart';
// import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:provider/provider.dart';
import 'package:ration_app/model/cart_model.dart';
import 'package:ration_app/pages/home_page.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// final firestoreInstance = FirebaseFirestore.instance;

const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Cart>(
        create: (_) => Cart(),
        child: MaterialApp(
          title: 'Flutter Food Ordering',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: white,
          ),
          home: SplashScreen(
              seconds: 4,
              navigateAfterSeconds: MyHomePage(),
              // title: Text(
              //   'Welcome To Fayyaz Order at Home App\nshop at home with Convenience',
              //   style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20/*ScreenUtil().setSp(20, allowFontScalingSelf: true)*/),
              //   textAlign: TextAlign.center,
              // ),
              image: Image.asset('assets/logo.png'),
              backgroundColor: Colors.white,
              styleTextUnderTheLoader: TextStyle(),
              photoSize: 100.0,
              loaderColor: Colors.black
          ),
          //MyHomePage(),
        ),
      );
  }
}
