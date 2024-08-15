import 'package:flutter/material.dart';
import 'package:money_send_app/src/core/configurations/app_error.dart';
import 'package:money_send_app/src/features/dashboard/data/data_sources/mock_user_data_source.dart';
import 'package:money_send_app/src/features/dashboard/data/data_sources/remote_user_data_source.dart';
import 'package:money_send_app/src/features/dashboard/data/dto/user_dto.dart';
import 'package:money_send_app/src/features/dashboard/domain/repositories/user_repository.dart';

interface class IUserRepository implements UserRepository {
  const IUserRepository({
    required this.mockUserDataSource,
    required this.remoteUserDataSource,
  });

  @protected
  final MockUserDataSource mockUserDataSource;

  @protected
  final RemoteUserDataSource remoteUserDataSource;

  @override
  Future<UserDto> getCurrentUser() async {
    final response = await mockUserDataSource.getCurrentUser();
    return UserDto.fromJson(response.body);
  }

  @override
  Future<UserDto> getUser(String userId) async {
    try {
      final response = await remoteUserDataSource.getUser(userId);
      if (response.statusCode == 404) throw AppError(message: 'User not found');
      return UserDto.fromJson(response.body);
    } catch (e) {
      throw AppError(message: 'Failed to get user');
    }
  }

  @override
  Future<List<UserDto>> getUsers() async {
    final response = await remoteUserDataSource.getUsers();
    return UserDto.fromJsonList(response.body);
  }
}
