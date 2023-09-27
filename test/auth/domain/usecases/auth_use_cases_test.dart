import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:turbo/app/common/usecase/base_use_case.dart';
import 'package:turbo/app/errors/failure.dart';
import 'package:turbo/modules/main/auth/domain/entities/user.dart';
import 'package:turbo/modules/main/auth/domain/repositories/base_auth_repository.dart';
import 'package:turbo/modules/main/auth/domain/usecases/add_device_token_use_case.dart';
import 'package:turbo/modules/main/auth/domain/usecases/forget_password_use_case.dart';
import 'package:turbo/modules/main/auth/domain/usecases/log_in_use_case.dart';
import 'package:turbo/modules/main/auth/domain/usecases/sign_up_use_case.dart';
import 'auth_use_cases_test.mocks.dart';


@GenerateNiceMocks([MockSpec<BaseAuthRepository>()])
void main() {
  late MockBaseAuthRepository mockBaseAuthRepository;
  late LoginUseCase loginUseCase;
  late SignUpUseCsae signUpUseCsae;
  late ForgetPasswordUseCase forgetPasswordUseCase;
  late AddDeviceTokenUseCase addDeviceTokenUseCase;
  setUp(() {
    mockBaseAuthRepository = MockBaseAuthRepository();
    loginUseCase = LoginUseCase(mockBaseAuthRepository);
    signUpUseCsae = SignUpUseCsae(mockBaseAuthRepository);
    forgetPasswordUseCase = ForgetPasswordUseCase(mockBaseAuthRepository);
    addDeviceTokenUseCase = AddDeviceTokenUseCase(mockBaseAuthRepository);
  });
  User user = const User(
    userName: 'userName',
    active: 'active',
    userLevel: 'userLevel',
    email: 'email',
    countryCode: 'countryCode',
    mobile: 'mobile',
    avatar: 'avatar',
    brief: 'brief',
    clientCode: 'clientCode',
    address: 'address',
    authenticationCode: 'authenticationCode',
    priceType: 'priceType',
    password: 'password',
    oldPassword: 'oldPassword',
    newPassword: 'newPassword',
    confirmPassword: 'confirmPassword',
    confirm: 'confirm',
    wallet: 'wallet',
  );
  var loginInputs = const LoginInputs(
    mobile: '01027106902',
    password: '147147',
  );
  var signUpInputs = const SignUpInputs(
    mobile: '01027106902',
    password: '147147',
    email: 'asd@gmail.com',
    userName: 'asd',
  );
  group('auth usecases', () {
    test('should get user data from login', () async {
      when(mockBaseAuthRepository.logIn(loginInputs))
          .thenAnswer((_) async => Right(user));
      Either<Failure, User> result = await loginUseCase(loginInputs);
      expect(result, Right(user));
      verify(mockBaseAuthRepository.logIn(loginInputs));
      verifyNoMoreInteractions(mockBaseAuthRepository);
    });
    test('should get user data from signUp', () async {
      when(
        mockBaseAuthRepository.signUp(signUpInputs),
      ).thenAnswer((_) async => Right(user));
      Either<Failure, User> result = await signUpUseCsae(signUpInputs);
      expect(result, Right(user));
      verify(mockBaseAuthRepository.signUp(signUpInputs));
      verifyNoMoreInteractions(mockBaseAuthRepository);
    });
    test('should get message from forget password', () async {
      when(
        mockBaseAuthRepository.forgetPassword('asd@gmail.com'),
      ).thenAnswer((_) async => const Right('rest pass'));
      Either<Failure, String> result =
          await forgetPasswordUseCase('asd@gmail.com');
      expect(result, const Right('rest pass'));
      verify(mockBaseAuthRepository.forgetPassword('asd@gmail.com'));
      verifyNoMoreInteractions(mockBaseAuthRepository);
    });
    test('should get bool val from add deviceToken', () async {
      when(
        mockBaseAuthRepository.addDeviceToken(),
      ).thenAnswer((_) async => const Right(''));
      var result = await addDeviceTokenUseCase(const NoParameters());
      expect(result, const Right(true));
      verify(mockBaseAuthRepository.addDeviceToken());
      verifyNoMoreInteractions(mockBaseAuthRepository);
    });
  });
}
