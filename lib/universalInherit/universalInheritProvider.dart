import 'package:flutter/material.dart';

class UniversalInheritProvider<Model> extends InheritedWidget {
  final Model model;
  const UniversalInheritProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child);

  static Model? watch<Model>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<UniversalInheritProvider<Model>>()
        ?.model;
  }

  static Model? read<Model>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
          UniversalInheritProvider<Model>
        >()
        ?.widget;
    return widget is UniversalInheritProvider<Model> ? widget.model : null;
  }

  @override
  bool updateShouldNotify(UniversalInheritProvider oldWidget) {
    return model != oldWidget;
  }
}
