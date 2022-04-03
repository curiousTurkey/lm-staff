import 'package:flutter/material.dart';
import 'package:lms_staff/AppScreens/StaffLogin.dart';
import 'package:lms_staff/Models/StaffModel.dart';
import 'package:lms_staff/Resources/StaffAuthMethods.dart';
import 'package:lms_staff/ReusableUtils/Colors.dart' as color_mode;
import 'package:lms_staff/ReusableUtils/Side%20transition.dart';
import 'package:lms_staff/Staff%20Provider/StaffProvider.dart';
import 'package:provider/provider.dart';
import '../ReusableUtils/Staff/SideBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState(){
    if(mounted) {
      super.initState();
      addStaffData();
    }
  }
  addStaffData ()async{
    StaffProvider _staffProvider = Provider.of(context,listen: false);
    await _staffProvider.refreshStaff();
  }
  void logoutStaff() async {
    String finalResult = await StaffAuthMethod().logoutStaff();
    if(finalResult == "success"){
      Navigator.pushReplacement(context, CustomPageRouteSide(child: const StaffSignin()));
    }
  }
  @override
  Widget build(BuildContext context) {
    StaffModel staffModel = Provider.of<StaffProvider>(context).getStaff;
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        drawer: const SideBar(),
        backgroundColor: color_mode.primaryColor,
        body: Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.menu_rounded),
                onPressed: () {
                  _globalKey.currentState?.openDrawer();
                },),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text("Welcome " + staffModel.fullName)),
                  FloatingActionButton(onPressed: logoutStaff,child: const Text('Logout'),),
                ],
              ),
            ]
        ),
      ),
    );
  }
}
