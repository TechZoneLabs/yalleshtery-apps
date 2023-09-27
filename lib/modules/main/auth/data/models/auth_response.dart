import 'user_model.dart';

class UserResponse {
  final bool success;
  final String message;
  final UserModel? data;

  UserResponse({
    required this.success,
    required this.message,
    required this.data,
  });
  factory UserResponse.fromJson(Map<String, dynamic> map) => UserResponse(
        success: map['success'],
        message: map.containsKey('message') ? map['message'] : '',
        data: map.containsKey('data') ? UserModel.fromJson(map['data']) : null,
      );
}
