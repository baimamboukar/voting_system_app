import 'package:get/get.dart';
import 'package:Electchain/controllers/controllers.dart';

class VoteDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ElectionController>(() => ElectionController());
  }
}
