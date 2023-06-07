// import 'package:mawared_accounting/app_links_api.dart';
// import 'package:mawared_accounting/core/class/crud.dart';
//
// import '../../../core/functions/url_contain_data.dart';
//
// class HomeData {
//   Crud crud;
//
//   HomeData(this.crud);
//
//   loadPeriodID() async {
//     // print('server: ${AppLinksApi.server}');
//     // print('getPeriodID: ${AppLinksApi.getPeriodID}');
//     var response = await crud.getData(AppLinksApi.getPeriodID);
//     return response.fold((l) => l, (r) => r);
//   }
//
//   loadSalesAmountByMonthsYear(
//       {required String fromDate,
//       required String toDate,
//       required int periodID}) async {
//     var response = await crud.getData(
//       getUrlSendData(url: AppLinksApi.getSalesAmountByMonthsYear, queryParams: {
//         'fromDate': fromDate,
//         'toDate': toDate,
//         'PeriodID': '$periodID'
//       }),
//     );
//
//     return response.fold((l) => l, (r) => r);
//   }
//
//   loadTotalSalesInvoicesAmount(
//       {required String fromDate,
//         required String toDate,
//         required int periodID}) async {
//     var response = await crud.getData(
//       getUrlSendData(url: AppLinksApi.getTotalSalesInvoicesAmount, queryParams: {
//         'fromDate': fromDate,
//         'toDate': toDate,
//         'PeriodID': '$periodID'
//       }),
//     );
//
//     return response.fold((l) => l, (r) => r);
//   }
//
//   loadSalesInfo(
//       {required String fromDate,
//         required String toDate,
//         required int periodID}) async {
//     var response = await crud.getData(
//       getUrlSendData(url: AppLinksApi.getSalesInfo, queryParams: {
//         'fromDate': fromDate,
//         'toDate': toDate,
//         'PeriodID': '$periodID'
//       }),
//     );
//
//     return response.fold((l) => l, (r) => r);
//   }
//
//   loadAccountsBalance(
//       {required String fromDate,
//         required String toDate,
//         required int periodID,
//         required int accountId}) async {
//     var response = await crud.getData(
//       getUrlSendData(url: AppLinksApi.getAccountsBalance, queryParams: {
//         'fromDate': fromDate,
//         'toDate': toDate,
//         'PeriodID': '$periodID',
//         'accountID': '$accountId'
//       }),
//     );
//
//     return response.fold((l) => l, (r) => r);
//   }
//
// }
