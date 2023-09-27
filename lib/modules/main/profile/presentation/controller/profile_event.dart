part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class GetUserDataEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final UpdateInputs updateInputs;
  const UpdateProfileEvent({required this.updateInputs});
}

class GetPagesEvent extends ProfileEvent {}

class GetPageDetailsEvent extends ProfileEvent {
  final String pageId;

  const GetPageDetailsEvent({required this.pageId});
}
