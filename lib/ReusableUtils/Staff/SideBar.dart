import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lms_staff/AppScreens/Announcement.dart';
import 'package:lms_staff/AppScreens/HomePage.dart';
import 'package:lms_staff/AppScreens/LeaveApplication.dart';
import 'package:lms_staff/AppScreens/LeaveHistory.dart';
import 'package:lms_staff/AppScreens/LeaveStatus.dart';
import 'package:lms_staff/AppScreens/Profile.dart';
import 'package:lms_staff/AppScreens/StaffLogin.dart';
import 'package:lms_staff/AppScreens/StudentLeave.dart';
import 'package:lms_staff/AppScreens/TimeTable.dart';
import 'package:lms_staff/AppScreens/TimeTablePublish.dart';
import 'package:lms_staff/AppScreens/ViewDepartmentAnnouncement.dart';
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
                decoration: BoxDecoration(
                    color: color_mode.secondaryColor2.withOpacity(.9)
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
                    backgroundColor: Colors.transparent,
                    radius: screenLayout(120, context),
                    backgroundImage: (staffModel.imageUrl == 'null')?null:NetworkImage(staffModel.imageUrl),
                    child: (staffModel.imageUrl=="null")?Initicon(
                      borderRadius: BorderRadius.circular(50),
                      text: staffModel.fullName,
                      color: Colors.white,
                      backgroundColor: Colors.black87,
                      size: 120,
                    ):null
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
              }),
          (staffModel.isClassTeacher == true)?
          sidebarListTile(
              leadingIcon: Icons.notifications_outlined,
              title: 'Class Announcement',
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const Announcement()));
              }):const SizedBox(height: 0,),
          (staffModel.isClassTeacher == true)?
          sidebarListTile(
              leadingIcon: Icons.newspaper_outlined,
              title: 'Approve Student Leave',
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const StudentLeave()));
              }):const SizedBox(height: 0,),
          (staffModel.isClassTeacher == true)?
          sidebarListTile(
              leadingIcon: Icons.table_chart_outlined,
              title: "Publish Time Table",
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const TimeTablePublish()));
              }):const SizedBox(height: 0,),
          sidebarListTile(
              title: 'Apply Leave',
              leadingIcon: Icons.newspaper_outlined,
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, CustomPageRouteSide(child: const LeaveApply()));
              }),
          sidebarListTile(
              title: "Today's Time Table",
              leadingIcon: FontAwesomeIcons.tableList,
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, CustomPageRouteSide(child: const ViewTimeTable()));
              }),
          sidebarListTile(
              title: 'Department Announcement',
              leadingIcon: Icons.notification_important_outlined,
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, CustomPageRouteSide(child: const DepartmentAnnouncement()));
              }),
          sidebarListTile(
              title: 'Leave Status',
              leadingIcon: Icons.next_week_outlined,
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const LeaveStatus()));
              }),
          sidebarListTile(
              title: 'Leave History',
              leadingIcon: Icons.history,
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const LeaveHistory()));
              }),
          sidebarListTile(
              title: 'Profile',
              leadingIcon: Icons.person_outline_outlined,
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
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
