import 'package:money_send_app/src/core/entities/user.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/user_repository.dart';

class GetCurrentUserUseCase {
  final UserRepository _userRepository;

  GetCurrentUserUseCase(this._userRepository);

  Future<User> call() async {
    final response = await _userRepository.getCurrentUser();
    return response.toEntity();
  }
}
