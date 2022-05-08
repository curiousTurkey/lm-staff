import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lms_staff/Resources/StaffLeave.dart';
import 'package:lms_staff/ReusableUtils/Colors.dart' as color_mode;
import 'package:lms_staff/ReusableUtils/ExpandedTextForm.dart';
import 'package:lms_staff/ReusableUtils/Responsive.dart' as resize;
import 'package:lms_staff/ReusableUtils/TextFormField.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Models/StaffModel.dart';
import '../ReusableUtils/SnackBar.dart';
import '../Staff Provider/StaffProvider.dart';
class LeaveApply extends StatefulWidget {
  const LeaveApply({Key? key}) : super(key: key);

  @override
  State<LeaveApply> createState() => _LeaveApplyState();
}

class _LeaveApplyState extends State<LeaveApply> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  DateTime date = DateTime.now().toLocal();
   DateTime selectedDate1 = DateTime.now().subtract( const Duration(days: 100));
   DateTime selectedDate2 = DateTime.now().subtract(const Duration(days: 100));
  bool isLoading = false;
  late String name;
  late String deptStaff;
  late String email;

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

  //apply staff leave
  void applyLeave() async {
    setState(() {
      isLoading = true;
    });
    String finalResult = await StaffLeaveMethods().applyLeave(
        fullName: name,
        dept: deptStaff,
        emailAddress: email,
        leaveSubject: _subjectController.text,
        leaveReason: _reasonController.text,
        fromDate: selectedDate1.toString(),
        toDate: selectedDate2.toString(),
        session1: selectedSession1,
        session2: selectedSession2);
    if(finalResult == "success"){
      setState(() {
        isLoading = false;
      });
      snackBar(content: 'Leave Applied Successfully', duration: 1500, context: context);
    }
    else{
      snackBar(content: finalResult, duration: 1500, context: context);
    }
  }

  Future<void> _selectFromDate(BuildContext context) async {
    var format = DateFormat('yyyy-MM-dd');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(date.year),
        lastDate: DateTime(2100));
    if(picked != null && picked.compareTo(date)>=0){
      setState(() {
        String formattedDate = format.format(picked);
        var dateFormatted = DateTime.parse(formattedDate);
        selectedDate1 = dateFormatted;
        print(selectedDate1);
      });
    }
  }
  Future<void> _selectToDate(BuildContext context) async {
    var format = DateFormat('yyyy-MM-dd');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(date.year),
        lastDate: DateTime(2100));
    if(picked != null && picked.compareTo(date)>=0){
      setState(() {
        String formattedDate = format.format(picked);
        var date = DateTime.parse(formattedDate);
        selectedDate2 = date;
        print(selectedDate2);
      });
    }
  }
  final List<String> listItem = ['Select Session','Session 1','Session 2'];
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(value: item, child: Text(item),);
  String selectedSession1 = "Select Session";
  String selectedSession2 = "Select Session";

  var formattedDate = DateFormat('d-MM-yyyy');
    @override
    Widget build(BuildContext context) {
      StaffModel staffModel = Provider.of<StaffProvider>(context).getStaff;
       name = staffModel.fullName;
       email = staffModel.emailAddress;
       deptStaff = staffModel.deptName;
      TextStyle textStyle = TextStyle(color: color_mode.secondaryColor2,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.7);
      return Scaffold(
        appBar: AppBar(
          title: const Text("Leave Application"),
          foregroundColor: color_mode.primaryColor,
          backgroundColor: color_mode.secondaryColor2,
          centerTitle: true,
          titleSpacing: 1.4,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: color_mode.primaryColor,
          ),
          height: double.maxFinite,
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: resize.screenLayout(30, context),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Casual Leave Left : ',
                    style: textStyle,
                  ),
                  Text((15 - (staffModel.casualLeaveTaken)).toString(),
                    style: textStyle,
                  ),
                ],
              ),
              SizedBox(height: resize.screenLayout(55, context),),
              TextForm(
                  textEditingController: _subjectController,
                  prefixIcon: const Icon(Icons.subject_outlined),
                  textInputType: TextInputType.text,
                  labelText: 'Subject',
                  hintText: 'Subject for leave'),
              SizedBox(height: resize.screenLayout(30, context),),
              TextFormExpanded(
                  textEditingController: _reasonController,
                  prefixIcon: const Icon(Icons.text_snippet_outlined),
                  textInputType: TextInputType.text,
                  labelText: 'Reason',
                  hintText: 'Reason for leave'),
              SizedBox(height: resize.screenLayout(25, context),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text('From : ',
                    style: textStyle,
                  ),
                  InkWell(
                    onTap: (){_selectFromDate(context);},
                    child: Container(
                      height: resize.screenLayout(65, context),
                      padding: EdgeInsets.all(resize.screenLayout(15, context)),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: color_mode.spclColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: (selectedDate1.compareTo(date)>0)?Text(formattedDate.format(selectedDate1).toString(),
                        style: TextStyle(
                            fontSize: resize.screenLayout(29, context),
                            color: color_mode.tertiaryColor
                        ),
                      ):Text("Select Date",
                        style: TextStyle(
                            fontSize: resize.screenLayout(29, context),
                            color: color_mode.tertiaryColor
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: resize.screenLayout(40, context),),
                  Container(
                    height: resize.screenLayout(65, context),
                    width: resize.screenLayout(260, context),
                    padding: EdgeInsets.all(resize.screenLayout(14, context)),
                    decoration: BoxDecoration(
                      color: color_mode.spclColor,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(20),
                        focusColor: color_mode.secondaryColor2,
                        enableFeedback: true,
                        hint: const Text('Select session'),
                        isExpanded: true,
                        isDense: true,
                        items: listItem.map(buildMenuItem).toList(),
                        value: selectedSession1,
                        onChanged: (val) {
                          setState(() {
                            selectedSession1 = val!;
                            print(selectedSession1);
                          });
                        }
                    ),
                  ),
                ],
              ),
              SizedBox(height: resize.screenLayout(40, context),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('  To   : ',
                    style: textStyle,
                  ),
                  InkWell(
                    onTap: (){_selectToDate(context);},
                    child: Container(
                      height: resize.screenLayout(65, context),
                      padding: EdgeInsets.all(resize.screenLayout(15, context)),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: color_mode.spclColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: (selectedDate2.compareTo(date)>0)?Text(formattedDate.format(selectedDate2).toString(),
                        style: TextStyle(
                            fontSize: resize.screenLayout(29, context),
                            color: color_mode.tertiaryColor
                        ),
                      ):Text("Select Date",
                        style: TextStyle(
                            fontSize: resize.screenLayout(29, context),
                            color: color_mode.tertiaryColor
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: resize.screenLayout(40, context),),
                  Container(
                    height: resize.screenLayout(65, context),
                    width: resize.screenLayout(260, context),
                    padding: EdgeInsets.all(resize.screenLayout(14, context)),
                    decoration: BoxDecoration(
                        color: color_mode.spclColor,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(20),
                        focusColor: color_mode.secondaryColor2,
                        enableFeedback: true,
                        hint: const Text('Select session'),
                        isExpanded: true,
                        isDense: true,
                        items: listItem.map(buildMenuItem).toList(),
                        value: selectedSession2,
                        onChanged: (val) {
                          setState(() {
                            selectedSession2 = val!;
                            print(selectedSession2);
                          });
                        }
                    ),
                  ),
                ],
              ),
              resize.verticalSpace(180, context),
              Container(
                padding: EdgeInsets.symmetric(vertical: resize.screenLayout(25, context),horizontal: resize.screenLayout(25, context)),
                width: double.infinity,
                child: FloatingActionButton(
                  onPressed: () {
                    print(selectedDate1.compareTo(date));
                    print(selectedDate2.compareTo(date));
                    if(
                    _subjectController.text.isNotEmpty &&
                    _reasonController.text.isNotEmpty &&
                    selectedSession1 != "Select Session" &&
                    selectedSession2 != "Select Session"
                    ){
                      if(selectedDate1.compareTo(date)>0 && selectedDate2.compareTo(date)>0) {
                        applyLeave();
                      }
                      else{

                        snackBar(content: 'Provide valid date', duration: 1500, context: context);
                      }
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
                  child: (isLoading==false)?Text('Apply Leave',
                    style: TextStyle(
                      fontSize: resize.screenLayout(26, context),
                      fontWeight: FontWeight.w500,
                    )
                  ): SpinKitCircle(
                    color: color_mode.primaryColor,
                    size: resize.screenLayout(50, context),
                   ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
