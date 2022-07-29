//
// Card(
// margin: const EdgeInsets.symmetric(vertical: 8.0),
// elevation: 3.0,
// clipBehavior: Clip.antiAlias,
// shape: const RoundedRectangleBorder(
// side: BorderSide(
// color: Colors.black38,
// width: 2.0,
// ),
// borderRadius: BorderRadius.all(Radius.circular(10.0))),
// child: Container(
// padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
// decoration: const BoxDecoration(
// gradient: LinearGradient(
// // stops: [
// //   0.8,
// //   1.0,
// //   ],
// begin: Alignment.centerLeft,
// end: Alignment.centerRight,
// //  transform: GradientRotation(0.8),
// colors: [
// // Color(0xFF2a2a72), Dark Blue
// // Color(0xFF009ffd), Ocean Blue
// //Color(0xFFffffff), //White
// //Color(0xFFe4e6eb), //Offwhite
// Color(0xFF0c67a8),
// Color(0xFF049edb)
// ]
// )
// ),
// height: 150,
// width: double.infinity,
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Text('Introduction',
// style: Theme.of(context).textTheme.headline2,
// textAlign: TextAlign.center,),
// Text('Learn more about Slow Your Roll',
// style: Theme.of(context).textTheme.headline5,),
// const SizedBox(
// height: 12.0,
// ),
// Row(
// mainAxisSize: MainAxisSize.min,
// children: const [
// Text('PLAY LESSON',
// style: TextStyle(
// fontSize: 14.0,
// fontWeight: FontWeight.bold,
// //color: Color(0xFF2c3e50),
// color: Colors.white,
// ),),
// // SizedBox(
// //   width: 8.0,
// // ),
// // Icon(Icons.play_circle_outline,
// //   size: 16.0,)
// ],
// )
// ],
// )),
// ),
// Card(
// margin: EdgeInsets.zero,
// clipBehavior: Clip.antiAlias,
// shape: const RoundedRectangleBorder(
// side: BorderSide(
// color: Colors.white10,
// width: 3.0,
// ),
// borderRadius: BorderRadius.all(Radius.circular(10.0))),
// child: SizedBox(
// // color: Theme.of(context).canvasColor,
// height: 150,
// width: double.infinity,
// child: ClipRRect(
// borderRadius: BorderRadius.circular(10.0),
// child: Material(
// elevation: 4.0,
// child: Ink.image(
// image: AssetImage('images/tan-kuen-yuen-cXXuAUCTihQ-unsplash.jpeg'),
// colorFilter:
// ColorFilter.mode(Colors.black38, BlendMode.darken),
// fit: BoxFit.cover,
// width: 120,
// child: InkWell(
// child: Center(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Text('Introduction',
// style: Theme.of(context).textTheme.headline2,
// textAlign: TextAlign.center,),
// Text('Learn more about Slow Your Roll',
// style: Theme.of(context).textTheme.headline5!.copyWith(
// color: Colors.white,
// ),),
// const SizedBox(
// height: 12.0,
// ),
// const Icon(Icons.play_circle_outline,
// color: Colors.white,
// size: 36.0,),
// // const Text('PLAY LESSON',
// //   style: TextStyle(
// //     fontSize: 14.0,
// //     fontWeight: FontWeight.bold,
// //     color: Colors.white,
// //   ),),
// ],
// ),
// ),
// onTap: () => print("tap"),
// ),
// ),
// ),
// ),
// ),
// ),
// Card(
// margin: const EdgeInsets.symmetric(vertical: 6.0),
// clipBehavior: Clip.antiAlias,
// shape: const RoundedRectangleBorder(
// side: BorderSide(
// color: Colors.white10,
// width: 3.0,
// ),
// borderRadius: BorderRadius.all(Radius.circular(10.0))),
// child: SizedBox(
// height: 150,
// width: double.infinity,
// child: Stack(
// children: [
// Container(
// foregroundDecoration: const BoxDecoration(
// gradient: LinearGradient(
// begin: Alignment.centerLeft,
// end: Alignment.centerRight,
// colors: [
// Colors.black87,
// Colors.black54,
// Colors.black12
// ],
// stops: [
// 0.3,
// 0.6,
// 1.0
// ],
// )
// ),
// height: double.infinity,
// width: double.infinity,
// decoration: const BoxDecoration(
// image: DecorationImage(
// fit: BoxFit.cover,
// alignment: Alignment.center,
// image: AssetImage('images/tan-kuen-yuen-cXXuAUCTihQ-unsplash.jpeg')
// )
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Text('Introduction',
// style: Theme.of(context).textTheme.headline2,
// textAlign: TextAlign.left,),
// Text('Learn more about Slow Your Roll',
// style: Theme.of(context).textTheme.headline5!.copyWith(
// color: Colors.white,
// ),),
// ],
// ),
// ),
// const Padding(
// padding: EdgeInsets.only(right: 16.0),
// child: Align(
// alignment: Alignment.centerRight,
// child: Icon(Icons.play_circle_outline_rounded,
// color: Colors.white,
// size: 30.0,
// )
// ),
// ),
// ],
// ),
// ),
// ),
// Card(
// margin: const EdgeInsets.symmetric(vertical: 6.0),
// clipBehavior: Clip.antiAlias,
// shape: const RoundedRectangleBorder(
// side: BorderSide(
// color: Colors.white10,
// width: 3.0,
// ),
// borderRadius: BorderRadius.all(Radius.circular(10.0))),
// child: SizedBox(
// height: 150,
// width: double.infinity,
// child: Stack(
// children: [
// Container(
// foregroundDecoration: const BoxDecoration(
// gradient: LinearGradient(
// begin: Alignment.centerLeft,
// end: Alignment.centerRight,
// colors: [
// Colors.black87,
// Colors.black54,
// Colors.black12
// ],
// stops: [
// 0.3,
// 0.6,
// 1.0
// ],
// )
// ),
// height: double.infinity,
// width: double.infinity,
// decoration: const BoxDecoration(
// image: DecorationImage(
// fit: BoxFit.cover,
// alignment: Alignment.topRight,
// image: AssetImage('images/tim-mossholder-MiZVYi5m_cY-unsplash copy.jpg')
// )
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// mainAxisAlignment: MainAxisAlignment.center,
// children: [
// Text('Mental Performance',
// style: Theme.of(context).textTheme.headline2,
// textAlign: TextAlign.left,),
// Text('and why it\'s important',
// style: Theme.of(context).textTheme.headline5!.copyWith(
// color: Colors.white,
// ),),
// ],
// ),
// ),
// const Padding(
// padding: EdgeInsets.only(right: 8.0),
// child: Align(
// alignment: Alignment.centerRight,
// child: Icon(Icons.double_arrow,
// color: Colors.white,
// size: 24.0,
// )
// ),
// ),
// Padding(
// padding: const EdgeInsets.only(bottom: 8.0),
// child: Align(
// alignment: Alignment.bottomCenter,
// child: Text('5 Minutes',
// textAlign: TextAlign.center,
// style: Theme.of(context).textTheme.headline2!.copyWith(
// fontSize: 12.0,
// fontWeight: FontWeight.w900,
// )),
// ),
// ),
// Padding(
// padding: const EdgeInsets.only(top: 8.0, right: 8.0),
// child: Align(
// alignment: Alignment.topRight,
// child: Container(
// height: 30,
// width: 30,
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(30),
// border: Border.all(width: 3, color: Colors.white54)),
// ),
// ),
// ),
// ],
// ),
// ),
// ),