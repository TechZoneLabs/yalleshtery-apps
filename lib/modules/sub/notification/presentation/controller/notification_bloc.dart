import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../app/common/usecase/base_use_case.dart';
import '../../../../../app/errors/failure.dart';
import '../../../../../app/helper/enums.dart';
import '../../domain/entities/notification.dart';
import '../../domain/usecases/delete_notification_use_case.dart';
import '../../domain/usecases/get_notification_details_use_case.dart';
import '../../domain/usecases/get_notifications_use_case.dart';
import '../../domain/usecases/get_un_read_notification_num_use_case.dart';
import '../../domain/usecases/read_notification_use_case.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final GetUnReadNotificationUseCase getUnReadNotificationUseCase;
  final DeleteNotificationUseCase deleteNotificationUseCase;
  final ReadNotificationUseCase readNotificationUseCase;
  final GetNotificationDetailsUseCase getNotificationDetailsUseCase;
  NotificationBloc({
    required this.getNotificationsUseCase,
    required this.getUnReadNotificationUseCase,
    required this.deleteNotificationUseCase,
    required this.readNotificationUseCase,
    required this.getNotificationDetailsUseCase,
  }) : super(const NotificationState()) {
    on<GetNotificationsEvent>(_getNotifications);
    on<GetUnReadNotificationEvent>(_getUnReadNotification);
    on<DeleteNotificationEvent>(_deleteNotification);
    on<ReadNotificationEvent>(_readNotification);
    on<GetNotificationDetailsEvent>(_getNotificationDetails);
  }

  FutureOr<void> _getNotifications(
      GetNotificationsEvent event, Emitter<NotificationState> emit) async {
    if (event.start == 0 || !state.isNotificationsMax) {
      emit(
        state.copyWith(
          notificationStatus:
              event.start == 0 ? Status.initial : Status.loading,
          unReadNumStatus: Status.sleep,
          notificationList: event.start == 0 ? [] : state.notificationList,
        ),
      );
      Either<Failure, List<Notification>> result =
          await getNotificationsUseCase(event.start);
      result.fold(
        (failure) => emit(
          state.copyWith(
            notificationStatus: Status.error,
            notificationList: event.start == 0 ? [] : state.notificationList,
          ),
        ),
        (notificationList) => emit(
          state.copyWith(
            notificationStatus: Status.loaded,
            notificationList: List.from(state.notificationList)
              ..addAll(notificationList),
            isNotificationsMax: notificationList.length < 10,
          ),
        ),
      );
    }
  }

  FutureOr<void> _getUnReadNotification(
      GetUnReadNotificationEvent event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(
      unReadNumStatus: Status.loading,
      readNotificationStatus: Status.sleep,
    ));
    Either<Failure, String> result =
        await getUnReadNotificationUseCase(const NoParameters());
    result.fold(
      (failure) => emit(
        state.copyWith(
          unReadNumStatus: Status.error,
          unReadNum: '0',
        ),
      ),
      (val) => emit(
        state.copyWith(
          unReadNumStatus: Status.loaded,
          unReadNum: val,
        ),
      ),
    );
  }

  FutureOr<void> _deleteNotification(
      DeleteNotificationEvent event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(
      deleteNotificationStatus: Status.loading,
      unReadNumStatus: Status.sleep,
    ));
    Either<Failure, bool> result = await deleteNotificationUseCase(event.id);
    result.fold(
      (failure) => emit(
        state.copyWith(
          deleteNotificationStatus: Status.error,
          msg: failure.msg,
        ),
      ),
      (val) => emit(
        state.copyWith(
          deleteNotificationStatus: Status.loaded,
          deleteNotificationId: event.id,
        ),
      ),
    );
  }

  FutureOr<void> _readNotification(
      ReadNotificationEvent event, Emitter<NotificationState> emit) async {
    emit(state.copyWith(
      readNotificationStatus: Status.loading,
      unReadNumStatus: Status.sleep,
    ));
    Either<Failure, bool> result = await readNotificationUseCase(event.id);
    result.fold(
      (failure) => emit(
        state.copyWith(
          readNotificationStatus: Status.error,
        ),
      ),
      (val) => emit(
        state.copyWith(
          readNotificationStatus: Status.loaded,
          readNotificationId: event.id,
        ),
      ),
    );
  }

  FutureOr<void> _getNotificationDetails(GetNotificationDetailsEvent event,
      Emitter<NotificationState> emit) async {
    emit(state.copyWith(
      notificationDetailsStatus: Status.loading,
      unReadNumStatus: Status.sleep,
    ));
    Either<Failure, Notification> result =
        await getNotificationDetailsUseCase(event.id);
    result.fold(
      (failure) => emit(
        state.copyWith(
          notificationDetailsStatus: Status.error,
          deleteNotificationStatus: null,
        ),
      ),
      (notification) => emit(
        state.copyWith(
          notificationDetailsStatus: Status.loaded,
          notificationDetails: notification,
        ),
      ),
    );
  }
}
