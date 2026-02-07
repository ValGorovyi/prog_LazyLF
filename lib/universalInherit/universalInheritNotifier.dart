import 'package:flutter/material.dart';

class UniversalInheritNitifier<Model extends ChangeNotifier>
    extends StatefulWidget {
  final Model Function() create;
  final Widget child;
  final bool isManagingModel;
  const UniversalInheritNitifier({
    super.key,
    required this.create,
    required this.child,
    this.isManagingModel = true,
  });

  @override
  _UniversalInheritNitifier<Model> createState() =>
      _UniversalInheritNitifier<Model>();

  static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<UniversalInherit<Model>>()
        ?.model;
  }

  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<UniversalInherit<Model>>()
        ?.widget;
    return widget is UniversalInherit<Model> ? widget.model : null;
  }
}

class _UniversalInheritNitifier<Model extends ChangeNotifier>
    extends State<UniversalInheritNitifier<Model>> {
  late final Model _model;
  @override
  void initState() {
    super.initState();
    _model = widget.create();
  }

  @override
  Widget build(BuildContext context) {
    return UniversalInherit(model: _model, child: widget.child);
  }

  @override
  void dispose() {
    if (widget.isManagingModel) {
      _model.dispose();
    }
    super.dispose();
  }
}

/////
class UniversalInherit<Model extends ChangeNotifier> extends InheritedNotifier {
  final Model model;

  UniversalInherit({required super.child, required this.model})
    : super(notifier: model);
}
