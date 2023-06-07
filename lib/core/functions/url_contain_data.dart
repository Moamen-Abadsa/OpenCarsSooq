
String getUrlSendData({required String url, required Map<String, dynamic> queryParams}) {
  String queryString = Uri(queryParameters: queryParams).query;
  return '$url?$queryString';
}
