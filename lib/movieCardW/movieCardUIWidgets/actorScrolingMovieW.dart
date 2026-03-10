import 'package:flutter/material.dart';
import 'package:prog_lazy_f/domain/apiClient/apiClient.dart' show ApiClient;
import 'package:prog_lazy_f/movieCardW/movieCardDetailsModel.dart'
    show MovieCardDetailsModel;
import 'package:prog_lazy_f/universalInherit/universalInheritNotifier.dart'
    show UniversalInheritNitifier;

class ActorScrolingMovieW extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = UniversalInheritNitifier.watch<MovieCardDetailsModel>(
      context,
    );
    var casts = model?.movieDetails?.credits.cast;

    if (casts == null || casts.isEmpty) return SizedBox.fromSize();
    final lengthBuilder = casts.length;
    return ColoredBox(
      color: Colors.white70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text('Series Cart'),
          ),
          SizedBox(
            height: 242,
            child: Scrollbar(
              child: _ActorListBuilder(lengthBuilder: lengthBuilder),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2),
            child: TextButton(
              onPressed: () {},
              child: Text('Full card & crew'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActorListBuilder extends StatelessWidget {
  final int lengthBuilder;
  const _ActorListBuilder({required this.lengthBuilder});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lengthBuilder,
      itemExtent: 120,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return _ActorItemW(actorIndex: index);
      },
    );
  }
}

class _ActorItemW extends StatelessWidget {
  final int actorIndex;
  const _ActorItemW({required this.actorIndex});

  @override
  Widget build(BuildContext context) {
    final model = UniversalInheritNitifier.read<MovieCardDetailsModel>(context);
    final actorItemData = model!.movieDetails!.credits.cast[actorIndex];
    final actorImagePath = actorItemData.profilePath;
    return Padding(
      padding: EdgeInsetsGeometry.all(8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,

              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadiusGeometry.circular(10),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          clipBehavior: Clip.hardEdge,
          child: Column(
            children: [
              actorImagePath != null
                  ? Image.network(
                      ApiClient.imageUrl(actorImagePath),
                      width: 120,
                      height: 120,
                      fit: BoxFit.fitWidth,
                    )
                  : SizedBox.shrink(),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(actorItemData.name, maxLines: 1),
                    Text(actorItemData.character ?? '!!!', maxLines: 3),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
