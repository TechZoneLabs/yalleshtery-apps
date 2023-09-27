import 'cart_model.dart';

class CouponInfoResponse {
  final bool success;
  final CouponInfoModel? data;
  final String message;

  CouponInfoResponse({
    required this.success,
    this.data,
    this.message = '',
  });
  factory CouponInfoResponse.fromJson(Map<String, dynamic> map) =>
      CouponInfoResponse(
        success: map['success'],
        data: map.containsKey('data')
            ? CouponInfoModel.fromJson(map['data'])
            : null,
        message: map['message'] ?? '',
      );
}
