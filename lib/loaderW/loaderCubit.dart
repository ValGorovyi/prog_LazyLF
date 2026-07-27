import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:prog_lazy_f/domain/blocs/authBloc.dart';

enum LoaderVievCubitState { authorized, notAuthorized, unknown }

class LoaderViewCubit extends Cubit<LoaderVievCubitState> {
  final AuthBloc authBloc;
  late final StreamSubscription<AuthState> authBlocSubscription;
  LoaderViewCubit(LoaderVievCubitState initialState, this.authBloc)
    : super(initialState) {
    authBloc.add(AuthCheckStatusEvent());
    _onState(authBloc.state);
    authBlocSubscription = authBloc.stream.listen(_onState);
  }

  void _onState(AuthState state) {
    if (state is AuthAuthorizedState) {
      emit(LoaderVievCubitState.authorized);
    } else if (state is AuthUnauthorizedState) {
      emit(LoaderVievCubitState.notAuthorized);
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}

// class LoaderVieWModel {
//   BuildContext context;
//   final _authService = AuthService();
//   LoaderVieWModel(this.context) {
//     asyncInit();
//   }

//   Future<void> asyncInit() async {
//     await checkAuth();
//   }

//   Future<void> checkAuth() async {
//     final isAuth = await _authService.isAuth();
//     final nextScreen = isAuth
//         ? NavigationRoutesNames.mainRoute
//         : NavigationRoutesNames.authRoute;
//     Navigator.of(context).pushReplacementNamed(nextScreen);
//   }
// }
