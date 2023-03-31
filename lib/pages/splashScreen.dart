import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/app_bar.dart';
import '../helpers/AnimalHelper.dart';
import '../helpers/image_api_helper.dart';
import '../modals/Animals.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  TextStyle titleStyle2 = GoogleFonts.ubuntu(
      fontSize: 20,
      color: Colors.white.withOpacity(0.9),
      fontWeight: FontWeight.w600,
      letterSpacing: 1);

  int index = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: IndexedStack(
        index: index,
        children: [
          //Intro screen 1
          FutureBuilder(
            future: ImageAPIHelper.imageAPIHelper
                .getImage(name: 'background,wild animal'),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error:${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                Uint8List data = snapshot.data as Uint8List;

                return Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                        const Color(0xffC19E82).withOpacity(0.6),
                        BlendMode.darken,
                      ),
                      image: MemoryImage(data),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 38),
                      appBar(),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 26, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ready to\nwatch?",
                              style: GoogleFonts.ubuntu(
                                fontSize: 50,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              "Aplanet is a global leader in real life entertainment, serving a passionate audience of superfans around the world with content that inspires, inform and entertains.",
                              style: GoogleFonts.ubuntu(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 26),
                          Text(
                            "Start Enjoying",
                            style: titleStyle2,
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              setState(() {
                                index++;
                              });
                            },
                            child: Container(
                              height: 70,
                              width: 75,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(65),
                                  )),
                              alignment: const Alignment(0.2, 0.15),
                              child: const Icon(
                                Icons.arrow_forward_outlined,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          //Intro screen 2
          Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              color: Color(0xffC19E82),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 38),
                appBar(),
                const SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.only(left: 26.0),
                  child: Text(
                    "Choose a plan",
                    style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: DBHelper.dbHelper.fetchAllSubscriptionPlanRecords(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("Error:${snapshot.error}"),
                        );
                      } else if (snapshot.hasData) {
                        List<SubscriptionPlanDB>? data = snapshot.data;
                        return ListView.builder(
                          itemCount: data?.length,
                          itemBuilder: (context, i) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 26),
                              height: 135,
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(4),
                                image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.2),
                                    BlendMode.hardLight,
                                  ),
                                  image: MemoryImage(data![i].image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(width: 18),
                                  Text(
                                    data[i].time,
                                    style: GoogleFonts.ubuntu(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    data[i].price,
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 18),
                                ],
                              ),
                            );
                          },
                        );
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(width: 26),
                    Text(
                      "Last step to enjoy",
                      style: titleStyle2,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/');
                      },
                      child: Container(
                        height: 70,
                        width: 75,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(65),
                            )),
                        alignment: const Alignment(0.2, 0.15),
                        child: const Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
