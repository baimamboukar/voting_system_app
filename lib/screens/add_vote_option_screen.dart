import 'package:Electchain/controllers/add_vote_option.dart';
import 'package:Electchain/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:Electchain/widgets/input_field.dart';
import 'package:get/get.dart';

class VoteOptionWidget extends StatefulWidget {
  @override
  _VoteOptionWidgetState createState() => _VoteOptionWidgetState();
}

class _VoteOptionWidgetState extends State<VoteOptionWidget> {
  @override
  Widget build(BuildContext context) {
    var _candidateNameController = TextEditingController();
    var _candidateDescriptionController = TextEditingController();
    VoteOptionController _voteOptionController =
        Get.put(VoteOptionController());
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'ADD OPTION OR CANDIDATE',
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
            ),
            InputField(
              prefixIcon: Icons.person,
              hintText: 'Candidates\'s description',
              controller: _candidateDescriptionController,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: IconButton(
            icon: Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            onPressed: () {
              _voteOptionController.addOption(_candidateNameController.text,
                  _candidateDescriptionController.text);
              Get.to(NewVote());
            }),
      ),
    );
  }
}
