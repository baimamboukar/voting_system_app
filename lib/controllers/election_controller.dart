import 'dart:math';

import 'package:Electchain/models/models.dart';
import 'package:Electchain/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//Function to generate the vote access code as a mix of number and sting

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _random = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_random.nextInt(_chars.length))));

class ElectionController extends GetxController {
  Rx<ElectionModel> _electionModel = ElectionModel().obs;
  ElectionModel currentElection = ElectionModel();

  ElectionModel get election => _electionModel.value;

  set election(ElectionModel value) => this._electionModel.value = value;

  bool endElection() {
    _electionModel.value.endDate = DateTime.now().toString();
    return true;
  }

  ElectionModel fromDocumentSnapshot(DocumentSnapshot doc) {
    ElectionModel _election = ElectionModel();
    _election.id = doc.id;
    _election.accessCode = doc['accessCode'];
    _election.description = doc['description'];
    _election.endDate = doc['endDate'];
    _election.name = doc['name'];
    _election.options = doc['options'];
    _election.startDate = doc['startDate'];
    return _election;
  }

  createElection(name, description, startDate, endDate) {
    ElectionModel election = ElectionModel(
        accessCode: getRandomString(6),
        name: name,
        description: description,
        startDate: startDate,
        endDate: endDate);
    DataBase().createElection(election);
  }

  candidatesStream(String _uid, String _electionId) {
    DataBase().candidatesStream(_uid, _electionId);
  }

  copyAccessCode(String code) {
    //how to copy to the clipboard using dart
    Clipboard.setData(ClipboardData(text: code));
    Get.snackbar(
      'COPYING ACCESS CODE',
      'Access code copied successfully',
      backgroundColor: Colors.green,
      snackPosition: SnackPosition.TOP,
      barBlur: 0.0,
      overlayBlur: 0.0,
      margin: const EdgeInsets.only(top: 200.0),
      icon: Icon(
        Icons.check_circle,
        color: Colors.green,
      ),
      backgroundGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.indigo[300], Colors.blue]),
    );
  }

  getElection(String _uid, String _electionID) {
    DataBase().getElection(_uid, _electionID).then(
        (_election) => Get.find<ElectionController>().election = _election);
  }
}
