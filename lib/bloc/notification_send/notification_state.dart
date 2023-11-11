part of 'notification_bloc.dart';

class NotificationState extends Equatable {
  final String statusText;
  final AlldataFromnotify allDataFromNotify;
  final List<FcmResponseModel> data;
  final FormStatus status;

  const NotificationState({
   required this.data,
    required this.allDataFromNotify,
    this.statusText = "",
    this.status = FormStatus.pure,
  });

  NotificationState copyWith({
    List<FcmResponseModel>? data,
    String? statusText,
    AlldataFromnotify? allDataFromNotify,
    FormStatus? status,
  }) =>
      NotificationState(
        data: data ?? this.data,
        statusText: statusText ?? this.statusText,
        status: status ?? this.status,
        allDataFromNotify: allDataFromNotify ?? this.allDataFromNotify,
      );

  @override
  List<Object?> get props => [
        allDataFromNotify,
        statusText,
        status,
        data,
      ];
}
