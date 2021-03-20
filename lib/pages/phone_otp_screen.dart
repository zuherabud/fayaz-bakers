// import 'package:flutter/material.dart';
// import 'package:ration_app/constants/colors.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
// import 'home_page.dart';
//
//
// class PhoneOTPScreen extends StatefulWidget {
//   @override
//   _PhoneOTPScreenState createState() => _PhoneOTPScreenState();
// }
//
// class _PhoneOTPScreenState extends State<PhoneOTPScreen> {
//   String currentText;
//
//   TextEditingController textEditingController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back_ios),
//           iconSize: 25.0,
//           color: Colors.black,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         centerTitle: true,
//         backgroundColor: mainColor,
//         title: Text(
//           "Verify your phone number",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontFamily: 'Sofia Pro',
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             //We will send Text
//             Text(
//               "SMS message with 6 digit code sent to this phone number ${25479961149}.",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontFamily: 'Sofia Pro',
//                 fontWeight: FontWeight.w300,
//               ),
//             ),
//             SizedBox(height: 30),
//             PinCodeTextField(
//               appContext: context,
//               cursorColor: Colors.grey,
//               enabled: true,
//               length: 6,
//               obscureText: false,
//               animationType: AnimationType.fade,
//               keyboardType: TextInputType.number,
//               pinTheme: PinTheme(
//                 inactiveFillColor: Colors.white,
//                 selectedFillColor: Colors.white,
//                 selectedColor: Colors.white,
//                 shape: PinCodeFieldShape.box,
//                 // borderRadius: BorderRadius.circular(5),
//                 // fieldHeight: 50,
//                 // fieldWidth: 40,
//                 activeFillColor: Colors.white,
//               ),
//               animationDuration: Duration(milliseconds: 300),
//               // backgroundColor: Colors.blue.shade50,
//               enableActiveFill: true,
//               // errorAnimationController: errorController,
//               controller: textEditingController,
//               onCompleted: (v) {
//                 print("Completed");
//               },
//               onChanged: (value) {
//                 print(value);
//                 setState(() {
//                   currentText = value;
//                 });
//               },
//               beforeTextPaste: (text) {
//                 print("Allowing to paste $text");
//                 //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//                 //but you can show anything you want here, like your pop up saying wrong paste format or etc
//                 return true;
//               },
//             ),
//             Text(
//               "Enter 6 digit code",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14,
//                 fontFamily: 'Sofia Pro',
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             SizedBox(height: 30),
//             TextButton(
//               onPressed: () {  },
//               child: Text("Resend SMS",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 15,
//                   fontFamily: 'Sofia Pro',
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//             //Submit Button
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Center(
//                 child: Container(
//                   height: 40,
//                   width: 100,
//                   child: FlatButton(
//                     color: mainColor,
//                     textColor: Colors.black,
//                     padding: EdgeInsets.all(8.0),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5)),
//                     child: Text("NEXT", style: TextStyle(fontSize: 15,)),
//                     onPressed: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()),);
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//
//     );
//   }
// }
