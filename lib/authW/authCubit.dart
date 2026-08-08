import 'dart:async' show StreamSubscription;

import 'package:bloc/bloc.dart' show Cubit;
import 'package:prog_lazy_f/domain/apiClient/apiClientExeption.dart'
    show ApiClientExeptionType, ApiClientExeption;
import 'package:prog_lazy_f/domain/blocs/authBloc.dart'
    show
        AuthAuthorizedState,
        AuthBloc,
        AuthCheckStatusInProgressState,
        AuthErrorState,
        AuthInProgressState,
        AuthLoginEvent,
        AuthState,
        AuthUnauthorizedState;

abstract class AuthVieWCubitState {}

class AuthViewCubitExpectationState extends AuthVieWCubitState {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthViewCubitExpectationState;
  }

  @override
  int get hashCode => 0;
}

class AuthVieWCubitErrorState extends AuthVieWCubitState {
  final String errorMessage;

  AuthVieWCubitErrorState(this.errorMessage);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthVieWCubitErrorState &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}

class AuthVieWCubitInProgressState extends AuthVieWCubitState {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthVieWCubitInProgressState;
  }

  @override
  int get hashCode => 0;
}

class AuthVieWCubitSuccesAuthState extends AuthVieWCubitState {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthVieWCubitSuccesAuthState;
  }

  @override
  int get hashCode => 0;
}

class AuthViewCubit extends Cubit<AuthVieWCubitState> {
  final AuthBloc authBloc;
  late final StreamSubscription<AuthState> authBlocSubscription;

  AuthViewCubit(super.initialState, this.authBloc) {
    _onState(authBloc.state);
    authBlocSubscription = authBloc.stream.listen(_onState);
  }

  bool _isValid(String login, String password) {
    return login.isNotEmpty && password.isNotEmpty;
  }

  void auth({required String login, required String password}) {
    if (!_isValid(login, password)) {
      final errState = AuthVieWCubitErrorState('Lodin or password is empty');
      emit(errState);
      return;
    }
    // emit(AuthVieWCubitState(null, true));
    authBloc.add(AuthLoginEvent(loginString: login, passwordString: password));
  }

  void _onState(AuthState state) {
    if (state is AuthUnauthorizedState) {
      emit(AuthViewCubitExpectationState());
    } else if (state is AuthAuthorizedState) {
      // authBlocSubscription.cancel();
      emit(AuthVieWCubitSuccesAuthState());
    } else if (state is AuthErrorState) {
      final message = _mapErrorToMessage(state.error);
      emit(AuthVieWCubitErrorState(message));
    } else if (state is AuthInProgressState) {
      emit(AuthVieWCubitInProgressState());
    } else if (state is AuthCheckStatusInProgressState) {
      emit(AuthVieWCubitInProgressState());
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }

  String _mapErrorToMessage(Object error) {
    if (error is! ApiClientExeption) {
      return 'Unknown error, try again later.';
    }
    switch (error.type) {
      case ApiClientExeptionType.Network:
        return 'Network error. Wi-fi???';
      case ApiClientExeptionType.Auth:
        return 'Login or password error';
      case ApiClientExeptionType.Other:
        return 'Error. Repeat pleace';
      case ApiClientExeptionType.SessionExpired:
        return 'Crazy error';
    }
  }
}

// class AuthViewModel extends ChangeNotifier {
//   final loginTextController = TextEditingController();
//   final passworldTextController = TextEditingController();

//   final _authService = AuthService();

//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;

//   bool _isAuthProgress = false;
//   bool get canStartAuth => !_isAuthProgress;
//   bool get isAuthProgress => _isAuthProgress;

//   bool _isValid(String login, String password) {
//     return login.isNotEmpty && password.isNotEmpty;
//   }

//   void _updateState(String? errorMessageArg, bool isAuthProgressArg) {
//     if (errorMessageArg == _errorMessage &&
//         isAuthProgressArg == _isAuthProgress) {
//       return;
//     }
//     _errorMessage = errorMessageArg;
//     _isAuthProgress = isAuthProgressArg;
//     notifyListeners();
//   }

//   Future<String?> _loginingProcess(String login, String password) async {
//     try {
//       await _authService.loginingMethod(login, password);
//       return null;
//     } on ApiClientExeption catch (e) {
//       switch (e.type) {
//         case ApiClientExeptionType.Network:
//           return 'Network error. Wi-fi???';
//         case ApiClientExeptionType.Auth:
//           return 'Login or password error';
//         case ApiClientExeptionType.Other:
//           return 'Error. Repeat pleace';
//         case ApiClientExeptionType.SessionExpired:
//           return 'Crazy error';
//       }
//     } catch (er) {
//       return 'Error catch. Repeat later';
//     }
//   }

//   Future<void> auth(BuildContext context) async {
//     final login = loginTextController.text;
//     final password = passworldTextController.text;

//     if (!_isValid(login, password)) {
//       _updateState('Lodin or password is empty', false);
//       return;
//     }
//     _updateState(null, true);
//     _errorMessage = await _loginingProcess(login, password);
//     if (_errorMessage == null) {
//       MainNavigation.resetNavigatot(context);
//     } else {
//       _updateState(_errorMessage, false);
//     }
//   }
// }

// class AuthInherit extends InheritedNotifier {
//   final AuthViewModel model;
//   AuthInherit({required super.child, required this.model})
//     : super(notifier: model);

//   static AuthInherit? watch(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<AuthInherit>();
//   }

//   static AuthInherit? read(BuildContext context) {
//     final widget = context
//         .getElementForInheritedWidgetOfExactType<AuthInherit>()
//         ?.widget;
//     return widget is AuthInherit ? widget : null;
//   }
// }


// 33