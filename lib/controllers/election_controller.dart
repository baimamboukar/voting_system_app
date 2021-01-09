import 'dart:math';

import 'package:Electchain/models/models.dart';
import 'package:Electchain/services/database.dart';
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

  set user(ElectionModel value) => this._electionModel.value = value;

  bool endElection() {
    _electionModel.value.endDate = DateTime.now().toString();
    return true;
  }

  createElection(name, description, owner, startDate, endDate) {
    ElectionModel election = ElectionModel(
        accessCode: getRandomString(6),
        name: name,
        description: description,
        owner: owner,
        startDate: startDate,
        endDate: endDate);
    DataBase().createElection(election);
  }

  candidatesStream(String _uid, String _electionId) {
    DataBase().candidatesStream(_uid, _electionId);
  }

  copyAccessCode() {
    //how to copy to the clipboard using dart
  }
}
