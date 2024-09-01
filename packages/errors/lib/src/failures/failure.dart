import 'package:equatable/equatable.dart';

/// {@template failure}
/// A failure that is returned when an exception is thrown.
/// {@endtemplate}
abstract class Failure extends Equatable {
  /// {@macro failure}
  const Failure({required this.errorMessage});

  /// The error message.
  final String errorMessage;

  @override
  List<Object> get props => [errorMessage];
}
