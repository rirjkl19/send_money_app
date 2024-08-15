import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:money_send_app/src/core/entities/user.dart';
import 'package:money_send_app/src/features/dashboard/data/dto/user_dto.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/user_repository.dart';
import 'package:money_send_app/src/features/send_money/domain/usecases/get_current_user_use_case.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late UserRepository userRepository;
  late GetCurrentUserUseCase useCase;

  setUpAll(() {
    userRepository = MockUserRepository();
    useCase = GetCurrentUserUseCase(userRepository);
  });

  test('should return the current user', () async {
    when(() => userRepository.getCurrentUser())
        .thenAnswer((_) async => UserDto(id: '1', name: 'John Doe', walletId: '1'));
    final response = await useCase();
    expect(response, User(id: '1', name: 'John Doe', walletId: '1'));
  });
}
