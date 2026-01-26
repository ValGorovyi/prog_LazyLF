import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prog_lazy_f/cardsList/movieCardsListModel.dart'
    show movieCardsListModel;
import 'package:prog_lazy_f/domain/apiClient/apiClient.dart';
import 'package:prog_lazy_f/universalInherit/universalInheritNotifier.dart'
    show UniversalInheritNitifier;

class MovieCards extends StatelessWidget {
  const MovieCards({super.key});

  // void tabToMovie(index) {
  //   final id = _moviesDemoList[index].id;
  //   Navigator.of(
  //     context,
  //   ).pushNamed(NavigationRoutesNames.idRoute, arguments: id);
  // }

  // final _searchController = TextEditingController();

  // var filteredMovies = <Movie>[];

  // void _searchMovies() {
  //   final queryText = _searchController.text;
  //   if (queryText.isNotEmpty) {
  //     filteredMovies = _moviesDemoList.where((Movie movie) {
  //       return movie.title.toUpperCase().contains(queryText.toUpperCase());
  //     }).toList();
  //   } else {
  //     filteredMovies = _moviesDemoList;
  //   }
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    final model = UniversalInheritNitifier.watch<movieCardsListModel>(context);
    if (model == null) return Text('error with model??');
    return Stack(
      children: [
        ListView.builder(
          physics: BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(top: 52),
          itemCount: model.movies.length,
          itemExtent: 164,

          itemBuilder: (BuildContext context, int index) {
            final oneMovie = model.movies[index];
            final movieImageSrc = oneMovie.posterPath;
            final movieReleaseDate = oneMovie.releaseDate;
            return Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
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
                        movieImageSrc != null
                            ? Image.network(
                                ApiClient.imageUrl(movieImageSrc),
                                width: 95,
                              )
                            : const SizedBox.shrink(),
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
                                model.stringFormatDate(movieReleaseDate),
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
                      onTap: () => model.onMovieTap(context, index),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: EdgeInsetsGeometry.only(top: 4),
          child: TextField(
            decoration: InputDecoration(
              labelText: '...',
              filled: true,
              fillColor: Colors.white.withAlpha(235),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
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