import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lms_staff/AppScreens/LeaveApplication.dart';
import 'package:lms_staff/AppScreens/StaffLogin.dart';
import 'package:lms_staff/Models/StaffModel.dart';
import 'package:lms_staff/Resources/StaffAuthMethods.dart';
import 'package:lms_staff/ReusableUtils/Colors.dart' as color_mode;
import 'package:lms_staff/ReusableUtils/HeightWidth.dart';
import 'package:lms_staff/ReusableUtils/HomeScreenContainer/HomeScreenContainer.dart';
import 'package:lms_staff/ReusableUtils/PageView/PageView.dart';
import 'package:lms_staff/ReusableUtils/Responsive.dart';
import 'package:lms_staff/ReusableUtils/Side%20transition.dart';
import 'package:lms_staff/Staff%20Provider/StaffProvider.dart';
import 'package:provider/provider.dart';
import '../ReusableUtils/Staff/SideBar.dart';
import 'package:dots_indicator/dots_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    if (mounted) {
      super.initState();
      addStaffData();
    }
  }

  addStaffData() async {
    StaffProvider _staffProvider = Provider.of(context, listen: false);
    await _staffProvider.refreshStaff();
  }

  void logoutStaff() async {
    String finalResult = await StaffAuthMethod().logoutStaff();
    if (finalResult == "success") {
      Navigator.pushReplacement(
          context, CustomPageRouteSide(child: const StaffSignin()));
    }
  }

  void applyLeave() {
    Navigator.push(context, CustomPageRouteSide(child: const LeaveApply()));
  }

  @override
  Widget build(BuildContext context) {
    StaffModel staffModel = Provider.of<StaffProvider>(context).getStaff;
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        drawer: const SideBar(),
        backgroundColor: color_mode.primaryColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                pinned: true,
                floating: false,
                snap: false,
                backgroundColor: color_mode.secondaryColor2,
                shadowColor: color_mode.tertiaryColor,
                elevation: 2,
                expandedHeight: getHeight(context) / 2.8,
                flexibleSpace: const FlexibleSpaceBar(
                  background: ScrollPageView(),
                )),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenLayout(30, context),
                    vertical: screenLayout(30, context)),
              ),
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenLayout(80, context),),
                  Padding(
                    padding: EdgeInsets.only(left: screenLayout(20, context)),
                    child: Text(
                      "All Services",
                      style: TextStyle(
                          color: color_mode.tertiaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: screenLayout(40, context),
                          letterSpacing: 1.5),
                    ),
                  ),
                  SizedBox(
                    height: screenLayout(40, context),
                  ),
                  Wrap(
                    runSpacing: screenLayout(10, context),
                    spacing: screenLayout(10, context),
                    children: [
                      homeContainer(
                          context: context,
                          description: "Class announcement",
                          heading: "Announcement",
                          icon: FontAwesomeIcons.bell,
                          onTap: () {}),
                      homeContainer(
                          context: context,
                          description: "Approve students leave",
                          heading: "Leave Approval",
                          icon: FontAwesomeIcons.newspaper,
                          onTap: () {}),
                      homeContainer(
                          context: context,
                          description: "Publish timetable",
                          heading: "TimeTable",
                          icon: FontAwesomeIcons.calendar,
                          onTap: () {}),
                      homeContainer(
                          context: context,
                          description: "Apply for leave",
                          heading: "Leave Application",
                          icon: FontAwesomeIcons.paperPlane,
                          onTap: applyLeave),
                      homeContainer(
                          context: context,
                          description: "Status of leave",
                          heading: "Leave Status",
                          icon: FontAwesomeIcons.barsProgress,
                          onTap: () {}),
                      homeContainer(
                          context: context,
                          description: "History of leave",
                          heading: "Leave History",
                          icon: FontAwesomeIcons.history,
                          onTap: () {}),

                    ],
                  ),
                  SizedBox(height: screenLayout(100, context),),
                ],
              );
            }, childCount: 1)),
          ],
        ),
      ),
    );
  }
}
