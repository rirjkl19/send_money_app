class User {
  final String id;
  final String name;
  final String walletId;

  User({required this.id, required this.walletId, required this.name});

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id && other.walletId == walletId && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ walletId.hashCode ^ name.hashCode;
}
