part of 'control_bloc.dart';

class ControlState extends Equatable {
  final Status controlStatus;
  final ContactInfo? contactInfo;

  const ControlState({this.controlStatus = Status.sleep, this.contactInfo});
  ControlState copyWith({
    Status? controlStatus,
    ContactInfo? contactInfo,
  }) =>
      ControlState(
          controlStatus: controlStatus ?? this.controlStatus,
          contactInfo: contactInfo ?? this.contactInfo);
  @override
  List<Object?> get props => [
        controlStatus,
        contactInfo,
      ];
}
