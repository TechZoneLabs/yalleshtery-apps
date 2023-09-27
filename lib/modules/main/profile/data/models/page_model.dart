import '../../domain/entities/page.dart';

class PageModel extends PageEntity {
  const PageModel({
    required String id,
    required String title,
    required String image,
    String description = '',
  }) : super(
          id: id,
          title: title,
          image: image,
          description: description,
        );
  factory PageModel.fromJson(Map<String, dynamic> map) => PageModel(
        id: map['id'],
        title: map['title'],
        image: map['image'],
        description: map.containsKey('description') ? map['description'] : '',
      );
}
