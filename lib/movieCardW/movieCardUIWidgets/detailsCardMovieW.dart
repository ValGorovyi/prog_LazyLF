import 'package:flutter/material.dart';

import 'package:prog_lazy_f/movieCardW/movieCardDetailsModel.dart'
    show MovieCardDetailsModel, DetailsEmployeeData;
// import 'package:prog_lazy_f/universalInherit/universalInheritNotifier.dart'
//     show UniversalInheritNitifier;
import 'package:provider/provider.dart';

import 'textColorRGBA.dart';

class DetailsCardMovieW extends StatelessWidget {
  const DetailsCardMovieW({super.key});

  @override
  Widget build(BuildContext context) {
    var crew = context.select(
      (MovieCardDetailsModel model) => model.dataCard.employeeData,
    );
    if (crew.isEmpty) SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: crew
            .map(
              (chank) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: _CrewWidget(employes: chank),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _CrewWidget extends StatelessWidget {
  final List<DetailsEmployeeData> employes;
  const _CrewWidget({required this.employes});
  @override
  Widget build(BuildContext context) {
    var crew = context.select(
      (MovieCardDetailsModel model) => model.dataCard.actotsData,
    );

    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: employes
          .map((employee) => _ColumnEmployeeW(employee: employee))
          .toList(),
    );
  }
}

class _ColumnEmployeeW extends StatelessWidget {
  final DetailsEmployeeData employee;
  const _ColumnEmployeeW({required this.employee});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            employee.job,
            style: TextStyle(color: TextCardWColor.secondColor),
          ),
          Text(
            employee.name,
            style: TextStyle(color: TextCardWColor.mainColor),
          ),
        ],
      ),
    );
  }
}
