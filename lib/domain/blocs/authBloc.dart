import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prog_lazy_f/domain/apiClient/accountApiClient.dart';
import 'package:prog_lazy_f/domain/apiClient/authApiClient.dart';
import 'package:prog_lazy_f/domain/apiClient/dataProvider.dart';

abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String loginString;
  final String passwordString;

  AuthLoginEvent({required this.loginString, required this.passwordString});
}

class AuthLogoutEvent extends AuthEvent {}

class AuthCheckStatusEvent extends AuthEvent {}

enum AuthStateStatus { authorized, notAuthorized, inProgress }

//////////////////////////////
abstract class AuthState {}

class AuthAuthorizedState extends AuthState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AuthAuthorizedState && runtimeType == other.runtimeType;
  }

  @override
  int get hashCode => 0;
}

class AuthErrorState extends AuthState {
  final Object error;

  AuthErrorState({required this.error});

  @override
  bool operator ==(covariant AuthErrorState other) {
    if (identical(this, other)) return true;

    return other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}

class AuthInProgressState extends AuthState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AuthInProgressState && runtimeType == other.runtimeType;
  }

  @override
  int get hashCode => 0;
}

class AuthCheckStatusInProgressState extends AuthState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is AuthCheckStatusInProgressState &&
            runtimeType == other.runtimeType;
  }

  @override
  int get hashCode => 0;
}

class AuthUnauthorizedState extends AuthState {
  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is AuthUnauthorizedState;
  }

  @override
  int get hashCode => 0;
}

/////////////////////////////////////
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _sessionDataProvider = SessionDataProvider();
  final _accountApiClient = AccountApiClient();
  final _authApiCliet = AuthApiClient();

  AuthBloc(AuthState initialState) : super(initialState) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthCheckStatusEvent) {
        await onAuthCheckStatusEvent(event, emit);
      } else if (event is AuthLogoutEvent) {
        await onAuthLogoutEvent(event, emit);
      } else if (event is AuthLoginEvent) {
        await onAuthLoginEvent(event, emit);
      }
    }, transformer: sequential());

    // on<AuthCheckStatusEvent>((event, emit) async {
    //   final sessionId = await _sessionDataProvider.getSessionId();
    //   final isAuthBool = sessionId != null;
    //   final newState = isAuthBool
    //       ? AuthAuthorizedState()
    //       : AuthUnauthorizedState();
    //   emit(newState);
    // });

    // on<AuthLogoutEvent>((event, emit) async {
    //   try {
    //     await _sessionDataProvider.deleteSessionId();
    //     await _sessionDataProvider.deleteAccountId();
    //   } catch (er) {
    //     emit(AuthErrorState(error: er));
    //   }
    // });
    // on<AuthLoginEvent>((event, emit) async {
    //   try {
    //     final sessionId = await _authApiCliet.auth(
    //       username: event.loginString,
    //       password: event.passwordString,
    //     );
    //     final accountId = await _accountApiClient.getAccId(sessionId);
    //     await _sessionDataProvider.setSessionId(sessionId);
    //     await _sessionDataProvider.setAccountId(accountId);
    //     emit(AuthAuthorizedState());
    //   } catch (er) {
    //     emit(AuthErrorState(error: er));
    //   }

    //   final sessionId = await _authApiCliet.auth(
    //     username: event.loginString,
    //     password: event.passwordString,
    //   );
    //   final accountId = await _accountApiClient.getAccId(sessionId);
    //   await _sessionDataProvider.setSessionId(sessionId);
    //   await _sessionDataProvider.setAccountId(accountId);
    //   emit(AuthAuthorizedState());
    // });
    add(AuthCheckStatusEvent());
  }

  Future<void> onAuthCheckStatusEvent(
    AuthCheckStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final isAuthBool = sessionId != null;
    final newState = isAuthBool
        ? AuthAuthorizedState()
        : AuthUnauthorizedState();
    emit(newState);
  }

  Future<void> onAuthLogoutEvent(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _sessionDataProvider.deleteSessionId();
      await _sessionDataProvider.deleteAccountId();
    } catch (er) {
      emit(AuthErrorState(error: er));
    }
  }

  Future<void> onAuthLoginEvent(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final sessionId = await _authApiCliet.auth(
        username: event.loginString,
        password: event.passwordString,
      );
      final accountId = await _accountApiClient.getAccId(sessionId);
      await _sessionDataProvider.setSessionId(sessionId);
      await _sessionDataProvider.setAccountId(accountId);
      emit(AuthAuthorizedState());
    } catch (er) {
      emit(AuthErrorState(error: er));
    }

    emit(AuthAuthorizedState());
  }
}
