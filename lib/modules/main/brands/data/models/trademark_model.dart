import '../../domain/entities/trademark.dart';

class TrademarkModel extends Trademark {
  const TrademarkModel(
      {required String id,
      String? active,
      String? code,
      String? sort,
      required String image,
      String? adminId,
      String? dateAdded,
      required String title})
      : super(
          id: id,
          active: active,
          code: code,
          sort: sort,
          image: image,
          adminId: adminId,
          dateAdded: dateAdded,
          title: title,
        );
  factory TrademarkModel.fromJson(Map<String, dynamic> map) => TrademarkModel(
        id: map['id'],
        active: map['active'] ?? '',
        code: map['code'] ?? '',
        sort: map['sort'] ?? '',
        image: map['image'] ?? '',
        adminId: map['admin_id'] ?? '',
        dateAdded: map['date_added'] ?? '',
        title: map['title'] ?? '',
      );
}
