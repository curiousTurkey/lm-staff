import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lms_staff/Resources/TimeTableMethods.dart';
import 'package:lms_staff/ReusableUtils/Appbar.dart';
import 'package:lms_staff/ReusableUtils/HeightWidth.dart';
import 'package:lms_staff/ReusableUtils/SnackBar.dart';
import 'package:provider/provider.dart';

import '../Models/StaffModel.dart';
import '../ReusableUtils/Colors.dart';
import '../ReusableUtils/Responsive.dart';
import '../Staff Provider/StaffProvider.dart';

class TimeTablePublish extends StatefulWidget {
  const TimeTablePublish({Key? key}) : super(key: key);

  @override
  State<TimeTablePublish> createState() => _TimeTablePublishState();
}

class _TimeTablePublishState extends State<TimeTablePublish> {

  bool isLoading = false;
  String subject1 = "Select Subject";
  String subject2 = 'Select Subject';
  String subject3 = 'Select Subject';
  String subject4 = 'Select Subject';
  String subject5 = 'Select Subject';
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(value: item, child: Text(item),);

  void publishTimeTable ({
  required String subject1,
    required String subject2,
    required String subject3,
    required String subject4,
    required String subject5,
    required String semester,
}) async {
    setState(() {
      isLoading = true;
    });
    String finalResult = await TimeTableMethods().timetablePublish(
        subject1: subject1,
        subject2: subject2,
        subject3: subject3,
        subject4: subject4,
        subject5: subject5,
        semester: semester);
    if(finalResult == "success") {
      snackBar(content: 'TimeTable Published', duration: 2000, context: context);
      setState(() {
        isLoading = false;
      });
    }
    else{
      snackBar(content: finalResult, duration: 2000, context: context);
    }
  }
  @override
  Widget build(BuildContext context) {

    final TextStyle textStyle = TextStyle(
        fontSize: screenLayout(28, context),
        fontWeight: FontWeight.w600,
        color: tertiaryColor
    );

    String sub1 = '',sub2 = '',sub3 ='' , sub4 ='' , sub5 = '';
    StaffModel staffModel = Provider.of<StaffProvider>(context).getStaff;
    String sem = staffModel.semClassTeacher;
    final Stream<DocumentSnapshot<Map<String, dynamic>>> subjects =
                                FirebaseFirestore.instance.collection('Computer Applications').doc(sem).snapshots();
    return Scaffold(
      appBar: appBar(context: context, title: 'Time Table'),
      body: StreamBuilder<Object>(
        stream: subjects,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return const Center(
              child: Text('Error 504 , Server side issue'),
            );
          }
          if(snapshot.hasData){
            var data = snapshot.data as DocumentSnapshot ;
            sub1 = data['Subject 1'];
            sub2 = data['Subject 2'];
            sub3 = data['Subject 3'];
            sub4 = data['Subject 4'];
            sub5 = data['Subject 5'];
            final List<String> subjectList = ['Select Subject', sub1,sub2,sub3,sub4,sub5];
            print(staffModel.semClassTeacher);
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Hour 1 : ',
                      style: textStyle,
                    ),
                    Container(
                      height: screenLayout(70, context),
                      width: getWidth(context)-screenLayout(200, context),
                      padding: EdgeInsets.all(screenLayout(20, context)),
                      decoration: const BoxDecoration(
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            dropdownColor: primaryColor,
                            focusColor: primaryColor,
                            style: TextStyle(fontSize: screenLayout(30, context),
                                color: secondaryColor,
                                fontWeight: FontWeight.w600
                            ),
                            borderRadius: BorderRadius.circular(screenLayout(20, context)),
                            iconDisabledColor: Colors.grey,
                            iconEnabledColor: secondaryColor,
                            icon: const Icon(Icons.arrow_downward_rounded),
                            enableFeedback: true,
                            hint: const Text('Select Department'),
                            isExpanded: true,
                            items: subjectList.map(buildMenuItem).toList(),
                            value: subject1,
                            onChanged: (val) {
                              setState(() {
                                subject1 = val!;
                                print(subject1);
                              });
                            }
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(50, context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Hour 2 : ',
                      style: textStyle,
                    ),
                    Container(
                      height: screenLayout(70, context),
                      width: getWidth(context)-screenLayout(200, context),
                      padding: EdgeInsets.all(screenLayout(20, context)),
                      decoration: const BoxDecoration(
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            dropdownColor: primaryColor,
                            focusColor: primaryColor,
                            style: TextStyle(fontSize: screenLayout(30, context),
                                color: secondaryColor,
                                fontWeight: FontWeight.w600
                            ),
                            borderRadius: BorderRadius.circular(screenLayout(20, context)),
                            iconDisabledColor: Colors.grey,
                            iconEnabledColor: secondaryColor,
                            icon: const Icon(Icons.arrow_downward_rounded),
                            enableFeedback: true,
                            hint: const Text('Select Department'),
                            isExpanded: true,
                            items: subjectList.map(buildMenuItem).toList(),
                            value: subject2,
                            onChanged: (val) {
                              setState(() {
                                subject2 = val!;
                                print(subject2);
                              });
                            }
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(50, context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Hour 3 : ',
                      style: textStyle,
                    ),
                    Container(
                      height: screenLayout(70, context),
                      width: getWidth(context)-screenLayout(200, context),
                      padding: EdgeInsets.all(screenLayout(20, context)),
                      decoration: const BoxDecoration(
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            dropdownColor: primaryColor,
                            focusColor: primaryColor,
                            style: TextStyle(fontSize: screenLayout(30, context),
                                color: secondaryColor,
                                fontWeight: FontWeight.w600
                            ),
                            borderRadius: BorderRadius.circular(screenLayout(20, context)),
                            iconDisabledColor: Colors.grey,
                            iconEnabledColor: secondaryColor,
                            icon: const Icon(Icons.arrow_downward_rounded),
                            enableFeedback: true,
                            hint: const Text('Select Department'),
                            isExpanded: true,
                            items: subjectList.map(buildMenuItem).toList(),
                            value: subject3,
                            onChanged: (val) {
                              setState(() {
                                subject3 = val!;
                                print(subject3);
                              });
                            }
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(50, context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Hour 4 : ',
                      style: textStyle,
                    ),
                    Container(
                      height: screenLayout(70, context),
                      width: getWidth(context)-screenLayout(200, context),
                      padding: EdgeInsets.all(screenLayout(20, context)),
                      decoration: const BoxDecoration(
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            dropdownColor: primaryColor,
                            focusColor: primaryColor,
                            style: TextStyle(fontSize: screenLayout(30, context),
                                color: secondaryColor,
                                fontWeight: FontWeight.w600
                            ),
                            borderRadius: BorderRadius.circular(screenLayout(20, context)),
                            iconDisabledColor: Colors.grey,
                            iconEnabledColor: secondaryColor,
                            icon: const Icon(Icons.arrow_downward_rounded),
                            enableFeedback: true,
                            hint: const Text('Select Department'),
                            isExpanded: true,
                            items: subjectList.map(buildMenuItem).toList(),
                            value: subject4,
                            onChanged: (val) {
                              setState(() {
                                subject4 = val!;
                                print(subject4);
                              });
                            }
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace(50, context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Hour 5 : ',
                      style: textStyle,
                    ),
                    Container(
                      height: screenLayout(70, context),
                      width: getWidth(context)-screenLayout(200, context),
                      padding: EdgeInsets.all(screenLayout(20, context)),
                      decoration: const BoxDecoration(
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                            dropdownColor: primaryColor,
                            focusColor: primaryColor,
                            style: TextStyle(fontSize: screenLayout(30, context),
                                color: secondaryColor,
                                fontWeight: FontWeight.w600
                            ),
                            borderRadius: BorderRadius.circular(screenLayout(20, context)),
                            iconDisabledColor: Colors.grey,
                            iconEnabledColor: secondaryColor,
                            icon: const Icon(Icons.arrow_downward_rounded),
                            enableFeedback: true,
                            hint: const Text('Select Department'),
                            isExpanded: true,
                            items: subjectList.map(buildMenuItem).toList(),
                            value: subject5,
                            onChanged: (val) {
                              setState(() {
                                subject5 = val!;
                                print(subject5);
                              });
                            }
                        ),
                      ),
                    ),
                  ],
                ),verticalSpace(150, context),

                Container(
                    padding: EdgeInsets.symmetric(
                        vertical: screenLayout(25, context),
                        horizontal: screenLayout(25, context)),
                    width: double.infinity,
                    child: FloatingActionButton(
                      onPressed: () {
                        if((subject1 == "Select Subject" || subject1 == "" || subject1 ==" ") ||
                            (subject2 == "Select Subject" || subject2 == "" || subject2 ==" ") ||
                            (subject3 == "Select Subject" || subject3 == "" || subject3 ==" ") ||
                            (subject4 == "Select Subject" || subject4 == "" || subject4 ==" ") ||
                            (subject5 == "Select Subject" || subject5 == "" || subject5 ==" ")
                        ) {
                          snackBar(content: 'Please define all hours', duration: 2000, context: context);
                        }
                        else{
                          publishTimeTable(
                              subject1: subject1,
                              subject2: subject2,
                              subject3: subject3,
                              subject4: subject4,
                              subject5: subject5, semester: staffModel.semClassTeacher);
                        }
                      },
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            screenLayout(25, context)),
                      ),
                      backgroundColor: secondaryColor,
                      enableFeedback: true,
                      child: (isLoading == false) ? Text(
                        'Publish TimeTable !',
                        style: TextStyle(
                          fontSize: screenLayout(26, context),
                          fontWeight: FontWeight.w500,
                        ),
                      ) : SpinKitCircle(
                        color: primaryColor,
                        size: screenLayout(50, context),
                      ),
                    )),
              ],
            );
          }
          else {
            return const Center(
              child: Text(' Data not found'),
            );
          }
        }
      ),
    );
  }
}
