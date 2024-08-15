import 'package:money_send_app/src/core/entities/user.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/user_repository.dart';

class GetUserUseCase {
  final UserRepository _userRepository;

  /// Get the current user.
  GetUserUseCase(this._userRepository);

  Future<User> call() async {
    final result = await _userRepository.getCurrentUser();
    return result.toEntity();
  }
}
