// import 'package:flutter/material.dart';
// import 'package:mawu/Helpers/constants.dart';
// import 'package:mawu/Screens/register_screen.dart';
// import 'package:mawu/Screens/video_screen.dart';

// import '../../Helpers/colors.dart';
// import '../Config/Repositories/user_repository.dart';
// import '../Models/app_user_model.dart';
// import 'discover_test.dart';
// import 'entry_screen.dart';
// import 'play_screen.dart';

// class SecondPlayScreen extends StatefulWidget {
//   static const routeName = '/entry_screen';
//   const SecondPlayScreen({super.key});

//   @override
//   _SecondPlayScreenState createState() => _SecondPlayScreenState();
// }

// class _SecondPlayScreenState extends State<SecondPlayScreen> {
//   AppUser? currentUser;

//   @override
//   void initState() {
//     UserRepository().fetchCurrentUser().then((value) {
//       setState(() {
//         currentUser = value;
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var width = (MediaQuery.of(context).size.width - 70);
//     var fullWidth = (MediaQuery.of(context).size.width);
//     return Scaffold(
//       backgroundColor: black,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.center,
//             // crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.only(right: 25.0, left: 25, top: 15),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const PlayScreen()));
//                       },
//                       child: SizedBox(
//                         height: 40,
//                         child: Icon(
//                           Icons.arrow_back,
//                           color: orange,
//                         ),
//                       ),
//                     ),
//                     const Image(
//                         height: 40,
//                         image: AssetImage(
//                           'assets/icons/mawu_logo.png',
//                         )),
//                     Container(
//                       height: 40,
//                       width: 40,
//                       decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: light_background,
//                           border: Border.all(color: orange),
//                           image: DecorationImage(
//                               image: NetworkImage(
//                                 currentUser == null
//                                     ? ""
//                                     : currentUser!.imageUrl,
//                               ),
//                               fit: BoxFit.cover)),
//                     )
//                   ],
//                 ),
//               ),
//               verticalSpacer(20),
//               Padding(
//                 padding: const EdgeInsets.only(right: 25),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => DiscoverTestScreen(
//                                       currentUser: currentUser!,
//                                     )));
//                       },
//                       child: Text("Friends Online",
//                           textAlign: TextAlign.right,
//                           style: TextStyle(
//                               decoration: TextDecoration.underline,
//                               color: orange,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w700)),
//                     ),
//                   ],
//                 ),
//               ),
//               verticalSpacer(10),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => VideoScreen(
//                                 movieUrl: getMovieName(MovieName.nowyouseeme),
//                               )));
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: light_background,
//                     border:
//                         Border.symmetric(horizontal: BorderSide(color: orange)),
//                   ),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.only(
//                             right: fullWidth * 0.4, left: 20, top: 20),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("A Close Shave", //"Latnem Pilot",
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                     color: white,
//                                     fontSize: 22,
//                                     fontWeight: FontWeight.w700)),
//                             verticalSpacer(10),
//                             Text(
//                                 "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for preview layouts and visual.", //"Latnem Pilot",
//                                 style: TextStyle(
//                                     color: white,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400)),
//                           ],
//                         ),
//                       ),
//                       verticalSpacer(20),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           GestureDetector(
//                             onTap: () async {
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const EntryScreen()));
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 10),
//                               child: Center(
//                                 child: Container(
//                                   // width: 100,
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 20, vertical: 5),
//                                   decoration: BoxDecoration(
//                                     color: white,
//                                   ),
//                                   child: Text("INFO",
//                                       style: TextStyle(
//                                           color: orange,
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w700)),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () async {
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const RegisterScreen()));
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 30),
//                               child: Center(
//                                 child: Container(
//                                   // width: 100,
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 20, vertical: 5),
//                                   decoration: BoxDecoration(
//                                     color: orange,
//                                   ),
//                                   child: const Text("PLAY",
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.w700)),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       verticalSpacer(25),
//                     ],
//                   ),
//                 ),
//               ),
//               verticalSpacer(20),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                 child: Row(
//                   children: [
//                     Text("Continue Watching",
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                             color: orange,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w700)),
//                     horizontalSpacer(10),
//                     Text("View All", //"Latnem Pilot",
//                         style: TextStyle(
//                             color: white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700)),
//                   ],
//                 ),
//               ),
//               verticalSpacer(10),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20.0, top: 10),
//                 child: SizedBox(
//                   height: 200, // Replace with your desired height
//                   width: double.infinity,
//                   child: ListView(
//                     scrollDirection: Axis.horizontal,
//                     shrinkWrap: true,
//                     physics: const ClampingScrollPhysics(),
//                     //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => VideoScreen(
//                                         movieUrl: getMovieName(MovieName.nf),
//                                       )));
//                         },
//                         child: const SecondMovieContainer(
//                           movieTitle: "Latnem",
//                           movieImageUrl: "assets/icons/movie.jpeg",
//                         ),
//                       ),
//                       horizontalSpacer(10),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => VideoScreen(
//                                         movieUrl:
//                                             getMovieName(MovieName.bridgerton),
//                                       )));
//                         },
//                         child: const SecondMovieContainer(
//                           movieTitle: "Shaver",
//                           movieImageUrl: "assets/icons/movie1.jpg",
//                         ),
//                       ),
//                       horizontalSpacer(10),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => VideoScreen(
//                                         movieUrl: getMovieName(MovieName.nf),
//                                       )));
//                         },
//                         child: const SecondMovieContainer(
//                           movieTitle: "Closer",
//                           movieImageUrl: "assets/icons/movie2.jpg",
//                         ),
//                       ),
//                       horizontalSpacer(10),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => VideoScreen(
//                                         movieUrl: getMovieName(MovieName.nf),
//                                       )));
//                         },
//                         child: const SecondMovieContainer(
//                           movieTitle: "Grudge",
//                           movieImageUrl: "assets/icons/movie3.png",
//                         ),
//                       ),
//                       horizontalSpacer(10),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => VideoScreen(
//                                         movieUrl: getMovieName(MovieName.nf),
//                                       )));
//                         },
//                         child: const SecondMovieContainer(
//                           movieTitle: "Latnem Pilot",
//                           movieImageUrl: "assets/icons/movie4.jpg",
//                         ),
//                       ),
//                       horizontalSpacer(20),
//                     ],
//                   ),
//                 ),
//               ),
//               verticalSpacer(10),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                 child: Row(
//                   children: [
//                     Text("Trending Now",
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                             color: orange,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w700)),
//                     horizontalSpacer(10),
//                     Text("View All", //"Latnem Pilot",
//                         style: TextStyle(
//                             color: white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.w700)),
//                   ],
//                 ),
//               ),
//               verticalSpacer(10),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20.0, top: 10),
//                 child: SizedBox(
//                   height: 200, // Replace with your desired height
//                   width: double.infinity,
//                   child: ListView(
//                     scrollDirection: Axis.horizontal,
//                     shrinkWrap: true,
//                     physics: const ClampingScrollPhysics(),
//                     //mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => VideoScreen(
//                                         movieUrl: getMovieName(MovieName.nf),
//                                       )));
//                         },
//                         child: const MovieContainer(
//                           movieTitle: "Latnem",
//                           movieImageUrl: "assets/icons/movie6.jpg",
//                           index: 1,
//                         ),
//                       ),
//                       horizontalSpacer(10),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => VideoScreen(
//                                         movieUrl:
//                                             getMovieName(MovieName.bridgerton),
//                                       )));
//                         },
//                         child: const MovieContainer(
//                           movieTitle: "Shaver",
//                           movieImageUrl: "assets/icons/movie5.jpg",
//                           index: 1,
//                         ),
//                       ),
//                       horizontalSpacer(10),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => VideoScreen(
//                                         movieUrl: getMovieName(MovieName.nf),
//                                       )));
//                         },
//                         child: const MovieContainer(
//                           movieTitle: "Closer",
//                           movieImageUrl: "assets/icons/movie4.jpg",
//                           index: 1,
//                         ),
//                       ),
//                       horizontalSpacer(10),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => VideoScreen(
//                                         movieUrl: getMovieName(MovieName.nf),
//                                       )));
//                         },
//                         child: const MovieContainer(
//                           movieTitle: "Grudge",
//                           movieImageUrl: "assets/icons/movie3.png",
//                           index: 1,
//                         ),
//                       ),
//                       horizontalSpacer(10),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => VideoScreen(
//                                         movieUrl: getMovieName(MovieName.nf),
//                                       )));
//                         },
//                         child: const MovieContainer(
//                           movieTitle: "Latnem Pilot",
//                           movieImageUrl: "assets/icons/movie2.jpg",
//                           index: 1,
//                         ),
//                       ),
//                       horizontalSpacer(20),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
