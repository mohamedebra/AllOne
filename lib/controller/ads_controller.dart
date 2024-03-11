import 'package:get/get.dart';

class AdsController extends GetxController{
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