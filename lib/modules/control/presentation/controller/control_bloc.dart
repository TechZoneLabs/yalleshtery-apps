import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../app/helper/enums.dart';

import '../../../../app/common/usecase/base_use_case.dart';
import '../../../../app/errors/failure.dart';
import '../../domain/entities/contact_info.dart';
import '../../domain/usecases/contact_info_use_case.dart';

part 'control_event.dart';
part 'control_state.dart';

class ControlBloc extends Bloc<ControlEvent, ControlState> {
  final ContactInfoUseCase contactInfoUseCase;
  ControlBloc({required this.contactInfoUseCase})
      : super(const ControlState()) {
    on<GetContactInfoEvent>(_getContactInfo);
  }
  ContactInfo? _contactInfo;
  ContactInfo? get contactInfo => _contactInfo;

  FutureOr<void> _getContactInfo(
      GetContactInfoEvent event, Emitter<ControlState> emit) async {
    emit(state.copyWith(controlStatus: Status.loading));
    Either<Failure, ContactInfo> result =
        await contactInfoUseCase(const NoParameters());
    result.fold(
      (failure) => emit(state.copyWith(controlStatus: Status.error)),
      (contactInfo) {
        _contactInfo = contactInfo;
        emit(
          state.copyWith(
            controlStatus: Status.loaded,
            contactInfo: _contactInfo,
          ),
        );
      },
    );
  }
}
