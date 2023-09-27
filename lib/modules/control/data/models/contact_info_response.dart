import 'contact_info_model.dart';

class ContactInfoResponse {
  final bool success;
  final ContactInfoModel data;

  ContactInfoResponse({
    required this.success,
    required this.data,
  });
  factory ContactInfoResponse.fromJson(Map<String, dynamic> map) =>
      ContactInfoResponse(
        success: map['success'],
        data: ContactInfoModel.fromJson(map['data']),
      );
}
