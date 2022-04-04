import 'package:lms_staff/AppScreens/LeaveApplication.dart';
import 'package:lms_staff/AppScreens/StaffLogin.dart';
import 'package:lms_staff/Resources/StaffAuthMethods.dart';
import 'package:lms_staff/ReusableUtils/Responsive.dart' as resize;
import 'package:lms_staff/ReusableUtils/Colors.dart' as color_mode;
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter/material.dart';
import 'package:lms_staff/ReusableUtils/Side%20transition.dart';
import 'package:provider/provider.dart';
import '../../Models/StaffModel.dart';
import '../../Staff Provider/StaffProvider.dart';
import '../Responsive.dart';
import 'package:lms_staff/ReusableUtils/SidebarListTile.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {

  logoutStaff() async {
    await showDialog(
        barrierColor: Colors.white70,
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            backgroundColor: color_mode.primaryColor,
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            title: Text('Do you want to log out?',
              style:  TextStyle(
                color:  color_mode.unImportant,
                fontSize: resize.screenLayout(25, context),
                fontWeight: FontWeight.w700,
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
                }, child: Text('Cancel',
                style: TextStyle(
                  color: color_mode.secondaryColor2,
                  fontWeight: FontWeight.w500
                ),
              )),
              TextButton(onPressed: () async {
                Navigator.pop(context);
               String finalResult =  await StaffAuthMethod().logoutStaff();
               if(finalResult == "success"){
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const StaffSignin()));
               }
              }, child: Text('Log out',
                style: TextStyle(
                    color: color_mode.secondaryColor2,
                    fontWeight: FontWeight.w500
                ),
              ))
            ],

          );
    });
  }
  @override
  Widget build(BuildContext context) {
    StaffModel staffModel = Provider.of<StaffProvider>(context).getStaff;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: screenLayout(340, context),
            child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                    image:  DecorationImage(
                        image: AssetImage('assets/background/image.jpg'),
                        fit: BoxFit.cover,
                        isAntiAlias: true,
                        filterQuality: FilterQuality.high
                    )
                ),
                accountName: Text(staffModel.fullName,
                  style: TextStyle(color: color_mode.tertiaryColor,
                      fontWeight: FontWeight.bold
                  ),
                ),
                accountEmail: Text(staffModel.emailAddress,
                  style: TextStyle(color: color_mode.tertiaryColor,
                      fontWeight: FontWeight.bold
                  ),
                ),
                currentAccountPicture: Padding(
                  padding: EdgeInsets.zero,
                  child: CircleAvatar(
                    backgroundColor: Colors.white10,
                    radius: screenLayout(120, context),
                   // backgroundImage: NetworkImage(),
                    child: (staffModel.imageUrl=="null")?Initicon(
                      borderRadius: BorderRadius.circular(50),
                      text: staffModel.fullName,
                      color: Colors.white,
                      backgroundColor: Colors.black87,
                      size: 90,
                    ):null,
                  ),
                ),
            ),
          ),
          Divider(
            color: color_mode.unImportant,
            thickness: 1,
          ),
          sidebarListTile(
              leadingIcon: Icons.home_outlined,
              title: 'Home',
              onTap: (){
                Navigator.pop(context);
              }),
          (staffModel.isClassTeacher == true)?
          sidebarListTile(
              leadingIcon: Icons.sms_failed_outlined,
              title: 'Class Announcement',
              onTap: (){
                Navigator.pop(context);
              }):const SizedBox(height: 0,),(staffModel.isClassTeacher == true)?
          sidebarListTile(
              leadingIcon: Icons.newspaper_outlined,
              title: 'Approve Student Leave',
              onTap: (){
                Navigator.pop(context);
              }):const SizedBox(height: 0,),
          (staffModel.isClassTeacher == true)?
          sidebarListTile(
              leadingIcon: Icons.table_chart_outlined,
              title: "Today's Time Table",
              onTap: (){
                Navigator.pop(context);
              }):const SizedBox(height: 0,),
          sidebarListTile(
              title: 'Apply Leave',
              leadingIcon: Icons.newspaper_outlined,
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, CustomPageRouteSide(child: const LeaveApply()));
              }),
          sidebarListTile(
              title: 'Leave Status',
              leadingIcon: Icons.next_week_outlined,
              onTap: (){
                Navigator.pop(context);
              }),
          sidebarListTile(
              title: 'Leave History',
              leadingIcon: Icons.history,
              onTap: (){
                Navigator.pop(context);
              }),
          sidebarListTile(
              title: 'Profile',
              leadingIcon: Icons.person_outline_outlined,
              onTap: (){
                Navigator.pop(context);
              }),
          Divider(
            color: color_mode.unImportant,
            thickness: 1,
          ),
          sidebarListTile(
              title: 'Logout',
              leadingIcon: Icons.logout_outlined,
              onTap:(){
                logoutStaff();
              }
          ),
        ],
      ),
    );
  }
}
