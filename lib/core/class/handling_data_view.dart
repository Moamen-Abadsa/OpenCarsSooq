import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constant/app_image_asset.dart';
import 'status_request.dart';

class HandlingDataView extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;

  const HandlingDataView(
      {required this.widget, required this.statusRequest, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
            child: Lottie.asset(AppImageAsset.loading,
                width: 80, height: 80, repeat: true))
        : statusRequest == StatusRequest.offlineFailure
            ? Center(
                child: Lottie.asset(AppImageAsset.offline,
                    width: 250, height: 250, repeat: true))
            : statusRequest == StatusRequest.serverFailure
                ? Center(
                    child: Lottie.asset(AppImageAsset.serverError,
                        width: 250, height: 250, repeat: true))
                : statusRequest == StatusRequest.noDataFailure
                    ? Center(
                        child: Lottie.asset(AppImageAsset.noData,
                            width: 250, height: 250, repeat: true))
                    : statusRequest == StatusRequest.failure
                        ? Center(
                            child: Lottie.asset(AppImageAsset.noData,
                                width: 250, height: 250, repeat: true))
                        : widget;
  }
}

class HandlingDataRequest extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;

  const HandlingDataRequest(
      {required this.widget, required this.statusRequest, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? Center(
            child: Lottie.asset(AppImageAsset.loading,
                width: 80, height: 80, repeat: true))
        : statusRequest == StatusRequest.offlineFailure
            ? Center(
                child: Lottie.asset(AppImageAsset.offline,
                    width: 250, height: 250, repeat: true))
            : statusRequest == StatusRequest.serverFailure
                ? Center(
                    child: Lottie.asset(AppImageAsset.serverError,
                        width: 250, height: 250, repeat: true))
                : widget;
  }
}

class HandlingDataViewHome extends StatelessWidget {
  final StatusRequest statusRequest;
  final Widget widget;

  const HandlingDataViewHome(
      {required this.widget, required this.statusRequest, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? SliverToBoxAdapter(
          child: Center(
          child: Lottie.asset(AppImageAsset.loading,
              width: 80, height: 80, repeat: true)),
        )
        : statusRequest == StatusRequest.offlineFailure
        ? SliverToBoxAdapter(
          child: Center(
          child: Lottie.asset(AppImageAsset.offline,
              width: 250, height: 250, repeat: true)),
        )
        : statusRequest == StatusRequest.serverFailure
        ? SliverToBoxAdapter(
          child: Center(
          child: Lottie.asset(AppImageAsset.serverError,
              width: 250, height: 250, repeat: true)),
        )
        : statusRequest == StatusRequest.noDataFailure
        ? SliverToBoxAdapter(
          child: Center(
          child: Lottie.asset(AppImageAsset.noData,
              width: 250, height: 250, repeat: true)),
        )
        : statusRequest == StatusRequest.failure
        ? SliverToBoxAdapter(
          child: Center(
          child: Lottie.asset(AppImageAsset.noData,
              width: 250, height: 250, repeat: true)),
        )
        : widget;
  }
}
