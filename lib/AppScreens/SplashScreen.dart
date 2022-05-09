import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lms_staff/AppScreens/MainScreen.dart';
import 'package:lms_staff/AppScreens/StaffLogin.dart';
import 'package:lms_staff/ReusableUtils/Responsive.dart' as resize;
import 'package:lms_staff/ReusableUtils/Colors.dart' as color_mode;
import 'package:provider/provider.dart';

import '../ReusableUtils/Side transition.dart';
import '../Staff Provider/StaffProvider.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState(){
    super.initState();
    nextPage();
  }

  Widget nextPageWidget = const StaffSignin();

  void nextPage() {
    if(_auth.currentUser != null){
      setState(() {
        nextPageWidget = const MainPage();
      });
    }
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => nextPageWidget));
  });
  }
  addStaffData ()async{
    StaffProvider _staffProvider = Provider.of(context,listen: false);
    await _staffProvider.refreshStaff();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image: AssetImage('assets/background/red.jpg'),
            )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
                children: [
                  Center(
                    child: SpinKitRipple(
                      size: resize.screenLayout(350, context),
                      color: color_mode.secondaryColor2,
                      borderWidth: resize.screenLayout(9, context),

                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: resize.screenLayout(75, context)),
                      child: Image.asset('assets/background/teacher.png',
                        width: resize.screenLayout(200, context),
                      ),
                    ),
                  ),
                ]
            ),
          ],
        ),
      ),
    );
  }
}
