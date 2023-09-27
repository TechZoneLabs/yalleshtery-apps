import 'package:equatable/equatable.dart';

class Trademark extends Equatable {
  final String id;
  final String? active;
  final String? code;
  final String? sort;
  final String image;
  final String? adminId;
  final String? dateAdded;
  final String title;

  const Trademark({
    required this.id,
    this.active,
    this.code,
    this.sort,
    required this.image,
    this.adminId,
    this.dateAdded,
    required this.title,
  });

  @override
  List<Object?> get props => [
        id,
        active,
        code,
        sort,
        image,
        adminId,
        dateAdded,
        title,
      ];
}
