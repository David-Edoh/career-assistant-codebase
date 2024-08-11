import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fotisia/core/app_export.dart';
import 'package:just_audio/just_audio.dart';


class AudioNoteWidget extends StatefulWidget {
  final AudioNote audioNote;
  final Function saveAudio;

  const AudioNoteWidget({super.key, required this.audioNote, required this.saveAudio});

  @override
  AudioNoteWidgetState createState() => AudioNoteWidgetState();
}

class AudioNoteWidgetState extends State<AudioNoteWidget> {

  @override
  void initState() {
    super.initState();

    // Listen to the player state changes
    widget.audioNote.audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        // When audio completes, update the seek bar position
        widget.audioNote.audioPlayer.stop();
        widget.audioNote.audioPlayer.seek(Duration.zero);
      }
    });

  }

  void _playAudio() {
    widget.audioNote.audioPlayer.setSpeed(0.9);
    widget.audioNote.audioPlayer.play();
    if(widget.audioNote.userHasListened == false){
      widget.audioNote.userHasPlayed();
      widget.saveAudio();
    }
  }

  void _pauseAudio() {
    widget.audioNote.audioPlayer.pause();
  }

  void _seekAudio(Duration position) {
    widget.audioNote.audioPlayer.seek(position);
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
      child: Row(
        children: [
          CustomImageView(
              imagePath:
              ImageConstant.imgAvatar32x32,
              height: getSize(32),
              width: getSize(32),
              radius: BorderRadius.circular(
                  getHorizontalSize(16)),
              alignment: Alignment.center),
          Stack(
            children: [
              Card(
                  shadowColor: Colors.grey,
                // elevation: 3,
                margin: const EdgeInsets.fromLTRB(20.0, 5, 20.0, 5),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 20, 8, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           StreamBuilder<bool>(
                             stream: widget.audioNote.audioPlayer.playingStream,
                             builder: (context, snapshot) {
                               final playing = snapshot.data ?? false;
                               return  !playing ? GestureDetector(
                                 onTap: _playAudio,
                                 child: const Icon(Icons.play_arrow),
                               ) : GestureDetector(
                                 onTap: _pauseAudio,
                                 child: const Icon(Icons.pause),
                               );
                             },
                           ),
                          SizedBox(
                            width: mediaQueryData.size.width * 0.6,
                            child: StreamBuilder<Duration?>(
                              stream: widget.audioNote.audioPlayer.positionStream,
                              builder: (context, snapshot) {
                                final duration = widget.audioNote.duration;
                                final position = snapshot.data ?? Duration.zero;
                                return SliderTheme(
                                  data: SliderTheme.of(context).copyWith(
                                      inactiveTrackColor: Colors.grey.withOpacity(0.5),
                                    thumbShape: SliderComponentShape.noThumb,
                                      overlayShape: SliderComponentShape.noOverlay
                                  ),
                                  child: Slider(
                                    min: 0.0,
                                    max: duration.inSeconds.toDouble(),
                                    value: position.inSeconds.toDouble(),
                                    onChanged: (value) {
                                      _seekAudio(Duration(seconds: value.toInt()));
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      StreamBuilder<Duration>(
                        stream: widget.audioNote.audioPlayer.positionStream,
                        builder: (context, snapshot) {
                          final position = snapshot.data ?? Duration.zero;
                          return Text('${_formatDuration(position)} / ${_formatDuration(widget.audioNote.duration)}', style: const TextStyle(fontSize: 10),);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              StreamBuilder<bool>(
                stream: widget.audioNote.userHasListenedStream,
                builder: (context, snapshot) {
                  final userHasListenedStream = snapshot.data ?? false;
                  return  !userHasListenedStream ? Container(
                    height: 10,
                    width: 10,
                    decoration: ShapeDecoration.fromBoxDecoration(
                      const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green
                      ),
                    ),
                  ) : Container();
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class AudioNote {
  final String filePath;
  AudioPlayer audioPlayer;
  Duration duration;
  Duration position;
  bool playing;
  bool userHasListened;
  late Stream<bool> userHasListenedStream;
  late StreamController<bool> _userHasListenedStreamController;

  AudioNote({
    required this.filePath,
    AudioPlayer? audioPlayer,
    this.duration = Duration.zero,
    this.position = Duration.zero,
    this.playing = false,
    this.userHasListened = false,
  }) : audioPlayer = audioPlayer ?? AudioPlayer() {
    _userHasListenedStreamController = StreamController<bool>.broadcast();
    userHasListenedStream = _userHasListenedStreamController.stream;
    _userHasListenedStreamController.add(userHasListened);

    init();
  }

  void init() {
    _userHasListenedStreamController = StreamController<bool>();

    audioPlayer.setFilePath(filePath);
    audioPlayer.durationStream.listen((d) {
      duration = d ?? Duration.zero;
    });
    audioPlayer.positionStream.listen((p) {
      position = p;
    });
    audioPlayer.playingStream.listen((p) {
      playing = p;
    });
  }

  void userHasPlayed() {
    userHasListened = true;
    _userHasListenedStreamController.add(userHasListened);
  }

  void dispose() {
    _userHasListenedStreamController.close();
    audioPlayer.dispose();
  }
}
