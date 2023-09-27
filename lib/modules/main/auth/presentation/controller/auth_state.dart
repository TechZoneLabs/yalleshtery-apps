part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthTranstion extends AuthState {}

class AuthChanged extends AuthState {
  final bool currentState;

  const AuthChanged({required this.currentState});
}

class AuthLoading extends AuthState {}

class AuthPopUpLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user;
  const AuthSuccess({required this.user});
}

class ForgetPasswordSuccess extends AuthState {
  final String msg;
  const ForgetPasswordSuccess({required this.msg});
}

class AddDeviceTokenSuccess extends AuthState {
  final String deviceToken;

  const AddDeviceTokenSuccess({required this.deviceToken});
}

class AuthFailure extends AuthState {
  final String msg;
  const AuthFailure({
    required this.msg,
  });
}

class AuthLogoutSuccess extends AuthState {
  const AuthLogoutSuccess();
}

class ChangePasswordSuccess extends AuthState {
  final String msg;
  const ChangePasswordSuccess({required this.msg});
}

class AuthDeleteSuccess extends AuthState {
  const AuthDeleteSuccess();
}
