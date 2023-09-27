import 'package:equatable/equatable.dart';

class PageEntity extends Equatable {
  final String id;
  final String title;
  final String image;
  final String description;

  const PageEntity({
    required this.id,
    required this.title,
    required this.image,
    this.description = '',
  });

  @override
  List<Object?> get props => [
        id,
        title,
        image,
        description
      ];
}
