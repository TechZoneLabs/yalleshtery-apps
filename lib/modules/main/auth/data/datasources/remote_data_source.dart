import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../../../app/common/model/general_response.dart';
import '../../../../../app/errors/exception.dart';
import '../../../../../app/services/api_services.dart';
import '../../domain/usecases/change_password_use_case.dart';
import '../../domain/usecases/log_in_use_case.dart';
import '../../domain/usecases/sign_up_use_case.dart';
import '../../domain/usecases/update_profile_use_case.dart';
import '../models/auth_response.dart';

abstract class BaseAuthRemoteDataSource {
  Future<UserResponse> logIn(LoginInputs loginInputs);
  Future<UserResponse> signUp(SignUpInputs signUpInputs);
  Future<GerenalResponse> forgetPassword(String email);
  Future<String> addDeviceToken();
  Future<UserResponse> getUserData();
  Future<GerenalResponse> logout(String token);
  Future<UserResponse> updateProfile(UpdateInputs updateInputs);
  Future<GerenalResponse> changePassword(PasswordInputs passwordInputs);
  Future<GerenalResponse> deleteAccount(String token);
}

class AuthRemoteDataSource implements BaseAuthRemoteDataSource {
  final ApiServices apiServices;
  final FirebaseMessaging firebaseMessaging;

  AuthRemoteDataSource(this.apiServices, this.firebaseMessaging);
  @override
  Future<UserResponse> logIn(LoginInputs loginInputs) async {
    try {
      var map = await apiServices.post(
        file: 'users.php',
        action: 'login',
        body: loginInputs.toJson(),
      );
      print("===============================");
      print(UserResponse.fromJson(map).data!.wallet);
      return UserResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<UserResponse> signUp(SignUpInputs signUpInputs) async {
    try {
      var map = await apiServices.post(
        file: 'users.php',
        action: 'signUp',
        body: signUpInputs.toJson(),
      );
      return UserResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<GerenalResponse> forgetPassword(String email) async {
    try {
      var map = await apiServices.post(
        file: 'users.php',
        action: 'restpassword',
        body: {
          "email": email,
        },
      );
      return GerenalResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<String> addDeviceToken() async {
    try {
      String? token = await firebaseMessaging.getToken();
      var map = await apiServices.post(
        file: 'notifications.php',
        action: 'setDeviceToken',
        body: {
          "device_token_id": token,
          "type": Platform.isAndroid ? "android" : "ios",
        },
      );
      return map['success'] ? token! : '';
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<UserResponse> getUserData() async {
    try {
      var map = await apiServices.get(
        file: 'users.php',
        action: 'getUserInfo',
      );
      return UserResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<GerenalResponse> logout(String token) async {
    try {
      var map = await apiServices.post(
        file: 'users.php',
        action: 'logOut',
        body: {
          "device_token_id": token,
        },
      );
      return GerenalResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<GerenalResponse> changePassword(PasswordInputs passwordInputs) async {
    try {
      var map = await apiServices.post(
        file: 'users.php',
        action: 'editPassword',
        body: passwordInputs.toJson(),
      );
      return GerenalResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<UserResponse> updateProfile(UpdateInputs updateInputs) async {
    try {
      var map = await apiServices.post(
        file: 'users.php',
        action: 'editProfile',
        body: updateInputs.toJson(),
      );
      return UserResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }

  @override
  Future<GerenalResponse> deleteAccount(String token) async {
    try {
      var map = await apiServices.post(
        file: 'users.php',
        action: 'deleteAccount',
        body: {
          "device_token_id": token,
        },
      );
      return GerenalResponse.fromJson(map);
    } catch (e) {
      throw ServerExecption(e.toString());
    }
  }
}
