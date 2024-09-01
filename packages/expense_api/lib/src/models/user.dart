import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// {@template user}
/// User model
/// {@endtemplate}
@JsonSerializable()
class User extends Equatable {
  /// {@macro user}
  const User({
    this.id,
    this.email,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// The user's id
  final String? id;

  /// The user's email
  final String? email;

  /// The user's name
  final String? name;

  @override
  List<Object?> get props => [id, email, name];

  /// Empty user
  static const empty = User(id: '', email: '', name: '');
}
