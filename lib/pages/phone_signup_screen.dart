// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:ration_app/constants/colors.dart';
// import 'phone_otp_screen.dart';
//
// class PhoneSignUpScreen extends StatefulWidget {
//   @override
//   _PhoneSignUpScreenState createState() => _PhoneSignUpScreenState();
// }
//
// class _PhoneSignUpScreenState extends State<PhoneSignUpScreen> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: mainColor,
//         title: Text(
//           "Enter your phone number",
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 20,
//             fontFamily: 'Sofia Pro',
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               //Logo
//               Image(
//                 height: 100.0,
//                 width: 250.0,
//                 image: AssetImage('assets/goceri_logo.png'),
//                 fit: BoxFit.cover,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
//                 child: Text(
//                   "SHOP WITH CONVENIENCE",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontFamily: 'Sofia Pro',
//                     fontWeight: FontWeight.w900,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30),
//               //We will send Text
//               Padding(
//                 padding: const EdgeInsets.only(left: 15, right: 15),
//                 child: Text(
//                   "We will send you an SMS message to verify your phone number.",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontFamily: 'Sofia Pro',
//                     fontWeight: FontWeight.w300,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30),
//               //Phone No. Input
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 25),
//                 child: Container(
//                   decoration: new BoxDecoration(
//                     color: Colors.white,
//                     border: new Border.all(color: Colors.grey, width: 1.0, style: BorderStyle.solid),
//                     borderRadius: new BorderRadius.circular(5.0),
//                   ),
//                   child: Row(
//                     children: [
//                       CountryCodePicker(
//                         initialSelection: 'KE',
//                         showFlag: true,
//                         alignLeft: false,
//                         flagWidth: 25,
//                         enabled: false,
//                       ),
//                       Expanded(
//                         child: TextFormField(
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(9),
//                           ],
//                           keyboardType: TextInputType.number,
//                           decoration: new InputDecoration(
//                             hintText: 'Enter Phone',
//                             border: InputBorder.none,
//                             focusedBorder: InputBorder.none,
//                             enabledBorder: InputBorder.none,
//                             errorBorder: InputBorder.none,
//                             disabledBorder: InputBorder.none,
//                             contentPadding:
//                             EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               //Submit Button
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Center(
//                   child: Container(
//                     height: 40,
//                     width: 100,
//                     child: FlatButton(
//                       color: mainColor,
//                       textColor: Colors.black,
//                       padding: EdgeInsets.all(8.0),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5)),
//                       child: Text("SUBMIT", style: TextStyle(fontSize: 15,)),
//                       onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(builder: (context) => PhoneOTPScreen()),);
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
