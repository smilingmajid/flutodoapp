import 'package:get/get.dart';

class ShowProjectController extends GetxController {
  RxBool showProject = false.obs;

   changeShowProject() {
    showProject.value = !showProject.value;
   
  }
}
