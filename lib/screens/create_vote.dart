import 'package:Electchain/controllers/controllers.dart';
import 'package:Electchain/controllers/election_controller.dart';
import 'package:Electchain/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

ElectionController _electionController;

TextEditingController _electionNameController = TextEditingController();
TextEditingController _electionDescriptionController = TextEditingController();
TextEditingController _electionStartDateController = TextEditingController();
TextEditingController _electionEndDateController = TextEditingController();
final owner = Get.find<UserController>().user;

class NewVote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _electionController = Get.put(ElectionController());
    return Scaffold(
      backgroundColor: Colors.indigo[100],
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
            sliver: SliverToBoxAdapter(
              child: Image(
                image: AssetImage('assets/icons/logo.png'),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: Text(
                'CREATE NEW ELECTION',
                style: GoogleFonts.yanoneKaffeesatz(
                    fontSize: 28.0,
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: [
                    InputField(
                      controller: _electionNameController,
                      hintText: 'Enter the election\'s name',
                      prefixIcon: Icons.person,
                      obscure: false,
                    ),
                    InputField(
                      controller: _electionDescriptionController,
                      hintText: 'Enter the election\'s description',
                      prefixIcon: Icons.edit,
                      obscure: false,
                    ),
                    VoteDate(
                        controller: _electionStartDateController,
                        title: 'START DATE',
                        hint: 'Start date of the election',
                        prefixIcon: Icons.calendar_view_day),
                    VoteDate(
                        controller: _electionEndDateController,
                        title: 'END DATE',
                        hint: 'End date of the election',
                        prefixIcon: Icons.date_range)
                  ],
                ),
              ),
            ),
          ),
          // SliverPadding(
          //     padding: const EdgeInsets.all(15.0),
          //     sliver: SliverList(
          //         delegate: SliverChildBuilderDelegate(
          //             (BuildContext context, int index) {
          //       return Obx(() => Container(
          //             margin: const EdgeInsets.all(5.0),
          //             decoration: BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius: BorderRadius.circular(10.0)),
          //             child: ListTile(
          //               leading: CircleAvatar(
          //                 backgroundImage: AssetImage('assets/icons/user.jpeg'),
          //               ),
          //               title:
          //                   Text(_electionController.candidates[index]['name']),
          //               subtitle: Text(_electionController.candidates[index]
          //                   ['description']),
          //               trailing: IconButton(
          //                   icon: Icon(
          //                     Icons.delete,
          //                     color: Colors.red,
          //                   ),
          //                   onPressed: null),
          //             ),
          //           ));
          //     }, childCount: _electionController.candidates.length))),
          SliverToBoxAdapter(
            child: Container(
              margin:
                  const EdgeInsets.only(left: 55.0, bottom: 20.0, right: 55.0),
              decoration: BoxDecoration(
                  color: Colors.indigo[400],
                  borderRadius: BorderRadius.circular(18.0)),
              child: FlatButton.icon(
                label: Text(
                  'Continue',
                  style: TextStyle(fontSize: 22.0, color: Colors.white),
                ),
                icon: Icon(
                  Icons.next_plan,
                  size: 32.0,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await _electionController.createElection(
                    _electionNameController.text,
                    _electionDescriptionController.text,
                    _electionStartDateController.text,
                    _electionEndDateController.text,
                  );
                  // if (_creationResult == null) {
                  //   Get.snackbar('PROCESSING ERROR',
                  //       'Error while creating the election');
                  // }
                  // if (_creationResult != null) {
                  //   print('Returned Value is $_creationResult');
                  //   Get.to(AddCandidate(), arguments: _creationResult);
                  // }

                  // Get.to(AddVoteOptionWidget());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
