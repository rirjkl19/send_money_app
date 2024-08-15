import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:money_send_app/src/features/dashboard/data/data_sources/mock_user_data_source.dart';
import 'package:money_send_app/src/features/dashboard/data/data_sources/remote_user_data_source.dart';
import 'package:money_send_app/src/features/dashboard/data/dto/user_dto.dart';
import 'package:money_send_app/src/features/dashboard/data/repositories/i_user_repository.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/user_repository.dart';

class MockMockRemoteUserDataSource extends Mock implements MockUserDataSource {}

class MockRemoteUserDataSource extends Mock implements RemoteUserDataSource {}

void main() {
  late MockUserDataSource mockRemoteUserDataSource;
  late RemoteUserDataSource remoteUserDataSource;
  late UserRepository userRepository;

  setUp(() {
    mockRemoteUserDataSource = MockMockRemoteUserDataSource();
    remoteUserDataSource = MockRemoteUserDataSource();
    userRepository = IUserRepository(
      mockUserDataSource: mockRemoteUserDataSource,
      remoteUserDataSource: remoteUserDataSource,
    );
  });

  test('should get the current user', () async {
    when(() => mockRemoteUserDataSource.getCurrentUser()).thenAnswer(
      (_) async => Response(
        '{"id": "1", "name": "John Doe", "walletId": "1"}',
        200,
      ),
    );
    final result = await userRepository.getCurrentUser();
    expect(
      result,
      UserDto(id: '1', walletId: '1', name: 'John Doe'),
    );
  });

  test('should get the user', () async {
    when(() => remoteUserDataSource.getUser('1')).thenAnswer(
      (_) async => Response(
        '{"id": "1", "name": "John Doe", "walletId": "1"}',
        200,
      ),
    );
    final result = await userRepository.getUser('1');
    expect(
      result,
      UserDto(id: '1', walletId: '1', name: 'John Doe'),
    );
  });

  test('should get the users', () async {
    when(() => remoteUserDataSource.getUsers()).thenAnswer(
      (_) async => Response(
        '[{"id": "1", "name": "John Doe", "walletId": "1"}]',
        200,
      ),
    );
    final result = await userRepository.getUsers();
    expect(result.length, 1);
  });
}
