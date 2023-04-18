import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mawu/Config/Repositories/firestore_repository.dart';
import 'package:mawu/Helpers/constants.dart';
import 'package:mawu/Models/movie_model.dart';
import 'package:mawu/Screens/register_screen.dart';
import 'package:mawu/Screens/video_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Helpers/colors.dart';
import '../Config/Repositories/user_repository.dart';
import '../Helpers/shared_pref.dart';
import '../Models/app_user_model.dart';
import 'discover_test.dart';
import 'entry_screen.dart';

class PlayScreen extends StatefulWidget {
  static const routeName = '/entry_screen';
  const PlayScreen({super.key});

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  AppUser? currentUser;

  @override
  void initState() {
    UserRepository().fetchCurrentUser().then((value) {
      setState(() {
        currentUser = value;
      });
    });
    SharedPreferences.getInstance().then((value) => sharedPreferences = value);
    super.initState();
  }

  late SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    var width = (MediaQuery.of(context).size.width - 70);
    var fullWidth = (MediaQuery.of(context).size.width);

    return Scaffold(
      backgroundColor: black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 25.0, left: 25, top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const SizedBox(
                        height: 40,
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    const Image(
                        height: 40,
                        image: AssetImage(
                          'assets/icons/mawu_logo.png',
                        )),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: light_background,
                          border: Border.all(color: orange),
                          image: DecorationImage(
                              image: NetworkImage(
                                currentUser == null
                                    ? ""
                                    : currentUser!.imageUrl,
                              ),
                              fit: BoxFit.cover)),
                    )
                  ],
                ),
              ),
              verticalSpacer(20),
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DiscoverTestScreen(
                                      currentUser: currentUser!,
                                    )));
                      },
                      child: Text("Friends Online",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: orange,
                              fontSize: 16,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
              verticalSpacer(10),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoScreen(
                                movie: Movie(
                                    title: "Now you see Me",
                                    url: getMovieName(MovieName.nowyouseeme),
                                    imageUrl: "imageUrl"),
                              )));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: light_background,
                    border:
                        Border.symmetric(horizontal: BorderSide(color: orange)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: fullWidth * 0.4, left: 20, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("A Close Shave", //"Latnem Pilot",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700)),
                            verticalSpacer(10),
                            Text(
                                "Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for preview layouts and visual.", //"Latnem Pilot",
                                style: TextStyle(
                                    color: white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ),
                      verticalSpacer(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EntryScreen()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Center(
                                child: Container(
                                  // width: 100,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: white,
                                  ),
                                  child: Text("INFO",
                                      style: TextStyle(
                                          color: orange,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: Center(
                                child: Container(
                                  // width: 100,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: orange,
                                  ),
                                  child: const Text("PLAY",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpacer(25),
                    ],
                  ),
                ),
              ),
              verticalSpacer(10),
              StreamBuilder(
                  stream: FirestoreRepository().getContinueWatchingStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        return const SizedBox.shrink();
                      } else {
                        return Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                children: [
                                  Text("Continue Watching",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: orange,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700)),
                                  horizontalSpacer(10),
                                  GestureDetector(
                                    onTap: () async {},
                                    child: Text("View All", //"Latnem Pilot",
                                        style: TextStyle(
                                            color: white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                ],
                              ),
                            ),
                            verticalSpacer(10),
                            SizedBox(
                              height: 200, // Replace with your desired height
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: FutureBuilder<List<Movie>?>(
                                    // List<String> idList = originalList.map((item) => item["id"]).toList();

                                    future: FirestoreRepository().getUserMovies(
                                        snapshot.data!.docs
                                            .map((item) => item["movieId"])
                                            .toList()),
                                    builder: (context, snap) {
                                      if (snap.hasData) {
                                        return ListView.builder(
                                          itemCount: snap.data!.length,
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          physics:
                                              const ClampingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final movie = snap.data![index];
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            VideoScreen(
                                                              movie: movie,
                                                              startAt: snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .get(
                                                                      "duration"),
                                                            )));
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15.0),
                                                child: SecondMovieContainer(
                                                  movieTitle: movie.title,
                                                  movieImageUrl: movie.imageUrl,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      } else if (snap.hasError) {
                                        return Text('Error: ${snap.error}');
                                      } else {
                                        return const HomeLoader();
                                      }
                                    }),
                              ),
                            ),
                          ],
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return const HomeLoader();
                    }
                  }),

              verticalSpacer(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Text("Trending Now",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: orange,
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                    horizontalSpacer(10),
                    GestureDetector(
                      onTap: () async {},
                      child: Text("View All", //"Latnem Pilot",
                          style: TextStyle(
                              color: white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
              verticalSpacer(10),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: SizedBox(
                  height: 200, // Replace with your desired height
                  width: double.infinity,
                  child: FutureBuilder<List<Movie>?>(
                      future: FirestoreRepository().getAllTrendingMovies(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final movie = snapshot.data![index];

                              var watchlist = SharedPreferenceHelper()
                                  .getFromLocalCache(
                                      sharedPreferences, movie.id!);
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VideoScreen(
                                                movie: movie,
                                              )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: MovieContainer(
                                    movieTitle: movie.title,
                                    movieImageUrl: movie.imageUrl,
                                    index: index,
                                    watchList: watchlist ?? 0,
                                    movieId: movie.id!,
                                    sharedPreferences: sharedPreferences,
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return const HomeLoader();
                        }
                      }),
                ),
              ),
              verticalSpacer(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Text("Recently Added",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: orange,
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                    horizontalSpacer(10),
                    GestureDetector(
                      onTap: () async {},
                      child: Text("View All", //"Latnem Pilot",
                          style: TextStyle(
                              color: white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
              verticalSpacer(10),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: SizedBox(
                  height: 200, // Replace with your desired height
                  width: double.infinity,
                  child: FutureBuilder<List<Movie>?>(
                      future: FirestoreRepository().getAllMovies(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final movie = snapshot.data![index];
                              // if (SharedPreferenceHelper().getFromLocalCache(
                              //         sharedPreferences, movie.id!) ==
                              //     null) {
                              //   SharedPreferenceHelper()
                              //       .saveToLocalCache(key: movie.id!, value: 0);
                              // }
                              var watchlist = SharedPreferenceHelper()
                                  .getFromLocalCache(
                                      sharedPreferences, movie.id!);
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VideoScreen(
                                                movie: movie,
                                              )));
                                },
                                child: Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: MovieContainer(
                                      movieTitle: movie.title,
                                      movieImageUrl: movie.imageUrl,
                                      index: index + 1,
                                      watchList: watchlist ?? 0,
                                      movieId: movie.id!,
                                      sharedPreferences: sharedPreferences,
                                    )),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return const HomeLoader();
                        }
                      }),
                ),
              ),
              verticalSpacer(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  children: [
                    Text("Recommended",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: orange,
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                    horizontalSpacer(10),
                    GestureDetector(
                      onTap: () async {},
                      child: Text("View All", //"Latnem Pilot",
                          style: TextStyle(
                              color: white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
              ),
              verticalSpacer(10),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: SizedBox(
                  height: 200, // Replace with your desired height
                  width: double.infinity,
                  child: FutureBuilder<List<Movie>?>(
                      future: FirestoreRepository().getAllRecommendedMovies(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final movie = snapshot.data![index];

                              var watchlist = SharedPreferenceHelper()
                                  .getFromLocalCache(
                                      sharedPreferences, movie.id!);

                              return GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => VideoScreen(
                                                movie: movie,
                                              )));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: MovieContainer(
                                    movieTitle: movie.title,
                                    movieImageUrl: movie.imageUrl,
                                    index: index,
                                    watchList: watchlist ?? 0,
                                    movieId: movie.id!,
                                    sharedPreferences: sharedPreferences,
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return const HomeLoader();
                        }
                      }),
                ),
              ),
              // verticalSpacer(20),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //   child: Row(
              //     children: [
              //       Text("Recently Added",
              //           textAlign: TextAlign.left,
              //           style: TextStyle(
              //               color: orange,
              //               fontSize: 20,
              //               fontWeight: FontWeight.w700)),
              //       horizontalSpacer(10),
              //       GestureDetector(
              //         onTap: () async {
              //           Navigator.pushReplacement(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) =>
              //                       const SecondPlayScreen()));
              //         },
              //         child: Text("View All", //"Latnem Pilot",
              //             style: TextStyle(
              //                 color: white,
              //                 fontSize: 18,
              //                 fontWeight: FontWeight.w700)),
              //       ),
              //     ],
              //   ),
              // ),
              // verticalSpacer(10),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20.0),
              //   child: SizedBox(
              //     height: 200, // Replace with your desired height
              //     width: double.infinity,
              //     child: FutureBuilder<List<Movie>?>(
              //         future: FirestoreRepository().getAllMovies(),
              //         builder: (context, snapshot) {
              //           if (snapshot.hasData) {
              //             return ListView.builder(
              //               itemCount: snapshot.data!.length,
              //               scrollDirection: Axis.horizontal,
              //               shrinkWrap: true,
              //               physics: const ClampingScrollPhysics(),
              //               itemBuilder: (context, index) {
              //                 final movie = snapshot.data![index];
              //                 return GestureDetector(
              //                   onTap: () {
              //                     Navigator.pushReplacement(
              //                         context,
              //                         MaterialPageRoute(
              //                             builder: (context) => VideoScreen(
              //                                   movieUrl: movie.url,
              //                                 )));
              //                   },
              //                   child: Padding(
              //                     padding: const EdgeInsets.only(right: 15.0),
              //                     child: MovieContainer(
              //                       movieTitle: movie.title,
              //                       movieImageUrl: movie.imageUrl,
              //                     ),
              //                   ),
              //                 );
              //               },
              //             );
              //           } else if (snapshot.hasError) {
              //             return Text('Error: ${snapshot.error}');
              //           } else {
              //             return const HomeLoader();
              //           }
              //         }),
              //   ),
              // ),
              // // verticalSpacer(20),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //   child: Row(
              //     children: [
              //       Text("Recommended",
              //           textAlign: TextAlign.left,
              //           style: TextStyle(
              //               color: orange,
              //               fontSize: 20,
              //               fontWeight: FontWeight.w700)),
              //       horizontalSpacer(10),
              //       GestureDetector(
              //         onTap: () async {
              //           Navigator.pushReplacement(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) =>
              //                       const SecondPlayScreen()));
              //         },
              //         child: Text("View All", //"Latnem Pilot",
              //             style: TextStyle(
              //                 color: white,
              //                 fontSize: 18,
              //                 fontWeight: FontWeight.w700)),
              //       ),
              //     ],
              //   ),
              // ),
              // verticalSpacer(10),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20.0),
              //   child: SizedBox(
              //     height: 200, // Replace with your desired height
              //     width: double.infinity,
              //     child: ListView(
              //       scrollDirection: Axis.horizontal,
              //       padding: const EdgeInsets.only(right: 10),
              //       shrinkWrap: true,
              //       physics: const ClampingScrollPhysics(),
              //       //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         GestureDetector(
              //           onTap: () {
              //             Navigator.pushReplacement(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => VideoScreen(
              //                           movieUrl: getMovieName(MovieName.nf),
              //                         )));
              //           },
              //           child: const MovieContainer(
              //             movieTitle: "Latnem",
              //             movieImageUrl: "assets/icons/movie6.jpg",
              //           ),
              //         ),
              //         horizontalSpacer(10),
              //         GestureDetector(
              //           onTap: () {
              //             Navigator.pushReplacement(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => VideoScreen(
              //                           movieUrl:
              //                               getMovieName(MovieName.bridgerton),
              //                         )));
              //           },
              //           child: const MovieContainer(
              //             movieTitle: "Shaver",
              //             movieImageUrl: "assets/icons/movie5.jpg",
              //           ),
              //         ),
              //         horizontalSpacer(10),
              //         GestureDetector(
              //           onTap: () {
              //             Navigator.pushReplacement(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => VideoScreen(
              //                           movieUrl: getMovieName(MovieName.nf),
              //                         )));
              //           },
              //           child: const MovieContainer(
              //             movieTitle: "Closer",
              //             movieImageUrl: "assets/icons/movie4.jpg",
              //           ),
              //         ),
              //         horizontalSpacer(10),
              //         GestureDetector(
              //           onTap: () {
              //             Navigator.pushReplacement(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => VideoScreen(
              //                           movieUrl: getMovieName(MovieName.nf),
              //                         )));
              //           },
              //           child: const MovieContainer(
              //             movieTitle: "Grudge",
              //             movieImageUrl: "assets/icons/movie3.png",
              //           ),
              //         ),
              //         horizontalSpacer(10),
              //         GestureDetector(
              //           onTap: () {
              //             Navigator.pushReplacement(
              //                 context,
              //                 MaterialPageRoute(
              //                     builder: (context) => VideoScreen(
              //                           movieUrl: getMovieName(MovieName.nf),
              //                         )));
              //           },
              //           child: const MovieContainer(
              //             movieTitle: "Latnem Pilot",
              //             movieImageUrl: "assets/icons/movie2.jpg",
              //           ),
              //         ),
              //         horizontalSpacer(20),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeLoader extends StatelessWidget {
  const HomeLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SpinKitCircle(
      color: orange,
      size: 40.0,
    ));
  }
}

class MovieContainer extends StatefulWidget {
  const MovieContainer({
    super.key,
    required this.movieImageUrl,
    required this.movieTitle,
    required this.index,
    required this.watchList,
    required this.movieId,
    required this.sharedPreferences,
  });
  final String movieTitle;
  final String movieImageUrl;
  final String movieId;
  final int index;
  final int watchList;
  final SharedPreferences sharedPreferences;

  @override
  State<MovieContainer> createState() => _MovieContainerState();
}

class _MovieContainerState extends State<MovieContainer> {
  late int watchlist;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    watchlist = widget.watchList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 145,
          width: 125,
          decoration: BoxDecoration(
              color: light_background,
              //border: Border.all(color: orange),
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  image: NetworkImage(widget.movieImageUrl
                      //'assets/icons/perks5.jpg',
                      ),
                  fit: BoxFit.cover)),
        ),
        verticalSpacer(10),
        SizedBox(
          width: 105,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.movieTitle, //"Latnem Pilot",
                  style: TextStyle(
                      color: white, fontSize: 18, fontWeight: FontWeight.w500)),
              GestureDetector(
                onTap: () async {
                  await SharedPreferenceHelper().saveToLocalCache(
                      key: widget.movieId, value: watchlist == 0 ? 1 : 0);
                  setState(() {
                    watchlist = SharedPreferenceHelper().getFromLocalCache(
                        widget.sharedPreferences, widget.movieId)!;
                  });
                },
                child: Icon(
                  (watchlist == 0) ? Icons.add : Icons.remove,
                  color: orange,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class SecondMovieContainer extends StatelessWidget {
  const SecondMovieContainer({
    super.key,
    required this.movieImageUrl,
    required this.movieTitle,
  });
  final String movieTitle;
  final String movieImageUrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 110,
          width: 225,
          decoration: BoxDecoration(
              color: light_background,
              //border: Border.all(color: orange),
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                  image: NetworkImage(movieImageUrl
                      //'assets/icons/perks5.jpg',
                      ),
                  fit: BoxFit.cover)),
        ),
        verticalSpacer(10),
        SizedBox(
          width: 205,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(movieTitle, //"Latnem Pilot",
                  style: TextStyle(
                      color: white, fontSize: 18, fontWeight: FontWeight.w500)),
              Icon(
                Icons.add,
                color: orange,
                size: 25,
              )
            ],
          ),
        ),
      ],
    );
  }
}
