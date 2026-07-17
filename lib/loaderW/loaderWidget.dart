import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prog_lazy_f/loaderW/loaderModel.dart';
import 'package:prog_lazy_f/navigation/mainNavigation.dart'
    show NavigationRoutesNames;

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoaderViewCubit, LoaderVievCubitState>(
      listenWhen: (prev, current) => current != LoaderVievCubitState.unknown,
      listener: onLoaderVievCubitState,

      child: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }

  void onLoaderVievCubitState(
    BuildContext context,
    LoaderVievCubitState state,
  ) {
    final nextScreen = state == LoaderVievCubitState.authorized
        ? NavigationRoutesNames.mainRoute
        : NavigationRoutesNames.authRoute;
    Navigator.of(context).pushReplacementNamed(nextScreen);
  }
}
