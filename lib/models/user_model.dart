/// TODO: replace with your real user model / auth state (e.g. from
/// an AuthModel or API response), mirroring your CartModel singleton pattern.
class UserProfile {
  final String name;
  final String email;
  final String phone;
  final String? avatarImagePath; // network URL or local asset/file path

  const UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    this.avatarImagePath,
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? phone,
    String? avatarImagePath,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarImagePath: avatarImagePath ?? this.avatarImagePath,
    );
  }
}

class UserRepository {
  UserRepository._();
  static final UserRepository instance = UserRepository._();

  UserProfile current = const UserProfile(
    name: 'John Doe',
    email: 'johndoe@gmail.com',
    phone: '+256 700 123456',
  );

  void update(UserProfile profile) {
    current = profile;
  }
}
