import 'package:Electchain/screens/add_vote_option_screen.dart';
import 'package:Electchain/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:Electchain/controllers/add_vote_option.dart';

final VoteOptionController _voteOptionController =
    Get.put(VoteOptionController());

class NewVote extends StatefulWidget {
  @override
  _NewVoteState createState() => _NewVoteState();
}

class _NewVoteState extends State<NewVote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo[100],
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                'CREATE NEW VOTE',
                style: GoogleFonts.yanoneKaffeesatz(
                    fontSize: 30.0, color: Colors.white),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 0.0),
              sliver: SliverToBoxAdapter(
                child: Image(
                  image: AssetImage('assets/icons/logo.png'),
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
                        hintText: 'Enter the vote\'s name',
                        prefixIcon: Icons.person,
                      ),
                      InputField(
                        hintText: 'Enter the vote\'s description',
                        prefixIcon: Icons.edit,
                      ),
                      VoteDate(
                          title: 'START DATE',
                          hint: 'Start date of the vote',
                          prefixIcon: Icons.calendar_view_day),
                      VoteDate(
                          title: 'END DATE',
                          hint: 'End date of the vote',
                          prefixIcon: Icons.date_range),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
                padding: const EdgeInsets.all(15.0),
                sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                  return Obx(() => Container(
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0)),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/icons/user.jpeg'),
                          ),
                          title: Text(
                              _voteOptionController.candidates[index].name),
                          subtitle: Text(_voteOptionController
                              .candidates[index].description),
                          trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: null),
                        ),
                      ));
                }, childCount: _voteOptionController.candidates.length))),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.only(
                    left: 15.0, bottom: 20.0, right: 15.0),
                decoration: BoxDecoration(
                    color: Colors.indigo[400],
                    borderRadius: BorderRadius.circular(18.0)),
                child: FlatButton.icon(
                  icon: Icon(
                    Icons.group_add,
                    size: 32.0,
                  ),
                  label: Text(
                    'Add Option',
                    style: TextStyle(fontSize: 22.0, color: Colors.white),
                  ),
                  onPressed: () {
                    Get.to(VoteOptionWidget());
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
