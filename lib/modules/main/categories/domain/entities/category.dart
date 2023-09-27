import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String id;
  final String parent;
  final String keyWord;
  final String serImage;
  final String serviceSystemCommission;
  final String serName;
  final String parentName;
  final bool haveSubService;
  final List<SlidersCat> sliders;

  const Category({
    required this.id,
    required this.parent,
    this.keyWord = '',
    this.serImage = '',
    this.serviceSystemCommission = '',
    required this.serName,
    this.parentName = '',
    this.haveSubService = true,
    this.sliders = const [],
  });

  @override
  List<Object?> get props => [
        id,
        parent,
        keyWord,
        serImage,
        serviceSystemCommission,
        serName,
        parentName,
        haveSubService,
        sliders,
      ];
}

class SlidersCat extends Equatable {
  final String id;
  final String name;

  const SlidersCat({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
