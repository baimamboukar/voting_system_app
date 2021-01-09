import 'package:Electchain/screens/screens.dart';
import 'package:get/get.dart';
import 'package:Electchain/models/add_vote_option.dart';
import 'package:Electchain/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CandidateController extends GetxController {
  CandidateModel fromDocumentSnapshot(DocumentSnapshot doc) {
    CandidateModel _candidate = CandidateModel();
    _candidate.name = doc['name'];
    _candidate.description = doc['description'];
    return _candidate;
  }
}
