part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignupButtonPressed extends SignupEvent {
  String email;
  String firstName;
  String lastName;
  String password;
  File image;

  SignupButtonPressed(
      {required this.email,
      required this.password,
      required this.image,
      required this.lastName,
      required this.firstName});

  @override
  List<Object> get props => [];
}
