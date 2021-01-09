import 'package:get/get.dart';
import 'package:Electchain/models/add_vote_option.dart';

class VoteOptionController extends GetxController {
  final candidates = List<VoteOption>().obs;
  //addOption
  addOption(name, desc) {
    candidates.add(VoteOption(name: name, description: desc));
  }
}
