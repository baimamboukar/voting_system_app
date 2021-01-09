import 'package:Electchain/models/add_vote_option.dart';
import 'package:Electchain/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ElectionModel {
  String accessCode;
  String name;
  String description;
  UserModel owner;
  String startDate;
  String endDate;
  List<dynamic> options;

  ElectionModel(
      {this.name,
      this.description,
      this.owner,
      this.startDate,
      this.endDate,
      this.accessCode,
      this.options});

  ElectionModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id:
    doc.id;
    name:
    doc['name'];
    description:
    doc['description'];
    startDate:
    doc['startDate'];
    startDate:
    doc['startDate'];
    endDate:
    doc['endDate'];
    options:
    doc['options'];
  }
}
