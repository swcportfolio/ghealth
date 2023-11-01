import 'package:flutter/material.dart';
import 'package:ghealth_app/widgets/frame.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../utils/colors.dart';

/// Define a Flutter widget for a YouTube video player.
class YoutubeVideoPlayer extends StatelessWidget {
  YoutubeVideoPlayer({super.key});

  final YoutubePlayerController _youtubePlayerController =
      YoutubePlayerController(
    initialVideoId: '${YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=ln3uXP1czi4")}',
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Frame.myText(
              text: '참여자 리뷰 및 현장',
              fontWeight: FontWeight.bold,
              fontSize: 1.4,
              color: Colors.black,
              align: TextAlign.start),
        ),
        Container(
          height: 300,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: YoutubePlayer(
              controller: _youtubePlayerController,
              showVideoProgressIndicator: true,
              liveUIColor: mainColor,
              progressColors: const ProgressBarColors(
                  backgroundColor: mainColor,
                  bufferedColor: mainColor,
                  playedColor: mainColor,
                  handleColor: mainColor),
              progressIndicatorColor: mainColor, // 진행 표시 막대 색상 설정
            ),
          ),
        ),
      ],
    );
  }
}
