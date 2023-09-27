import 'package:equatable/equatable.dart';
import '../../../brands/domain/entities/trademark.dart';
import 'category.dart';

class MixSubTrade extends Equatable {
  final List<Category> subCategories;
  final List<Trademark> trademarks;

  const MixSubTrade({required this.subCategories, required this.trademarks});

  @override
  List<Object?> get props => [subCategories, trademarks];
}
