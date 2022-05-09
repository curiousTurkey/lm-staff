import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lms_staff/ReusableUtils/Appbar.dart';
import 'package:lms_staff/ReusableUtils/Colors.dart' as color_mode;
import 'package:lms_staff/ReusableUtils/HeightWidth.dart';
import 'package:lms_staff/ReusableUtils/Responsive.dart' as resize;

import '../ReusableUtils/Responsive.dart';

class DepartmentAnnouncement extends StatefulWidget {
  const DepartmentAnnouncement({Key? key}) : super(key: key);

  @override
  State<DepartmentAnnouncement> createState() => _DepartmentAnnouncementState();
}

class _DepartmentAnnouncementState extends State<DepartmentAnnouncement> {
  void showDetails({
  required String announcerName,
    required String announceSubject,
    required String announceBody,
    required String announcerImage,
    required String date,
}) async {
    await showDialog(
        barrierColor: Colors.white70,
        context: context,
        builder: (_,){
          return AlertDialog(
            
            insetPadding: const EdgeInsets.all(10),
            backgroundColor: color_mode.primaryColor,
            elevation: 20,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            ),
            title: Text("Subject: $announceSubject \nDate : $date" , style:
              TextStyle(
                fontSize: resize.screenLayout(30, context),
                color: color_mode.secondaryColor,
                fontWeight: FontWeight.w700
              ),),
            content: SizedBox(
              width: resize.screenLayout(500, context),
              height: resize.screenLayout(600, context),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          maxRadius: resize.screenLayout(70, context),
                            backgroundImage: (announcerImage == 'notset')?
                            null:
                            NetworkImage(announcerImage)),
                        SizedBox(width: resize.screenLayout(80, context),),
                        Text(announcerName,
                          style: TextStyle(
                            fontSize: resize.screenLayout(30, context),
                            color: color_mode.spclColor2,
                            fontWeight: FontWeight.w700
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: resize.screenLayout(50, context),),
                    SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(announceBody,
                              style: TextStyle(
                                fontSize: resize.screenLayout(28, context)
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: resize.screenLayout(200, context),),
                    TextButton(onPressed:() {
                      Navigator.pop(context);
                      }, child: Text('Close',
                    style: TextStyle(
                      color: color_mode.secondaryColor,
                      fontSize: resize.screenLayout(35, context),
                      fontWeight: FontWeight.w800
                    ),))
                  ],
                ),
              ),
            ),
          );
    });
  }
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> leaveList = FirebaseFirestore.instance.collection('announcement').where('isForTeacher', isEqualTo: 'true').snapshots();
    return Scaffold(
      appBar: appBar(context: context, title: 'Department Announcements'),
      body: StreamBuilder<QuerySnapshot>(
        stream: leaveList,
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot){
          if (snapshot.hasError) {
            return const Text('Something went wrong. Try again later.');
          }
          else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: SpinKitFoldingCube(
              color: color_mode.secondaryColor,
              size: resize.screenLayout(80, context),
              duration: const Duration(milliseconds: 1500),
            ));
          }
          else if(!snapshot.hasData){
            return const Text('No data');
          }
          int itemCount = snapshot.data!.size;
          return ListView.builder(
              itemCount: itemCount,
              itemBuilder: (_, int index){
                String docId = snapshot.data!.docs[index].id;
                String name = snapshot.data!.docs[index]['announcername'];
                String subject = snapshot.data!.docs[index]['announcesub'];
                String body = snapshot.data!.docs[index]['announcebody'];
                String imageUrl = snapshot.data!.docs[index]['announcerImage'];
                String announceDate = snapshot.data!.docs[index]['announcedate'];
                return ListTile(
                  minVerticalPadding: resize.screenLayout(50, context),
                  title: Text(subject),
                  leading: (imageUrl == 'notset') ? Initicon(
                    borderRadius: BorderRadius.circular(
                        screenLayout(10, context)),
                    text: name,
                    size: resize.screenLayout(90, context),
                    elevation: 5,
                  ) : Image.network(imageUrl,
                    width: resize.screenLayout(90, context),
                    height: resize.screenLayout(100, context),),
                  onTap: (){
                    showDetails(announcerName: name,
                        announceSubject: subject,
                        announceBody: body,
                        announcerImage: imageUrl,
                        date: announceDate);
                  },
                );
              });
        },
      ),
    );
  }
}
