import 'package:Electchain/controllers/controllers.dart';
import 'package:Electchain/screens/screens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Electchain/models/models.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

class DataBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _uid = Get.find<UserController>().user.id;
  DocumentReference _electionRef;
  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).set({
        "name": user.name,
        "phonenumber": user.phoneNumber,
        "email": user.email
      });
      return true;
    } catch (err) {
      print(err.message);
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(uid).get();
      return Get.find<UserController>().fromDocumentSnapshot(doc);
    } catch (err) {
      print(err.message);
      rethrow;
    }
  }

  Future<DocumentReference> createElection(ElectionModel election) async {
    try {
      await _firestore
          .collection('users')
          .doc(_uid)
          .collection('elections')
          .add({
        'options': [],
        'name': election.name,
        'description': election.description,
        'startDate': election.startDate,
        'endDate': election.endDate,
        'accessCode': election.accessCode,
      }).then((reference) {
        print('The response was $reference');
        Get.to(AddCandidate(), arguments: [reference, election]);
      });
      return _electionRef;
    } catch (err) {
      print('The error of election creation is ' + err.message);
      return null;
    }
  }

  Future<bool> addCandidate(
      _electionId, _candidateName, _candidateDescription) async {
    try {
      await _firestore
          .collection('users')
          .doc(_uid)
          .collection('elections')
          .doc(_electionId)
          .update({
        "options": FieldValue.arrayUnion([
          {
            'name': _candidateName,
            'description': _candidateDescription,
            'count': 0
          }
        ])
      });
      return true;
    } catch (err) {
      print(err.message);
      Get.snackbar('ERROR',
          'Unexpected error occured while adding the candidate, Please try again');
      return false;
    }
  }

  Future<DocumentSnapshot> candidatesStream(
      String _uid, String _electionId) async {
    var data = await _firestore
        .collection('users')
        .doc(_uid)
        .collection('elections')
        .doc(_electionId)
        .get();
    return data;
  }
}
