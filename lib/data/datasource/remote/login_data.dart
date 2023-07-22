import '../../../app_links_api.dart';
import '../../../core/class/crud.dart';

class LoginData {
  Crud crud;

  LoginData(this.crud);

  postUserData(String userName, String password) async {
    var response = await crud.postData(
        AppLinksApi.login, {"userName": userName, "password": password}, null);
    return response.fold((l) => l, (r) => r);
  }
}
