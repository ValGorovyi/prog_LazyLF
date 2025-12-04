import 'package:flutter/material.dart';

class UniversalInheritNitifier<Model extends ChangeNotifier>
    extends InheritedNotifier {
  final Model model;

  UniversalInheritNitifier({required super.child, required this.model})
    : super(notifier: model);
  static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<UniversalInheritNitifier<Model>>()
        ?.model;
  }

  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<
          UniversalInheritNitifier<Model>
        >()
        ?.widget;
    return widget is UniversalInheritNitifier<Model> ? widget.model : null;
  }
}
