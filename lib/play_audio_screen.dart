import 'dart:async';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slow_your_roll/audio_content.dart';
import 'package:slow_your_roll/riverpod_widgets.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'slow_your_roll_user.dart';

class PlayAudioScreen extends ConsumerStatefulWidget {
  final AudioContent audioContent;
  const PlayAudioScreen({required this.audioContent,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _PlayAudioScreenConsumerState();
}

class _PlayAudioScreenConsumerState extends ConsumerState<PlayAudioScreen> {
  IconData audioPlayerIcon = Icons.play_arrow_rounded;
  final AudioPlayer player = AudioPlayer();
  Duration currentTime = Duration();
  Duration totalTime = Duration();
  String totalTimeString = '0:00';
  String currentTimeString = '0:00';
  StreamSubscription? durationListener;
  StreamSubscription? positionListener;
  StreamSubscription? stateListener;
  StreamSubscription? completionListener;
  bool doneLoading = false;
  SlowYourRollUser currentUser = SlowYourRollUser();

  audioPlayerButtonTapped() {
    setState(() {
      if (audioPlayerIcon == Icons.pause) {
        player.pause();
      } else {
        player.resume();
      }
    });
  }

  setUpAudioPlayer() async {
    await player.play(UrlSource(widget.audioContent.audioPath));
    //player.setReleaseMode(ReleaseMode.stop);
  }

  String formatDuration(int totalSeconds) {
    final duration = Duration(seconds: totalSeconds);
    final minutes = duration.inMinutes;
    final seconds = totalSeconds % 60;

    final minutesString = '$minutes'.padLeft(2, '0');
    final secondsString = '$seconds'.padLeft(2, '0');
    return '$minutesString:$secondsString';
  }


  @override
  void initState() {
    super.initState();

    setUpAudioPlayer();

    stateListener = player.onPlayerStateChanged.listen((PlayerState s) {
      print('Current player state: $s');
      setState(() {
        if (s == PlayerState.playing) {
          audioPlayerIcon = Icons.pause;
        } else if (s == PlayerState.paused) {
          audioPlayerIcon = Icons.play_arrow_rounded;
        }
      });
    });


    durationListener = player.onDurationChanged.listen((Duration d) {
      print(d);
      setState(() {
        totalTime = d;
        totalTimeString = formatDuration(d.inSeconds);
      });
    });

    positionListener = player.onPositionChanged.listen((Duration  p) {
      setState((){
        currentTime = p;
        currentTimeString = formatDuration(p.inSeconds);
      });
    });

    completionListener =  player.onPlayerComplete.listen((event) async {
      positionListener?.cancel();

      //TODO: Disable play button and show pop up.
      //TODO: Save to firebase.

      await currentUser.saveUserActivity(widget.audioContent.keyName);
      if (widget.audioContent.title == 'Meditation') {
        await currentUser.addToMeditationStreak();
      } else if (widget.audioContent.title == 'Affirmation') {
        await currentUser.recordAffirmation();
      }


      showDialog(context: context, barrierDismissible: false, builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24.0),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text('Audio Complete!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:Color(0xFF2c3e50),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                // Text('Your Stats',
                //   style: Theme.of(context).textTheme.headline3,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Meditation Streak',
                            style: GoogleFonts.redHatDisplay().copyWith(fontSize: 14.0, color: Color(0xFF2c3e50),),),
                          Text('${currentUser.streak}',
                            style: Theme.of(context).textTheme.headline2?.copyWith(
                                fontSize: 20.0,
                              color: Color(0xFF2c3e50),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Text('Past Seven Days',
                              style: GoogleFonts.redHatDisplay().copyWith(fontSize: 14.0, color: Color(0xFF2c3e50),)),
                          Text(currentUser.pastSevenDayActivity,
                            style: Theme.of(context).textTheme.headline2?.copyWith(
                                fontSize: 20.0,
                              color: Color(0xFF2c3e50),
                            ),),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Meditation Minutes',
                              style: GoogleFonts.redHatDisplay().copyWith(fontSize: 14.0, color: Color(0xFF2c3e50),)),
                          Text('${currentUser.totalMinutes}',
                            style: Theme.of(context).textTheme.headline2?.copyWith(
                                fontSize: 20.0,
                              color: Color(0xFF2c3e50),
                            ),
                          ),
                          const SizedBox(
                            height: 16.0,
                          ),
                          Text('Past Thirty Days',
                              style: GoogleFonts.redHatDisplay().copyWith(fontSize: 14.0, color: Color(0xFF2c3e50),)),
                          Text(currentUser.pastThirtyDaysActivity,
                            style: Theme.of(context).textTheme.headline2?.copyWith(
                                fontSize: 20.0,
                                color: Color(0xFF2c3e50)
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    child: const Text('OK',
                      style: TextStyle(
                          color: Color(0xFF2c3e50),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    stateListener?.cancel();
    durationListener?.cancel();
    positionListener?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final userStream = ref.watch(userSnapshotProvider);
    return userStream.when(data: (value) {
      final uid = value!.id;
      currentUser = SlowYourRollUser.fromSnapshot(uid, value);
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              player.stop();
              player.dispose();
              Navigator.of(context).pop();
            },
          ),
        ),
        body: StreamBuilder(
          stream: player.onDurationChanged,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.darken),
                        fit: BoxFit.cover,
                        image: AssetImage(widget.audioContent.imagePath,)
                    )
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.audioContent.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline2,),
                      Text(widget.audioContent.description,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,),
                      const SizedBox(
                        height: 16.0,
                      ),
                      CircularPercentIndicator(
                        backgroundColor: Colors.white54,
                        radius: 100.0,
                        percent: (currentTime.inSeconds / totalTime.inSeconds),
                        progressColor: Colors.yellow.withAlpha(200),
                        animateFromLastPercent: true,
                        // animation: false,
                        // animationDuration: 100,
                        circularStrokeCap: CircularStrokeCap.round,
                        center: Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white10,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            iconSize: 100.0,
                            icon: Icon(audioPlayerIcon,
                              color: Colors.white54,
                            ),
                            onPressed: () => audioPlayerButtonTapped(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Text("$currentTimeString / $totalTimeString",
                        style: Theme.of(context).textTheme.headline2,)
                    ],
                  ),
                ),
              );
            }
            else if (snapshot.connectionState == ConnectionState.waiting) {
              return const RiverpodLoading();
            } else if (snapshot.hasError) {
              return const RiverpodError(screenName: 'Audio Player Screen');
            } else {
              return const RiverpodError(screenName: 'Something went way wrong');
            }

          },
        ),
      );
    },
        error: (_, __) => const RiverpodError(screenName: 'Audio with User Stream'),
        loading: () => const RiverpodLoading());

  }
}
/*
class PlayAudioScreen extends StatefulWidget {
  final AudioContent audioContent;
  const PlayAudioScreen({Key? key, required this.audioContent}) : super(key: key);

  @override
  State<PlayAudioScreen> createState() => _PlayAudioScreenState();
}

class _PlayAudioScreenState extends State<PlayAudioScreen> {

  IconData audioPlayerIcon = Icons.play_arrow_rounded;
  final AudioPlayer player = AudioPlayer();
  Duration currentTime = Duration();
  Duration totalTime = Duration();
  String totalTimeString = '0:00';
  String currentTimeString = '0:00';
  StreamSubscription? durationListener;
  StreamSubscription? positionListener;
  StreamSubscription? stateListener;
  StreamSubscription? completionListener;
  bool doneLoading = false;

  audioPlayerButtonTapped() {
    setState(() {
      if (audioPlayerIcon == Icons.pause) {
        player.pause();
      } else {
        player.resume();
      }
    });
  }

  setUpAudioPlayer() async {
    await player.play(UrlSource(widget.audioContent.audioPath));
    //player.setReleaseMode(ReleaseMode.stop);
  }

  String formatDuration(int totalSeconds) {
    final duration = Duration(seconds: totalSeconds);
    final minutes = duration.inMinutes;
    final seconds = totalSeconds % 60;

    final minutesString = '$minutes'.padLeft(2, '0');
    final secondsString = '$seconds'.padLeft(2, '0');
    return '$minutesString:$secondsString';
  }

  onAudioComplete () {
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();

    setUpAudioPlayer();

    stateListener = player.onPlayerStateChanged.listen((PlayerState s) {
      print('Current player state: $s');
      setState(() {
        if (s == PlayerState.playing) {
          audioPlayerIcon = Icons.pause;
        } else if (s == PlayerState.paused) {
          audioPlayerIcon = Icons.play_arrow_rounded;
        }
      });
    });


    durationListener = player.onDurationChanged.listen((Duration d) {
      print(d);
      setState(() {
        totalTime = d;
        totalTimeString = formatDuration(d.inSeconds);
      });
    });

    positionListener = player.onPositionChanged.listen((Duration  p) {
      setState((){
        currentTime = p;
        currentTimeString = formatDuration(p.inSeconds);
      });
    });

    completionListener =  player.onPlayerComplete.listen((event) {
      positionListener?.cancel();

      //TODO: Disable play button and show pop up.
      //TODO: Save to firebase.

      showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: const Text('Audio Complete!'),
          content: Text(currentUser.pastSevenDayActivity,
            style: Theme.of(context).textTheme.headline2,),
          actions: [
            TextButton(
              child: const Text('OK',
                style: TextStyle(
                    color: Color(0xFF2c3e50),
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
    });
  }

  @override
  void dispose() {
    stateListener?.cancel();
    durationListener?.cancel();
    positionListener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: StreamBuilder(
        stream: player.onDurationChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.darken),
                      fit: BoxFit.cover,
                      image: AssetImage(widget.audioContent.imagePath,)
                  )
              ),
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.audioContent.title,
                    style: Theme.of(context).textTheme.headline2,),
                  Text(widget.audioContent.description,
                    style: Theme.of(context).textTheme.headline5,),
                  const SizedBox(
                    height: 16.0,
                  ),
                  CircularPercentIndicator(
                    backgroundColor: Colors.white54,
                    radius: 100.0,
                    percent: (currentTime.inSeconds / totalTime.inSeconds),
                    progressColor: Colors.yellow.withAlpha(200),
                    animateFromLastPercent: true,
                    // animation: false,
                    // animationDuration: 100,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white10,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        iconSize: 100.0,
                        icon: Icon(audioPlayerIcon,
                          color: Colors.white54,
                        ),
                        onPressed: () => audioPlayerButtonTapped(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Text("$currentTimeString / $totalTimeString",
                    style: Theme.of(context).textTheme.headline2,)
                ],
              ),
            );
          }
          else if (snapshot.connectionState == ConnectionState.waiting) {
            return const RiverpodLoading();
          } else if (snapshot.hasError) {
            return const RiverpodError(screenName: 'Audio Player Screen');
          } else {
            return const RiverpodError(screenName: 'Something went way wrong');
          }

        },
      ),
    );
  }
}
*/