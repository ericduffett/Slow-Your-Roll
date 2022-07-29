import 'package:flutter/material.dart';
import 'package:slow_your_roll/audio_content.dart';

import 'completed_indicators.dart';
import 'play_audio_screen.dart';

class MiniCard extends StatefulWidget {
  final AudioContent audioContent;
  const MiniCard({Key? key, required this.audioContent}) : super(key: key);

  @override
  State<MiniCard> createState() => _MiniCardState();
}

class _MiniCardState extends State<MiniCard> {
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
          width: double.infinity,
          height: (MediaQuery.of(context).size.width / 2) - 24,
          child: Stack(
            children: [
              Container(
                foregroundDecoration: const BoxDecoration(
                  color: Colors.black54,
                    backgroundBlendMode: BlendMode.darken,
                ),
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        image: AssetImage(widget.audioContent.imagePath)
                    )
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.audioContent.title,
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.center,),
                    Text('${widget.audioContent.minutes} minutes',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: Colors.white,
                      ),),
                  ],
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
