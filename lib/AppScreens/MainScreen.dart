import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lms_staff/AppScreens/LeaveHistory.dart';
import 'package:lms_staff/AppScreens/LeaveStatus.dart';
import 'package:lms_staff/AppScreens/Profile.dart';
import 'package:lms_staff/AppScreens/ViewDepartmentAnnouncement.dart';
import 'package:lms_staff/Models/StaffModel.dart';
import 'package:lms_staff/ReusableUtils/Colors.dart' as color_mode;
import 'package:lms_staff/Staff%20Provider/StaffProvider.dart';
import 'package:provider/provider.dart';

import 'HomePage.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  late PageController pageController ;
  @override
  void dispose(){
    super.dispose();
    pageController.dispose();
  }
  @override
  void initState(){
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  }
  void onTap(index){
    setState(() {
      selectedIndex = index;
      pageController.animateToPage(selectedIndex, duration: const Duration(milliseconds: 50), curve: Curves.linearToEaseOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(value: SystemUiOverlayStyle(
        systemNavigationBarColor: color_mode.secondaryColor,
        systemNavigationBarIconBrightness: Brightness.light),
      child:Scaffold(
        body: PageView(
          controller: pageController,
          onPageChanged: (selectedIndex){
            setState(() {
              this.selectedIndex = selectedIndex;
            });
          },
          children: const [
            HomeScreen(),
            LeaveHistory(),
            DepartmentAnnouncement(),
            LeaveStatus(),
            ProfileScreen()
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          onTap: onTap,
          backgroundColor: color_mode.primaryColor,
          elevation: 5,
          enableFeedback: true,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(color: color_mode.secondaryColor),
          selectedIconTheme: IconThemeData(
            color: color_mode.primaryColor,
            opacity: 1,
          ),
          unselectedIconTheme: const IconThemeData(
            color: Colors.grey,
            opacity: 1,
          ),
          currentIndex: selectedIndex,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined,size: 21,),
              label: "Home",
              activeIcon: Icon(Icons.home,color: color_mode.secondaryColor2,size: 27,),
              backgroundColor: color_mode.primaryColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(FontAwesomeIcons.history,size: 19,),
              label: "Leave History",
              activeIcon:Icon(FontAwesomeIcons.history,color: color_mode.secondaryColor2,size: 24,),
              backgroundColor: color_mode.primaryColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(FontAwesomeIcons.bell,size: 19,),
              label: "Department Announcements",
              activeIcon:Icon(Icons.notifications_active,color: color_mode.secondaryColor2,size: 27,),
              backgroundColor: color_mode.primaryColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(FontAwesomeIcons.barsProgress,size: 19,),
              label: "Leave Status",
              activeIcon:Icon(FontAwesomeIcons.barsProgress,color: color_mode.secondaryColor2,size: 24,),
              backgroundColor: color_mode.primaryColor,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline_outlined,size: 20,),
              label: "Profile",
              activeIcon:Icon(Icons.person,color: color_mode.secondaryColor2,size: 26,),
              backgroundColor: color_mode.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
