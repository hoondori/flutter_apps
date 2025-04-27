import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bamtol_market_app/splash/enum/step_type.dart';

class SplashController extends GetxController {
  Rx<StepType> loadStep = StepType.dataLoad.obs;

  changeStep(StepType type) {
    loadStep(type);
  }
}
