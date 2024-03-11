import 'package:get/get.dart';

class AdsControflller extends GetxController{
  bool isClose = true;

  void changeCloseTrue(){
    isClose = true ;
    update();
  }
  void changeCloseFalse(){
    isClose = false ;
    update();
  }
}