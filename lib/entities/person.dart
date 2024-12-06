import 'package:fahrtenbuch/entities/role.dart';

class Person {
  final int id;
  final String firstName;
  final String lastName;
  final bool isActive;
  final List<Role> roles;

  const Person({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.isActive,
    required this.roles
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'firstName': String firstName,
        'lastName': String lastName,
        'isActive': bool isActive,
      } =>
        Person(
          id: json['id'] as int,
          firstName: json['firstName'] as String,
          lastName: json['lastName'] as String,
          isActive: json['isActive'] as bool,
          roles: (json['roles'] as List<dynamic>)
          .map((roleJson) => Role.fromJson(roleJson as Map<String, dynamic>))
          .toList(),
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}