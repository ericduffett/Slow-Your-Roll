import 'package:flutter/material.dart';

import 'styles.dart';

class RiverpodLoading extends StatelessWidget {
  const RiverpodLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DarkBackgroundContainer(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.yellow.withAlpha(200),
          ),
        ));
  }
}

class RiverpodError extends StatelessWidget {
  final String screenName;
  const RiverpodError({Key? key, required this.screenName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DarkBackgroundContainer(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Text('Something went wrong loading $screenName...\nPlease contact the support team.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline2,),
      ),
    );
  }
}

