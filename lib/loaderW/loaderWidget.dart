import 'package:flutter/material.dart';
import 'package:prog_lazy_f/loaderW/loaderModel.dart' show LoaderVieWModel;
import 'package:provider/provider.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
