import 'package:flutter/material.dart';
import 'package:prog_lazy_f/cardsList/movieCardsListModel.dart'
    show MovieCardsListModel;
import 'package:prog_lazy_f/domain/apiClient/imageDownloader.dart'
    show ImageDownloader;

import 'package:provider/provider.dart';

class MovieCards extends StatefulWidget {
  const MovieCards({super.key});

  @override
  State<MovieCards> createState() => _MovieCardsState();
}

class _MovieCardsState extends State<MovieCards> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<MovieCardsListModel>().setupLocate(context);
  }

  // void tabToMovie(index) {
  @override
  Widget build(BuildContext context) {
    // final model = context.watch<MovieCardsListModel>();
    return Stack(children: [_MovieListItemsW(), _SearchW()]);
  }
}

class _SearchW extends StatelessWidget {
  const _SearchW();

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieCardsListModel>();
    return Padding(
      padding: EdgeInsetsGeometry.only(top: 4),
      child: TextField(
        onChanged: model.searchMovie,
        decoration: InputDecoration(
          labelText: 'Search',
          filled: true,
          fillColor: Colors.white.withAlpha(235),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}

class _MovieListItemsW extends StatelessWidget {
  const _MovieListItemsW();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieCardsListModel>();
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.only(top: 52),
      itemCount: model.movies.length,
      itemExtent: 164,

      itemBuilder: (BuildContext context, int index) {
        model.showMovieAtIndex(index);
        return _MovieListRowItemW(indexMovie: index);
      },
    );
  }
}

class _MovieListRowItemW extends StatelessWidget {
  final int indexMovie;
  const _MovieListRowItemW({required this.indexMovie});
  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieCardsListModel>();

    final oneMovie = model.movies[indexMovie];
    final movieImageSrc = oneMovie.posterPath;
    // model.showMovieAtIndex(indexMovie);
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 8),
      child: Stack(
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
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
            child: Row(
              children: [
                // Image(image: AssetImage(oneMovie.imageMovie)),
                if (movieImageSrc != null)
                  Image.network(
                    ImageDownloader.imageUrl(movieImageSrc),
                    width: 95,
                  ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        oneMovie.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        oneMovie.releaseDate,
                        style: TextStyle(color: Colors.black45),
                      ),
                      SizedBox(height: 20),
                      Text(
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(),
                        oneMovie.overview,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 6),
              ],
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () => model.onMovieTap(context, indexMovie),
            ),
          ),
        ],
      ),
    );
  }
}

// class Movie {
//   final String imageMovie;
//   final String title;
//   final String date;
//   final int id;

//   final String description;
//   Movie({
//     required this.date,
//     required this.description,
//     required this.imageMovie,
//     required this.title,
//     required this.id,
//   });
// }

  // final List<Movie> _moviesDemoList = [
  //   Movie(
  //     date: '25, December, 2009',
  //     description:
  //         'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
  //     imageMovie: ImagesWidg.heidiImageAdres,
  //     title: 'SpiderMan',
  //     id: 0,
  //   ),
  //   Movie(
  //     date: '25, December, 2009',
  //     description:
  //         'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
  //     imageMovie: ImagesWidg.heidiImageAdres,
  //     title: 'Crazy Frog',
  //     id: 1,
  //   ),
  //   Movie(
  //     date: '25, December, 2009',
  //     description:
  //         'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
  //     imageMovie: ImagesWidg.heidiImageAdres,
  //     title: 'Terrys Orange',
  //     id: 2,
  //   ),
  //   Movie(
  //     date: '25, December, 2009',
  //     description:
  //         'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
  //     imageMovie: ImagesWidg.heidiImageAdres,
  //     title: 'Cars',
  //     id: 3,
  //   ),
  //   Movie(
  //     date: '25, December, 2009',
  //     description:
  //         'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
  //     imageMovie: ImagesWidg.heidiImageAdres,
  //     title: 'Escimo Callboy',
  //     id: 4,
  //   ),
  //   Movie(
  //     date: '25, December, 2009',
  //     description:
  //         'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
  //     imageMovie: ImagesWidg.heidiImageAdres,
  //     title: 'Bad Code',
  //     id: 5,
  //   ),
  //   Movie(
  //     date: '25, December, 2009',
  //     description:
  //         'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
  //     imageMovie: ImagesWidg.heidiImageAdres,
  //     title: 'Without Knife',
  //     id: 6,
  //   ),
  //   Movie(
  //     date: '25, December, 2009',
  //     description:
  //         'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
  //     imageMovie: ImagesWidg.heidiImageAdres,
  //     title: 'Ground Ture',
  //     id: 7,
  //   ),
  //   Movie(
  //     date: '25, December, 2009',
  //     description:
  //         'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
  //     imageMovie: ImagesWidg.heidiImageAdres,
  //     title: 'Avatar 2',
  //     id: 8,
  //   ),
  //   Movie(
  //     date: '25, December, 2009',
  //     description:
  //         'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
  //     imageMovie: ImagesWidg.heidiImageAdres,
  //     title: 'Demi Murych',
  //     id: 9,
  //   ),
  //   Movie(
  //     date: '25, December, 2009',
  //     description:
  //         'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
  //     imageMovie: ImagesWidg.heidiImageAdres,
  //     title: 'Asus',
  //     id: 10,
  //   ),
  //   Movie(
  //     date: '25, December, 2009',
  //     description:
  //         'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
  //     imageMovie: ImagesWidg.heidiImageAdres,
  //     title: 'Barach Obama',
  //     id: 11,
  //   ),
  //   Movie(
  //     date: '25, December, 2009',
  //     description:
  //         'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
  //     imageMovie: ImagesWidg.heidiImageAdres,
  //     title: 'ibuprophen 3',
  //     id: 12,
  //   ),
  //   Movie(
  //     date: '25, December, 2009',
  //     description:
  //         'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
  //     imageMovie: ImagesWidg.heidiImageAdres,
  //     title: 'Pupa',
  //     id: 13,
  //   ),
  //   Movie(
  //     date: '25, December, 2009',
  //     description:
  //         'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
  //     imageMovie: ImagesWidg.heidiImageAdres,
  //     title: 'Bus driver',
  //     id: 14,
  //   ),
  //   Movie(
  //     date: '25, December, 2009',
  //     description:
  //         'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
  //     imageMovie: ImagesWidg.heidiImageAdres,
  //     title: 'Tony Hawk undeground 2',
  //     id: 15,
  //   ),
  //   Movie(
  //     date: '25, December, 2009',
  //     description:
  //         'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
  //     imageMovie: ImagesWidg.heidiImageAdres,
  //     title: 'Wood',
  //     id: 16,
  //   ),
  //   Movie(
  //     date: '25, December, 2009',
  //     description:
  //         'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
  //     imageMovie: ImagesWidg.heidiImageAdres,
  //     title: 'Mechanick lemon',
  //     id: 17,
  //   ),
  // ];