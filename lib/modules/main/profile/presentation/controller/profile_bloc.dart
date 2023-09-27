import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../auth/domain/usecases/update_profile_use_case.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../../../../../app/helper/enums.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/entities/page.dart';
import '../../domain/usecases/get_page_details_use_case.dart';
import '../../domain/usecases/get_pages_use_case.dart';
import '../../../auth/domain/usecases/get_user_data_use_case.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserDataUseCase getUserDataUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final GetPagesUseCase getPagesUseCase;
  final GetPageDetailsUseCase getPageDetailsUseCase;
  ProfileBloc({
    required this.getUserDataUseCase,
    required this.updateProfileUseCase,
    required this.getPagesUseCase,
    required this.getPageDetailsUseCase,
  }) : super(const ProfileState()) {
    on<GetUserDataEvent>(_getUserData);
    on<UpdateProfileEvent>(_updateProfile);
    on<GetPagesEvent>(_getPages);
    on<GetPageDetailsEvent>(_getPageDetails);
  }

  FutureOr<void> _getUserData(
      GetUserDataEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(userStatus: Status.initial));
    Either<Failure, User> result =
        await getUserDataUseCase(const NoParameters());
    result.fold(
        (failure) => emit(state.copyWith(userStatus: Status.error, user: null)),
        (user) => emit(state.copyWith(userStatus: Status.loaded, user: user)));
  }

  FutureOr<void> _updateProfile(
      UpdateProfileEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(userStatus: Status.loading));
    Either<Failure, User> result =
        await updateProfileUseCase(event.updateInputs);
    result.fold(
      (failure) => emit(
        state.copyWith(
          userStatus: Status.error,
          user: state.user,
          msg: failure.msg,
        ),
      ),
      (user) => emit(
        state.copyWith(
          userStatus: Status.loaded,
          user: user,
        ),
      ),
    );
  }

  FutureOr<void> _getPages(
      GetPagesEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(pagesStatus: Status.loading));
    Either<Failure, List<PageEntity>> result =
        await getPagesUseCase(const NoParameters());
    result.fold(
      (failure) => emit(state.copyWith(pagesStatus: Status.error, pages: [])),
      (pageList) => emit(
        state.copyWith(
          pagesStatus: Status.loaded,
          pages: pageList,
        ),
      ),
    );
  }

  FutureOr<void> _getPageDetails(
      GetPageDetailsEvent event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(pageDetailsStatus: Status.loading));
    Either<Failure, PageEntity> result =
        await getPageDetailsUseCase(event.pageId);
    result.fold(
      (failure) => emit(
        state.copyWith(
          pageDetailsStatus: Status.error,
          pageDetails: null,
        ),
      ),
      (page) => emit(
        state.copyWith(
          pageDetailsStatus: Status.loaded,
          pageDetails: page,
        ),
      ),
    );
  }
}
