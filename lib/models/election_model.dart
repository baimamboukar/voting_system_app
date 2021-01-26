import 'package:Electchain/models/add_vote_option.dart';
import 'package:Electchain/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ElectionModel {
  String accessCode;
  String name;
  String description;
  String startDate;
  String endDate;
  List<dynamic> options;
  String id;

  ElectionModel(
      {this.name,
      this.description,
      this.startDate,
      this.endDate,
      this.accessCode,
      this.options,
      this.id});

  ElectionModel.fromDocumentSnapshot(DocumentSnapshot doc) {
    id:
    doc.id;
    name:
    doc['name'];
    description:
    doc['description'];
    startDate:
    doc['startDate'];
    endDate:
    doc['endDate'];
    options:
    doc['options'];
    accessCode:
    doc['accessCode'];
  }
}
