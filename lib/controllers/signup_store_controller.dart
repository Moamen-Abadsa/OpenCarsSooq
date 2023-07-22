import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opencarssooq/controllers/store_controller.dart';
import 'package:opencarssooq/core/constant/app_route.dart';
import 'package:opencarssooq/core/constant/shared_preference_keys.dart';
import 'package:opencarssooq/core/functions/custom_snackbar.dart';
import 'package:opencarssooq/core/services/services.dart';

import '../core/class/status_request.dart';
import '../core/functions/encode_decode_image64.dart';
import '../core/functions/store_states.dart';
import '../core/localization/text_language_keys.dart';
import '../data/models/store.dart';
import '../data/models/store_state.dart';

abstract class SignUpStoreController extends GetxController {
  createStore();

  selectDropDownItems(value);

  pickImage();

  getStoreData();

  updateStore();
}

class SignUpStoreControllerImp extends SignUpStoreController {
  StatusRequest statusRequest = StatusRequest.none;

  final GlobalKey<FormState> signUpStoreController =
      GlobalKey<FormState>(debugLabel: 'signUpStoreController');

  StoreState? selectedState;

  late TextEditingController tecName;
  late TextEditingController tecPhone;
  late TextEditingController tecAddress;
  late TextEditingController fbLink;
  late TextEditingController instaLink;
  late TextEditingController wtLink;

  CollectionReference stores = FirebaseFirestore.instance.collection('stores');
  AppServices appServices = Get.find();

  File? logo;
  String? base64Logo;
  late Store store;

  @override
  createStore() async {
    if (signUpStoreController.currentState!.validate()) {
      if (logo != null) {
        statusRequest = StatusRequest.loading;
        update();

        Store store = Store(
            vendorId: '${Get.arguments['userId']}',
            logo: convertIntoBase64(logo!),
            name: tecName.text,
            address: tecAddress.text,
            phone: tecPhone.text,
            state: selectedState!.id!,
            fbLink: fbLink.text,
            instaLink: instaLink.text,
            wtLink: wtLink.text);

        stores.add(store.toJson()).then((value) {
          statusRequest = StatusRequest.success;
          Get.offNamed(AppRoute.loginScreen);
        }).catchError((error) {
          statusRequest = StatusRequest.failure;
          print("Failed to add store: $error");
        });

        update();
      } else {
        showSnackBar(message: chooseLogoForStore.tr);
      }
    }
  }

  @override
  getStoreData() async {
    store = Get.arguments['storeData'];
    tecName.text = store.name!;
    tecPhone.text = store.phone!;
    tecAddress.text = store.address!;
    fbLink.text = store.fbLink!;
    instaLink.text = store.instaLink!;
    wtLink.text = store.wtLink!;
    selectedState = states[store.state!];
    base64Logo = store.logo!;

    update();
  }

  @override
  updateStore() async {
    if (signUpStoreController.currentState!.validate()) {
      if (logo != null || base64Logo != null) {
        statusRequest = StatusRequest.loading;
        update();

        Store str = Store(
            vendorId: appServices.getStringSharedPreferences(SharedPrefKeys.USER_ID),
            logo: logo != null ? convertIntoBase64(logo!) : base64Logo,
            name: tecName.text,
            address: tecAddress.text,
            phone: tecPhone.text,
            state: selectedState!.id!,
            fbLink: fbLink.text,
            instaLink: instaLink.text,
            wtLink: wtLink.text,
            storeRate: store.storeRate);

        stores
            .doc(Get.arguments['storeId'])
            .update(str.toJson())
            .then((_) {
          StoreControllerImp controllerImp = Get.find();
          controllerImp.getStoreData(Get.arguments['storeId'], true);

          statusRequest = StatusRequest.success;
          Get.back();
        }).catchError((error) {
          statusRequest = StatusRequest.failure;
          print("Failed to update store: $error");
        });

        update();
      } else {
        showSnackBar(message: chooseLogoForStore.tr);
      }
    }
  }

  @override
  void onInit() {
    tecName = TextEditingController();
    tecPhone = TextEditingController();
    tecAddress = TextEditingController();
    fbLink = TextEditingController();
    instaLink = TextEditingController();
    wtLink = TextEditingController();
    var arrg = Get.arguments as Map;
    if (arrg.containsKey('storeData')) {
      getStoreData();
    }
    super.onInit();
  }

  @override
  void dispose() {
    tecName.dispose();
    tecPhone.dispose();
    tecAddress.dispose();
    fbLink.dispose();
    instaLink.dispose();
    wtLink.dispose();
    super.dispose();
  }

  @override
  pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      base64Logo = null;
      logo = File(image.path);
    }

    update();
  }

  @override
  selectDropDownItems(value) {
    if (value != null) {
      for (var element in states) {
        final b = value as StoreState;
        if (element.id == b.id) {
          selectedState = element;
          break;
        }
      }
    }
    update();
  }
}
