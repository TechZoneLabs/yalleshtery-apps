import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String userName;
  final String active;
  final String userLevel;
  final String email;
  final String countryCode;
  final String mobile;
  final String avatar;
  final String brief;
  final String clientCode;
  final String address;
  final String authenticationCode;
  final String priceType;
  final String password;
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;
  final String confirm;
  final String wallet;

  const User({
    required this.userName,
    required this.active,
    required this.userLevel,
    required this.email,
    required this.countryCode,
    required this.mobile,
    required this.avatar,
    required this.brief,
    required this.clientCode,
    required this.address,
    required this.authenticationCode,
    required this.priceType,
    required this.password,
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
    required this.confirm, 
    required this.wallet,
  });

  @override
  List<Object?> get props => [
        userName,
        active,
        userLevel,
        email,
        countryCode,
        mobile,
        avatar,
        brief,
        clientCode,
        address,
        authenticationCode,
        priceType,
        password,
        oldPassword,
        newPassword,
        confirmPassword,
        confirm,
        wallet,
      ];
}
