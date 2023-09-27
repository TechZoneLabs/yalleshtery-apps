part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final String msg;
  final Status userStatus;
  final User? user;
  final Status pagesStatus;
  final List<PageEntity> pages;
  final Status pageDetailsStatus;
  final PageEntity? pageDetails;

  const ProfileState({
    this.msg = '',
    this.userStatus = Status.sleep,
    this.user,
    this.pagesStatus = Status.sleep,
    this.pages = const [],
    this.pageDetailsStatus = Status.sleep,
    this.pageDetails,
  });
  ProfileState copyWith({
    String? msg,
    Status? userStatus,
    final User? user,
    Status? pagesStatus,
    List<PageEntity>? pages,
    Status? pageDetailsStatus,
    PageEntity? pageDetails,
  }) =>
      ProfileState(
        msg: msg ?? this.msg,
        userStatus: userStatus ?? this.userStatus,
        user: user ?? this.user,
        pagesStatus: pagesStatus ?? this.pagesStatus,
        pages: pages ?? this.pages,
        pageDetailsStatus: pageDetailsStatus ?? this.pageDetailsStatus,
        pageDetails: pageDetails ?? this.pageDetails,
      );

  @override
  List<Object?> get props => [
        msg,
        userStatus,
        user,
        pagesStatus,
        pages,
        pageDetailsStatus,
        pageDetails,
      ];
}
