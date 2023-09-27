import 'package:equatable/equatable.dart';
import '../../helper/enums.dart';

class SortModel extends Equatable {
  final String title;
  final SortStatus sortStatus;

  const SortModel({required this.title, required this.sortStatus});

  @override
  List<Object?> get props => [
        title,
        sortStatus,
      ];
}
