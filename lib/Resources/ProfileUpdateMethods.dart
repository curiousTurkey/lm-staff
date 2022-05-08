import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileUpdate{

  Future<String> updateImage({
  required imageUrl,
}) async {
    String finalResult = "Couldn't update Image. Try again Later";
    FirebaseAuth _auth = FirebaseAuth.instance;
    try{
      String? _user = _auth.currentUser!.email;
      await FirebaseFirestore.instance.collection('users').doc(_user).update({
        'imageurl' : imageUrl
      });
      finalResult = "Image upload success.";
      return finalResult;
    } catch(error) {
      finalResult = error.toString();
      return finalResult;
    }
  } //update image

  Future<String> updateContactNumber({required String contactNo}) async {
    String finalResult = "Couldn't update contact number. Try again later.";
    try{
      FirebaseAuth _auth = FirebaseAuth.instance;
      String? _user = _auth.currentUser!.email;
      await FirebaseFirestore.instance.collection('users').doc(_user).update(
          {
            "contact" : contactNo
          });
      return finalResult = "Contact number updated successfully.";
    }
    catch(error){
      finalResult = error.toString();
      return finalResult;
    }
  } //update contact number

  Future<String> updateName({required String name}) async {
    String finalResult = "Couldn't update contact number. Try again later.";
    try{
      FirebaseAuth _auth = FirebaseAuth.instance;
      String? _user = _auth.currentUser!.email;
      await FirebaseFirestore.instance.collection('users').doc(_user).update(
          {
            "name" : name
          });
      return finalResult = "Contact number updated successfully.";
    }
    catch(error){
      finalResult = error.toString();
      return finalResult;
    }
  }

}