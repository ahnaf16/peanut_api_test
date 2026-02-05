import 'package:equatable/equatable.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object?> get props => [];
}

class LoggedOutEv extends AppEvent {
  const LoggedOutEv([this.reason]);

  final String? reason;
}
