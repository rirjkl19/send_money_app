import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:money_send_app/src/core/entities/user.dart';
import 'package:money_send_app/src/features/dashboard/data/dto/user_dto.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/user_repository.dart';
import 'package:money_send_app/src/features/dashboard/domain/usecases/get_user_use_case.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository mockUserRepository;
  late GetUserUseCase getUserUseCase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    getUserUseCase = GetUserUseCase(mockUserRepository);
  });

  test('should get the current user', () async {
    when(() => mockUserRepository.getCurrentUser()).thenAnswer(
      (_) async => UserDto(
        id: '1',
        name: 'John Doe',
        walletId: '1',
      ),
    );

    final result = await getUserUseCase();

    expect(
      result,
      User(id: '1', walletId: '1', name: 'John Doe'),
    );
  });
}
