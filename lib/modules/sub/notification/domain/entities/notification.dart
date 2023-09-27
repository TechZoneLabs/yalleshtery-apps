import 'package:equatable/equatable.dart';

class Notification extends Equatable {
  final String id;
  final String pageType;
  final String url;
  final String status;
  final String dateAdded;
  final String image;
  final String title;
  final String content;

  const Notification({
    required this.id,
    required this.pageType,
    required this.url,
    required this.status,
    required this.dateAdded,
    required this.image,
    required this.title,
    required this.content,
  });
  Notification copyWith({String? status}) => Notification(
      id: id,
      pageType: pageType,
      url: url,
      status: status ?? this.status,
      dateAdded: dateAdded,
      image: image,
      title: title,
      content: content);
  @override
  List<Object?> get props => [
        id,
        pageType,
        url,
        status,
        dateAdded,
        image,
        title,
        content,
      ];
}
