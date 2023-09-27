import 'package:equatable/equatable.dart';

class ContactInfo extends Equatable {
  final String mobile;
  final String email;
  final String userName;
  final String avatar;
  final String brief;
  final String frontColor;
  final String frontLogo;
  final String frontFavIcon;
  final String frontName;
  final String instagram;
  final String facebook;
  final String twitter;
  final String tiktok;
  final String snapchat;
  final String youtube;
  final String frontCurrency;
  final String showPrice;
  final String minOrderPrice;
  final List<String> allCommonSearchWords;
  final List<CommonTrademark> allCommonTrademarks;

  const ContactInfo({
    required this.mobile,
    required this.email,
    required this.userName,
    required this.avatar,
    required this.brief,
    required this.frontColor,
    required this.frontLogo,
    required this.frontFavIcon,
    required this.frontName,
    required this.instagram,
    required this.facebook,
    required this.twitter,
    required this.tiktok,
    required this.snapchat,
    required this.youtube,
    required this.frontCurrency,
    required this.showPrice,
    required this.minOrderPrice,
    required this.allCommonSearchWords,
    required this.allCommonTrademarks,
  });

  @override
  List<Object?> get props => [
        mobile,
        email,
        userName,
        avatar,
        brief,
        frontColor,
        frontLogo,
        frontFavIcon,
        frontName,
        instagram,
        facebook,
        twitter,
        tiktok,
        snapchat,
        youtube,
        frontCurrency,
        showPrice,
        minOrderPrice,
        allCommonSearchWords,
        allCommonTrademarks,
      ];
}

class CommonTrademark extends Equatable {
  final String trademarkId;
  final String title;
  final String image;

  const CommonTrademark({
    required this.trademarkId,
    required this.title,
    required this.image,
  });

  @override
  List<Object?> get props => [
        trademarkId,
        title,
        image,
      ];
}
