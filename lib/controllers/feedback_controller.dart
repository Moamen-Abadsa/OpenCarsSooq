import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/controllers/store_controller.dart';
import 'package:opencarssooq/core/constant/shared_preference_keys.dart';

import '../core/class/status_request.dart';
import '../core/services/services.dart';

abstract class FeedbackController extends GetxController {
  addFeedback();

  updateRate(rating);
}

class FeedbackControllerImp extends FeedbackController {
  StatusRequest statusRequest = StatusRequest.none;

  final GlobalKey<FormState> feedbackController =
      GlobalKey<FormState>(debugLabel: 'feedbackController');

  CollectionReference feedback = FirebaseFirestore.instance.collection('feedback');

  late TextEditingController tecComment;

  AppServices appServices = Get.find();

  double rating = 0.0;

  @override
  addFeedback() async {
    if (feedbackController.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();

      Map<String, dynamic> map = {
        'userId' : appServices.getStringSharedPreferences(SharedPrefKeys.USER_ID),
        'storeId' : Get.arguments['storeId'],
        'comment' : tecComment.text,
        'rating' : rating,
      };

      feedback.add(map).then((value) {
        statusRequest = StatusRequest.success;
        StoreControllerImp controllerImp = Get.find();
        controllerImp.getStoreRating(true);

        Get.back();
      }).catchError((error) {
        statusRequest = StatusRequest.failure;
        print("Failed to add feedback: $error");
      });

      update();
    }
  }

  @override
  updateRate(rating) {
    this.rating = rating;
  }

  @override
  void onInit() {
    tecComment = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    tecComment.dispose();
    super.dispose();
  }

}
