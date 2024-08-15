import 'package:money_send_app/src/features/dashboard/data/dto/user_dto.dart';

abstract interface class UserRepository {
  Future<UserDto?> getUser(String userId);
  Future<List<UserDto>> getUsers();
  Future<UserDto> getCurrentUser();
}
