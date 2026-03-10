import 'package:flutter/material.dart';
import 'package:prog_lazy_f/domain/entity/movieDetailsCredits.dart'
    show Employee;
import 'package:prog_lazy_f/movieCardW/movieCardDetailsModel.dart'
    show MovieCardDetailsModel;
import 'package:prog_lazy_f/universalInherit/universalInheritNotifier.dart'
    show UniversalInheritNitifier;

import 'textColorRGBA.dart';

class DetailsCardMovieW extends StatelessWidget {
  const DetailsCardMovieW({super.key});

  @override
  Widget build(BuildContext context) {
    final model = UniversalInheritNitifier.watch<MovieCardDetailsModel>(
      context,
    );
    if (model == null) return SizedBox.shrink();
    var crew = model.movieDetails?.credits.crew;
    if (crew == null || crew.isEmpty) return SizedBox.shrink();
    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;

    var crewChunks = <List<Employee>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChunks.add(
        crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: crewChunks
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
  final List<Employee> employes;
  const _CrewWidget({required this.employes});
  @override
  Widget build(BuildContext context) {
    final model = UniversalInheritNitifier.watch<MovieCardDetailsModel>(
      context,
    );
    if (model == null) return SizedBox.shrink();
    var crew = model.movieDetails?.credits.crew;
    if (crew == null || crew.isEmpty) return SizedBox.shrink();
    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;

    var crewChunks = <List<Employee>>[];
    for (var i = 0; i < crew.length; i += 2) {
      crewChunks.add(
        crew.sublist(i, i + 2 > crew.length ? crew.length : i + 2),
      );
    }
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: employes
          .map((employee) => _ColumnEmployeeW(employee: employee))
          .toList(),
    );
  }
}

class _ColumnEmployeeW extends StatelessWidget {
  final Employee employee;
  _ColumnEmployeeW({required this.employee});

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
