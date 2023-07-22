import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:opencarssooq/controllers/feedback_controller.dart';
import 'package:opencarssooq/core/class/handling_data_view.dart';
import 'package:opencarssooq/core/constant/app_color.dart';
import 'package:opencarssooq/core/constant/app_image_asset.dart';
import 'package:opencarssooq/views/widgets/custom_app_bar.dart';
import 'package:opencarssooq/views/widgets/rounded_image.dart';

import '../../core/class/status_request.dart';
import '../../core/functions/valid_inputs.dart';
import '../../core/localization/text_language_keys.dart';
import '../widgets/add_car/custom_text_form.dart';
import '../widgets/auth/custom_button_auth.dart';
import '../widgets/rounded_image2.dart';

class AddFeedbackScreen extends StatelessWidget {
  const AddFeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: GetBuilder<FeedbackControllerImp>(
              builder: (controllerImp) {
                return HandlingDataRequest(
                  statusRequest: controllerImp.statusRequest,
                  widget: Form(
                    key: controllerImp.feedbackController,
                    child: Column(
                      children: [
                        CustomAppBar(
                          title: feedback.tr,
                        ),
                        const SizedBox(height: 40),
                        RoundedImage2(
                          imagePath: Get.arguments['storeLogo'],
                          height: 165,
                          width: 165,
                          borderRadius: BorderRadius.circular(80),
                        ),
                        RatingBar.builder(
                          initialRating: 0,
                          minRating: 0.5,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.only(
                              left: 8, right: 8, top: 60, bottom: 40),
                          unratedColor: Colors.grey.shade200,
                          itemBuilder: (context, _) => SvgPicture.asset(
                            AppImageAsset.fullStar,
                            width: 24,
                            height: 24,
                          ),
                          onRatingUpdate: (rating) {
                            controllerImp.updateRate(rating);
                          },
                        ),
                        CustomTextForm(
                          controller: controllerImp.tecComment,
                          valid: (value) {
                            return validInput(value!, 0, 100, "comment");
                          },
                          keyboardType: TextInputType.multiline,
                          hintText: addYourComment.tr,
                          labelText: comment.tr,
                          margin: const EdgeInsets.only(bottom: 0, left: 30, right: 30),
                        ),
                        CustomButtonAuth(
                          text: submit.tr,
                          onPressed: () => controllerImp.addFeedback(),
                          margin: const EdgeInsets.all(30),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
