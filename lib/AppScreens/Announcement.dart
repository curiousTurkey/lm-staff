import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Models/StaffModel.dart';
import '../Resources/AnnouncementMethod.dart';
import '../ReusableUtils/Appbar.dart';
import '../ReusableUtils/Colors.dart';
import '../ReusableUtils/ExpandedTextBox.dart';
import '../ReusableUtils/HeightWidth.dart';
import '../ReusableUtils/Responsive.dart';
import '../ReusableUtils/SnackBar.dart';
import '../ReusableUtils/TextFormField.dart';
import '../Staff Provider/StaffProvider.dart';

class Announcement extends StatefulWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  bool isLoading = false;
  bool isForStudents = true;
  bool isForStaff = false;
  late String whichSem;
  @override
  void dispose(){
    super.dispose();
    _subjectController.dispose();
    _bodyController.dispose();
  }
  DateTime date = DateTime.now();
  var format = DateFormat('yyyy-MM-dd');
  //function to give class announcement
  void classAnnouncement ({
    required String subject,
    required String body,
    required String isForStudents,
    required String isForStaff,
    required String date,
    required String announcerImage,
    required String announcerName,
    required String whichSem
  }) async {
    setState(() {
      isLoading = true;
    });
    String finalResult = await AnnouncementMethods().announcementTeacher(
        subject: subject,
        body: body,
        isStudent: isForStudents,
        isTeacher: isForStaff,
        date: date,
        announcerImage: announcerImage,
        announcerName: announcerName,
        whichSem: whichSem);
    if(finalResult == "success") {
      snackBar(content: "Announcement sent successfully", duration: 2000, context: context);
    }
    else{
      snackBar(content: finalResult, duration: 2000, context: context);
    }
    setState(() {
      isLoading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    StaffModel staffModel = Provider.of<StaffProvider>(context).getStaff;
    whichSem = staffModel.semClassTeacher;
    String announcerImage = staffModel.imageUrl;
    String announcerName = staffModel.fullName;
    String formattedDate = format.format(date);
    return Scaffold(
      appBar: appBar(context: context, title: 'Class Announcement'),
      body: SingleChildScrollView(
        physics: (MediaQuery.of(context).viewInsets.bottom != 0)
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            verticalSpace(100, context),
            SizedBox(
              width: getWidth(context)-screenLayout(20, context),
              child: TextForm(
                  textEditingController: _subjectController,
                  prefixIcon: const Icon(Icons.notifications_rounded),
                  textInputType: TextInputType.text,
                  labelText: 'Subject',
                  hintText: 'Announcement Subject'),
            ),
            verticalSpace(40, context),
            SizedBox(
              width: getWidth(context)-screenLayout(20, context),
              child: ExpandedTextForm(
                  textEditingController: _bodyController,
                  prefixIcon: const Icon(Icons.text_fields_rounded),
                  textInputType: TextInputType.text,
                  labelText: 'Details',
                  hintText: 'Details of announcement'),
            ),
            verticalSpace(100, context),
            verticalSpace(300, context),
            Container(
                padding: EdgeInsets.symmetric(
                    vertical: screenLayout(25, context),
                    horizontal: screenLayout(25, context)),
                width: double.infinity,
                child: FloatingActionButton(
                  onPressed: () {
                    if(_subjectController.text.isEmpty||
                        _bodyController.text.isEmpty
                    ){
                      snackBar(content: 'Provide all fields', duration: 1500, context: context);
                    }
                    else {
                      classAnnouncement(
                          subject: _subjectController.text,
                          body: _bodyController.text,
                          isForStudents: isForStudents.toString(),
                          isForStaff: isForStaff.toString(),
                          date: formattedDate.toString(),
                          announcerImage: announcerImage,
                          announcerName: announcerName,
                          whichSem: whichSem);
                    }
                  },
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        screenLayout(25, context)),
                  ),
                  backgroundColor: secondaryColor,
                  enableFeedback: true,
                  child: (isLoading==false)?Text('Announce !',
                    style: TextStyle(
                      fontSize: screenLayout(26, context),
                      fontWeight: FontWeight.w500,
                    ),
                  ):SpinKitCircle(
                    color: primaryColor,
                    size: screenLayout(50, context),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
