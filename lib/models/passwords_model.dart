// get all users passwords from an api the place is in model

import 'package:equatable/equatable.dart';

class PasswordsModel extends Equatable {
  final String id;
  final String title;
  final String username;
  final String password;
  final String website;
  final String notes;
  final String createdAt;
  final String updatedAt;

  PasswordsModel({
    required this.id,
    required this.title,
    required this.username,
    required this.password,
    required this.website,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object> get props => [
        id,
        title,
        username,
        password,
        website,
        notes,
        createdAt,
        updatedAt,
      ];
}
