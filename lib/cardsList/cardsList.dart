import 'package:flutter/material.dart';
import 'package:prog_lazy_f/imagesW/imagesForW.dart';

class MovieCards extends StatefulWidget {
  const MovieCards({super.key});

  @override
  State<MovieCards> createState() => _MovieCardsState();
}

class _MovieCardsState extends State<MovieCards> {
  final List<Movie> _moviesDemoList = [
    Movie(
      date: '25, December, 2009',
      description:
          'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
      imageMovie: ImagesWidg.heidiImageAdres,
      title: 'SpiderMan',
      id: 0,
    ),
    Movie(
      date: '25, December, 2009',
      description:
          'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
      imageMovie: ImagesWidg.heidiImageAdres,
      title: 'Crazy Frog',
      id: 1,
    ),
    Movie(
      date: '25, December, 2009',
      description:
          'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
      imageMovie: ImagesWidg.heidiImageAdres,
      title: 'Terrys Orange',
      id: 2,
    ),
    Movie(
      date: '25, December, 2009',
      description:
          'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
      imageMovie: ImagesWidg.heidiImageAdres,
      title: 'Cars',
      id: 3,
    ),
    Movie(
      date: '25, December, 2009',
      description:
          'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
      imageMovie: ImagesWidg.heidiImageAdres,
      title: 'Escimo Callboy',
      id: 4,
    ),
    Movie(
      date: '25, December, 2009',
      description:
          'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
      imageMovie: ImagesWidg.heidiImageAdres,
      title: 'Bad Code',
      id: 5,
    ),
    Movie(
      date: '25, December, 2009',
      description:
          'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
      imageMovie: ImagesWidg.heidiImageAdres,
      title: 'Without Knife',
      id: 6,
    ),
    Movie(
      date: '25, December, 2009',
      description:
          'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
      imageMovie: ImagesWidg.heidiImageAdres,
      title: 'Ground Ture',
      id: 7,
    ),
    Movie(
      date: '25, December, 2009',
      description:
          'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
      imageMovie: ImagesWidg.heidiImageAdres,
      title: 'Avatar 2',
      id: 8,
    ),
    Movie(
      date: '25, December, 2009',
      description:
          'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
      imageMovie: ImagesWidg.heidiImageAdres,
      title: 'Demi Murych',
      id: 9,
    ),
    Movie(
      date: '25, December, 2009',
      description:
          'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
      imageMovie: ImagesWidg.heidiImageAdres,
      title: 'Asus',
      id: 10,
    ),
    Movie(
      date: '25, December, 2009',
      description:
          'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
      imageMovie: ImagesWidg.heidiImageAdres,
      title: 'Barach Obama',
      id: 11,
    ),
    Movie(
      date: '25, December, 2009',
      description:
          'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
      imageMovie: ImagesWidg.heidiImageAdres,
      title: 'ibuprophen 3',
      id: 12,
    ),
    Movie(
      date: '25, December, 2009',
      description:
          'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
      imageMovie: ImagesWidg.heidiImageAdres,
      title: 'Pupa',
      id: 13,
    ),
    Movie(
      date: '25, December, 2009',
      description:
          'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
      imageMovie: ImagesWidg.heidiImageAdres,
      title: 'Bus driver',
      id: 14,
    ),
    Movie(
      date: '25, December, 2009',
      description:
          'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
      imageMovie: ImagesWidg.heidiImageAdres,
      title: 'Tony Hawk undeground 2',
      id: 15,
    ),
    Movie(
      date: '25, December, 2009',
      description:
          'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
      imageMovie: ImagesWidg.heidiImageAdres,
      title: 'Wood',
      id: 16,
    ),
    Movie(
      date: '25, December, 2009',
      description:
          'Musical comedy sequel starring Anna Kendrick and Rebel Wilson. After a humiliating show in front of the President, the Barden Bellas a cappella g.',
      imageMovie: ImagesWidg.heidiImageAdres,
      title: 'Mechanick lemon',
      id: 17,
    ),
  ];

  void tabToMovie(index) {
    final id = _moviesDemoList[index].id;
    Navigator.of(context).pushNamed('/main/movieid', arguments: id);
  }

  final _searchController = TextEditingController();

  var filteredMovies = <Movie>[];

  void _searchMovies() {
    final queryText = _searchController.text;
    if (queryText.isNotEmpty) {
      filteredMovies = _moviesDemoList.where((Movie movie) {
        return movie.title.toUpperCase().contains(queryText.toUpperCase());
      }).toList();
    } else {
      filteredMovies = _moviesDemoList;
    }
    setState(() {});
  }

  @override
  void initState() {
    _searchMovies();
    _searchController.addListener(_searchMovies);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          physics: BouncingScrollPhysics(),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(top: 52),
          itemCount: filteredMovies.length,
          itemExtent: 164,

          itemBuilder: (BuildContext context, int index) {
            final oneMovie = filteredMovies[index];
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
                        Image(image: AssetImage(oneMovie.imageMovie)),
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
                                oneMovie.date,
                                style: TextStyle(color: Colors.black45),
                              ),
                              SizedBox(height: 20),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(),
                                oneMovie.description,
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
                      onTap: () {
                        tabToMovie(index);
                      },
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
            controller: _searchController,
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

class Movie {
  final String imageMovie;
  final String title;
  final String date;
  final int id;

  final String description;
  Movie({
    required this.date,
    required this.description,
    required this.imageMovie,
    required this.title,
    required this.id,
  });
}
