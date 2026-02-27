import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieTrailerW extends StatefulWidget {
  final String youtubeKey;

  const MovieTrailerW({super.key, required this.youtubeKey});

  @override
  State<MovieTrailerW> createState() => _MovieTrailerWState();
}

class _MovieTrailerWState extends State<MovieTrailerW> {
  late final YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeKey,
      flags: YoutubePlayerFlags(autoPlay: true, mute: false),
    );
    print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! started');
  }

  @override
  Widget build(BuildContext context) {
    final player = YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
    );
    return YoutubePlayerBuilder(
      player: player,
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(title: Text('Triler')),
          body: player,
        );
      },
    );
  }
}
