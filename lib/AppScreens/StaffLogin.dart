import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lms_staff/AppScreens/MainScreen.dart';
//import 'package:lm_hod/AppScreens//MainPage.dart';
import 'package:lms_staff/Resources/StaffAuthMethods.dart';
import 'package:lms_staff/ReusableUtils/Responsive.dart' as resize;
import 'package:lms_staff/ReusableUtils/Side%20transition.dart';
import '../../ReusableUtils/SnackBar.dart';
import 'Package:lms_staff/ReusableUtils/Colors.dart' as color_mode;
import 'package:lms_staff/ReusableUtils/HeightWidth.dart' as heightwidth;
import 'package:lms_staff/ReusableUtils/TextFormField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StaffSignin extends StatefulWidget {
  const StaffSignin({Key? key}) : super(key: key);

  @override
  State<StaffSignin> createState() => _StaffSigninState();
}

class _StaffSigninState extends State<StaffSignin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void loginStaff() async {
    setState(() {
      isLoading = true;
    });
    String finalResult = await StaffAuthMethod().loginStaff(
        emailAddress: _emailController.text,
        password: _passwordController.text, userType: 'staff');
    if(finalResult == "success"){
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacement(context, CustomPageRouteSide(child: const MainPage()));
    }
    else {
      setState(() {
        isLoading = false;
      });
      snackBar(content: finalResult, duration: 1500, context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color_mode.primaryColor,
              image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/background/background.jpg'))),
          height: double.maxFinite,
          width: double.maxFinite,
          child: SingleChildScrollView(
            physics: (MediaQuery.of(context).viewInsets.bottom != 0)
                ? const AlwaysScrollableScrollPhysics()
                : const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(resize.screenLayout(70, context)),
                  child: Text(
                    'LMS - Staff',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color_mode.secondaryColor,
                        fontSize: resize.screenLayout(40, context)
                    ),
                  ),
                ),
                Container(
                  height: heightwidth.getHeight(context) / 1.9,
                  width: heightwidth.getWidth(context) / 1.1,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(resize.screenLayout(50, context)),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white10,
                          blurStyle: BlurStyle.normal,
                          blurRadius: 4,
                        ),
                      ],
                      color: color_mode.spclColor.withOpacity(.45)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextForm(
                          textEditingController: _emailController,
                          prefixIcon: const Icon(Icons.alternate_email_outlined),
                          textInputType: TextInputType.emailAddress,
                          labelText: 'E-mail',
                          hintText: 'Provide E-mail'),
                      resize.verticalSpace(25, context),
                      TextForm(
                          textEditingController: _passwordController,
                          prefixIcon: const Icon(Icons.lock_rounded),
                          textInputType: TextInputType.visiblePassword,
                          labelText: 'Password',
                          isPass:true,
                          hintText: 'Min 6 characters'),
                      resize.verticalSpace(40, context),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: resize.screenLayout(25, context),horizontal: resize.screenLayout(25, context)),
                        width: double.infinity,
                        child: FloatingActionButton(
                          onPressed: () {
                            if(_emailController.text.isNotEmpty || _passwordController.text.isNotEmpty){
                             loginStaff();
                            }
                            else{
                              snackBar(content: 'Please provide all fields.', duration: 1500, context: context);
                            }
                          },
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(resize.screenLayout(25, context)),
                          ),
                          backgroundColor: color_mode.secondaryColor,
                          enableFeedback: true,
                          child: (isLoading==false)?Text('Log In',
                            style: TextStyle(
                              fontSize: resize.screenLayout(26, context),
                              fontWeight: FontWeight.w500,
                            ),
                          ):SpinKitCircle(
                            color: color_mode.primaryColor,
                            size: resize.screenLayout(50, context),
                          ),
                        ),
                      ),
                      resize.verticalSpace(25, context),
                    ],
                  ),
                ),
                SizedBox(height: resize.screenLayout(50, context),),
              ],
            ),
          ),
        ));
  }
}
