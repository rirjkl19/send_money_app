import 'dart:convert';

import 'package:money_send_app/src/core/entities/user.dart';

class UserDto {
  final String id;
  final String name;
  final String walletId;

  UserDto({required this.id, required this.name, required this.walletId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'walletId': walletId,
    };
  }

  factory UserDto.fromMap(Map<String, dynamic> map) {
    return UserDto(
      id: map['id'] as String,
      name: map['name'] as String,
      walletId: map['walletId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDto.fromJson(String source) =>
      UserDto.fromMap(json.decode(source) as Map<String, dynamic>);

  static List<UserDto> fromJsonList(String source) {
    final List<Map<String, dynamic>> list =
        List<Map<String, dynamic>>.from(json.decode(source) as List);
    return list.map((e) => UserDto.fromMap(e)).toList();
  }

  User toEntity() {
    return User(id: id, name: name, walletId: walletId);
  }

  @override
  bool operator ==(covariant UserDto other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.walletId == walletId;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ walletId.hashCode;
}
