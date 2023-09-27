import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/change_password_use_case.dart';
import '../../domain/usecases/delete_account_use_case.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../../../../../app/utils/strings_manager.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/add_device_token_use_case.dart';
import '../../domain/usecases/forget_password_use_case.dart';
import '../../domain/usecases/log_in_use_case.dart';
import '../../domain/usecases/log_out_use_case.dart';
import '../../domain/usecases/sign_up_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignUpUseCsae signUpUseCsae;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final AddDeviceTokenUseCase addDeviceTokenUseCase;
  final LogoutUseCase logoutUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final DeteteAccountUseCase deteteAccountUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.signUpUseCsae,
    required this.forgetPasswordUseCase,
    required this.addDeviceTokenUseCase,
    required this.logoutUseCase,
    required this.changePasswordUseCase,
    required this.deteteAccountUseCase,
  }) : super(AuthInitial()) {
    on<AuthToggleEvent>(_toggle);
    on<LoginEvent>(_login);
    on<SignUpEvent>(_signUp);
    on<ForgetPasswordEvent>(_forgetPassword);
    on<AddDeviceTokenEvent>(_addDeviceToken);
    on<LogoutEvent>(_logout);
    on<ChangePasswordEvent>(_changePassword);
    on<DeleteEvent>(_deleteAccount);
  }

  FutureOr<void> _toggle(AuthToggleEvent event, Emitter<AuthState> emit) {
    emit(AuthTranstion());
    emit(AuthChanged(currentState: !event.prevState));
  }

  FutureOr<void> _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthPopUpLoading());
    
    final Either<Failure, User> result = await loginUseCase(event.loginInputs);
    result.fold(
      (failure) => emit(AuthFailure(msg: failure.msg)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  FutureOr<void> _signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthPopUpLoading());
    final Either<Failure, User> result =
        await signUpUseCsae(event.signUpInputs);
    result.fold(
      (failure) => emit(AuthFailure(msg: failure.msg)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  FutureOr<void> _forgetPassword(
      ForgetPasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthPopUpLoading());
    final Either<Failure, String> result =
        await forgetPasswordUseCase(event.email);
    result.fold(
      (failure) => emit(AuthFailure(msg: failure.msg)),
      (message) => emit(ForgetPasswordSuccess(msg: message)),
    );
  }

  FutureOr<void> _addDeviceToken(
      AddDeviceTokenEvent event, Emitter<AuthState> emit) async {
    emit(AuthTranstion());
    final Either<Failure, String> result =
        await addDeviceTokenUseCase(const NoParameters());
    result.fold(
      (failure) => emit(AuthFailure(msg: failure.msg)),
      (token) => token.isNotEmpty
          ? emit(AddDeviceTokenSuccess(deviceToken: token))
          : emit(const AuthFailure(msg: AppStrings.tryAgain)),
    );
  }

  FutureOr<void> _logout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthPopUpLoading());
    Either<Failure, bool> result = await logoutUseCase(event.token);
    result.fold(
      (failure) => emit(AuthFailure(msg: failure.msg)),
      (_) => emit(const AuthLogoutSuccess()),
    );
  }

  FutureOr<void> _changePassword(
      ChangePasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthPopUpLoading());
    Either<Failure, String> result =
        await changePasswordUseCase(event.passwordInputs);
    result.fold(
      (failure) => emit(AuthFailure(msg: failure.msg)),
      (val) => emit(ChangePasswordSuccess(msg: val)),
    );
  }

  FutureOr<void> _deleteAccount(
      DeleteEvent event, Emitter<AuthState> emit) async {
    emit(AuthPopUpLoading());
    Either<Failure, bool> result = await deteteAccountUseCase(event.token);
    result.fold(
      (failure) => emit(AuthFailure(msg: failure.msg)),
      (_) => emit(const AuthDeleteSuccess()),
    );
  }
}
