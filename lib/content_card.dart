import 'package:flutter/material.dart';
import 'package:slow_your_roll/play_audio_screen.dart';
import 'audio_content.dart';
import 'completed_indicators.dart';


class ContentCard extends StatefulWidget {

  final AudioContent audioContent;

  const ContentCard({Key? key, required this.audioContent}) : super(key: key);

  @override
  State<ContentCard> createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => PlayAudioScreen(audioContent: widget.audioContent))),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        clipBehavior: Clip.antiAlias,
        shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.white24,
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: SizedBox(
          height: 150,
          width: double.infinity,
          child: Stack(
            children: [
              Container(
                foregroundDecoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.black87,
                        Colors.black54,
                        Colors.black12
                      ],
                      stops: [
                        0.3,
                        0.6,
                        1.0
                      ],
                    )
                ),
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        alignment: Alignment.topRight,
                        image: AssetImage(widget.audioContent.imagePath)
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.audioContent.title,
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.left,),
                    Text(widget.audioContent.description,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.white,
                      ),),
                  ],
                ),
              ),
              // const Padding(
              //   padding: EdgeInsets.only(right: 8.0),
              //   child: Align(
              //       alignment: Alignment.centerRight,
              //       child: Icon(Icons.play_circle_outline_rounded,
              //         color: Colors.white,
              //         size: 30.0,
              //       )
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('${widget.audioContent.minutes} Minutes',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w900,
                      )),
                ),
              ),
              widget.audioContent.completed ? const CheckFilled() : const CheckEmpty(),
            ],
          ),
        ),
      ),
    );
  }
}


