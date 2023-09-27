
import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel(
      {required String id,
      required String parent,
      required String keyWord,
      required String serImage,
      required String serviceSystemCommission,
      required String serName,
      required String parentName,
      required bool haveSubService,
      required List<SlidersCat> sliders})
      : super(
          id: id,
          parent: parent,
          keyWord: keyWord,
          serImage: serImage,
          serviceSystemCommission: serviceSystemCommission,
          serName: serName,
          parentName: parentName,
          haveSubService: haveSubService,
          sliders: sliders,
        );
  factory CategoryModel.fromJson(Map<String, dynamic> map) => CategoryModel(
        id: map['id'],
        parent: map['parent'] ?? '',
        keyWord: map['key_word'] ?? '',
        serImage: map['ser_image'] ?? '',
        serviceSystemCommission: map['service_system_commission'] ?? '',
        serName: map['ser_name'] ?? '',
        parentName: map['parentName'] ?? '',
        haveSubService:map['haveSubService']??false ,
        sliders: (map['sliders'] as List)
            .map((e) => SlidersCatModel.fromJson(e))
            .toList(),
      );
}

class SlidersCatModel extends SlidersCat {
  const SlidersCatModel({
    required String id,
    required String name,
  }) : super(id: id, name: name);
  factory SlidersCatModel.fromJson(Map<String, dynamic> map) => SlidersCatModel(
        id: map['id'],
        name: map['name'],
      );
}
