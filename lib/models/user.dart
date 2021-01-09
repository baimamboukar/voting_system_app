import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String name;
  String phoneNumber;
  String email;

  UserModel({this.id, this.name, this.phoneNumber, this.email});

  UserModel fromDocumentSnapshot(DocumentSnapshot doc) {
    UserModel _user = UserModel();
    _user.id = doc.id;
    _user.email = doc['email'];
    _user.name = doc['name'];
    _user.phoneNumber = doc['phonenumber'];
    return _user;
  }
}
