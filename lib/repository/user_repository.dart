import 'package:apidemo/models/user_response.dart';
import 'package:apidemo/network/dio_client.dart';

class UserRepository {
  final DioClient dioClient;
  UserRepository(this.dioClient);
  Future<List<User>> getUsers() async {
    try {
      final result = await dioClient.get("/users");
      UserResponse userResponse = UserResponse.fromJson(result.data);
      List<User> users = userResponse.data!;
      return users;
    } catch (e) {
      throw e.toString();
    }
  }
}
