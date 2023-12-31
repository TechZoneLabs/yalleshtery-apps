// Mocks generated by Mockito 5.3.2 from annotations
// in turbo/test/auth/domain/usecases/auth_use_cases_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:turbo/app/errors/failure.dart' as _i5;
import 'package:turbo/modules/main/auth/domain/entities/user.dart' as _i6;
import 'package:turbo/modules/main/auth/domain/repositories/base_auth_repository.dart'
    as _i3;
import 'package:turbo/modules/main/auth/domain/usecases/log_in_use_case.dart'
    as _i7;
import 'package:turbo/modules/main/auth/domain/usecases/sign_up_use_case.dart'
    as _i8;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [BaseAuthRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockBaseAuthRepository extends _i1.Mock
    implements _i3.BaseAuthRepository {
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.User>> logIn(
          _i7.LoginInputs? userInputs) =>
      (super.noSuchMethod(
        Invocation.method(
          #logIn,
          [userInputs],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.User>>.value(
            _FakeEither_0<_i5.Failure, _i6.User>(
          this,
          Invocation.method(
            #logIn,
            [userInputs],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i6.User>>.value(
                _FakeEither_0<_i5.Failure, _i6.User>(
          this,
          Invocation.method(
            #logIn,
            [userInputs],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.User>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.User>> signUp(
          _i8.SignUpInputs? userInputs) =>
      (super.noSuchMethod(
        Invocation.method(
          #signUp,
          [userInputs],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, _i6.User>>.value(
            _FakeEither_0<_i5.Failure, _i6.User>(
          this,
          Invocation.method(
            #signUp,
            [userInputs],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, _i6.User>>.value(
                _FakeEither_0<_i5.Failure, _i6.User>(
          this,
          Invocation.method(
            #signUp,
            [userInputs],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, _i6.User>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> forgetPassword(String? email) =>
      (super.noSuchMethod(
        Invocation.method(
          #forgetPassword,
          [email],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #forgetPassword,
            [email],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, String>>.value(
                _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #forgetPassword,
            [email],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, String>> addDeviceToken() =>
      (super.noSuchMethod(
        Invocation.method(
          #addDeviceToken,
          [],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, String>>.value(
            _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #addDeviceToken,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, String>>.value(
                _FakeEither_0<_i5.Failure, String>(
          this,
          Invocation.method(
            #addDeviceToken,
            [],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, String>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> logout(String? token) =>
      (super.noSuchMethod(
        Invocation.method(
          #logout,
          [token],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #logout,
            [token],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #logout,
            [token],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, bool>> deleteAccount(String? token) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteAccount,
          [token],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
            _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #deleteAccount,
            [token],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.Either<_i5.Failure, bool>>.value(
                _FakeEither_0<_i5.Failure, bool>(
          this,
          Invocation.method(
            #deleteAccount,
            [token],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, bool>>);
}
