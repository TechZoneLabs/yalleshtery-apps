import '../../domain/entities/contact_info.dart';

class ContactInfoModel extends ContactInfo {
  const ContactInfoModel({
    required String mobile,
    required String email,
    required String userName,
    required String avatar,
    required String brief,
    required String frontColor,
    required String frontLogo,
    required String frontFavIcon,
    required String frontName,
    required String instagram,
    required String facebook,
    required String twitter,
    required String tiktok,
    required String snapchat,
    required String youtube,
    required String frontCurrency,
    required String showPrice,
    required String minOrderPrice,
    required List<String> allCommonSearchWords,
    required List<CommonTrademark> allCommonTrademarks,
  }) : super(
          mobile: mobile,
          email: email,
          userName: userName,
          avatar: avatar,
          brief: brief,
          frontColor: frontColor,
          frontLogo: frontLogo,
          frontFavIcon: frontFavIcon,
          frontName: frontName,
          instagram: instagram,
          facebook: facebook,
          twitter: twitter,
          tiktok: tiktok,
          snapchat: snapchat,
          youtube: youtube,
          frontCurrency: frontCurrency,
          showPrice: showPrice,
          minOrderPrice: minOrderPrice,
          allCommonSearchWords: allCommonSearchWords,
          allCommonTrademarks: allCommonTrademarks,
        );
  factory ContactInfoModel.fromJson(Map<String, dynamic> map) =>
      ContactInfoModel(
        mobile: map['mobile'],
        email: map['email'],
        userName: map['user_name'],
        avatar: map['avatar'],
        brief: map['brief'],
        frontColor: map['front_color'],
        frontLogo: map['front_logo'],
        frontFavIcon: map['front_fav_icon'],
        frontName: map['front_name'],
        instagram: map['instagram'],
        facebook: map['instagram'],
        twitter: map['instagram'],
        tiktok: map['tiktok'],
        snapchat: map['snapchat'],
        youtube: map['youtube'],
        frontCurrency: map['front_currency'],
        showPrice: map['show_price'],
        minOrderPrice: map['minimum_order_price'],
        allCommonSearchWords: map.containsKey('all_common_search_words')
            ? (map['all_common_search_words'] as List)
                .map((e) => e['name'].toString())
                .toList()
            : [],
        allCommonTrademarks: (map['all_common_trademarks'] as List)
            .map((e) => CommonTrademarkModel.fromJson(e))
            .toList(),
      );
}

class CommonTrademarkModel extends CommonTrademark {
  const CommonTrademarkModel({
    required String trademarkId,
    required String title,
    required String image,
  }) : super(
          trademarkId: trademarkId,
          title: title,
          image: image,
        );
  factory CommonTrademarkModel.fromJson(Map<String, dynamic> map) =>
      CommonTrademarkModel(
        trademarkId: map['trademark_id'],
        title: map['title'],
        image: map['image'],
      );
}
