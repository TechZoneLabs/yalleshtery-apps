part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthToggleEvent extends AuthEvent {
  final bool prevState;
  const AuthToggleEvent({required this.prevState});
}

class LoginEvent extends AuthEvent {
  final LoginInputs loginInputs;
  const LoginEvent({required this.loginInputs});
}

class SignUpEvent extends AuthEvent {
  final SignUpInputs signUpInputs;
  const SignUpEvent({required this.signUpInputs});
}

class ForgetPasswordEvent extends AuthEvent {
  final String email;
  const ForgetPasswordEvent({required this.email});
}

class AddDeviceTokenEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {
  final String token;
  const LogoutEvent({required this.token});
}

class ChangePasswordEvent extends AuthEvent {
  final PasswordInputs passwordInputs;
  const ChangePasswordEvent({required this.passwordInputs});
}

class DeleteEvent extends AuthEvent {
  final String token;
  const DeleteEvent({required this.token});
}
