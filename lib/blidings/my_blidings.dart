import 'package:get/get.dart';

import '../controllers/project_controller.dart';
import '../controllers/show_project_controller.dart';
import '../controllers/task_controller.dart';


class MyBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskController(), fenix: true);
    Get.lazyPut(() => ProjectController(), fenix: true);
    Get.lazyPut(() => ShowProjectController(), fenix: true);

  }
}
