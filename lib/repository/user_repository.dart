import 'package:apidemo/models/user_response.dart';
import 'package:apidemo/network/dio_client.dart';

class UserRepository {
  final DioClient dioClient;
  UserRepository(this.dioClient);
  Future<List<User>> getUsers(int page) async {
    try {
      final result = await dioClient.get("/users?per_page=5&page=$page");
      UserResponse userResponse = UserResponse.fromJson(result.data);
      List<User> users = userResponse.data!;
      return users;
    } catch (e) {
      throw e.toString();
    }
  }
}
