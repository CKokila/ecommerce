import 'package:ecommerce/data/api/api_server.dart';
import 'package:ecommerce/data/prefs/current_user.dart';
import 'package:ecommerce/utils/converter.dart';
import '../model/profile_model.dart';
import '../api/api_response.dart';

class ProfileRepo {
  final DioClient _client = DioClient();
  final CurrentUser _user = CurrentUser();
  Future<ProfileModel> fetchProfile() async {
    try {
      num userId = Converter.getNum(_user.getCustomerId);
      ApiResponse response = await _client.get("users/$userId");
      return ProfileModel.fromJson(response.data);
    } catch (e) {
      return Future.error(e);
    }
  }
}
