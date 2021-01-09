import 'package:Electchain/bidings/add_candidate_binding.dart';
import 'package:Electchain/screens/add_candidate.dart';
import 'package:Electchain/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Electchain/controllers/controllers.dart';
import 'package:Electchain/services/database.dart';

class AddVoteOptionWidget extends StatefulWidget {
  @override
  _AddVoteOptionWidgetState createState() => _AddVoteOptionWidgetState();
}

class _AddVoteOptionWidgetState extends State<AddVoteOptionWidget> {
  @override
  Widget build(BuildContext context) {
    print(Get.arguments);
    var _candidateNameController = TextEditingController();
    var _candidateDescriptionController = TextEditingController();
    Get.put(ElectionController());

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'ADD OPTION OR CANDIDATE ${Get.arguments[0].id.toString()}',
                style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold),
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.indigo[100],
              radius: 80.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_add,
                    size: 72.0,
                  ),
                  FlatButton(onPressed: null, child: Text('Add picture'))
                ],
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            InputField(
              prefixIcon: Icons.person,
              hintText: 'Candidate\'s names',
              controller: _candidateNameController,
              obscure: false,
            ),
            InputField(
              prefixIcon: Icons.edit,
              hintText: 'Candidates\'s description',
              controller: _candidateDescriptionController,
              obscure: false,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result = await DataBase().addCandidate(
              Get.arguments[0].id.toString(),
              _candidateNameController.text,
              _candidateDescriptionController.text);

          if (result) {
            Get.back();
          }
        },
        child: Icon(
          Icons.check_circle,
          color: Colors.green,
        ),
      ),
    );
  }
}
