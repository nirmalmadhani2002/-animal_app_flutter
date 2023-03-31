import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/app_bar.dart';
import '../components/category_box.dart';
import '../global.dart';

import '../helpers/AnimalHelper.dart';
import '../helpers/image_api_helper.dart';
import '../modals/Animals.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextStyle textStyle = GoogleFonts.ubuntu(
    fontSize: 22,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    letterSpacing: 1,
  );

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
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
                  height: height * 0.38,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.teal,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 38),
                      appBar(),
                      const Spacer(),
                      Text(
                        "Welcome to\nNew Aplanet",
                        style: GoogleFonts.ubuntu(
                          fontSize: 48,
                          color: Colors.white.withOpacity(0.9),
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: width,
              height: height * 0.63,
              padding: const EdgeInsets.only(left: 26, right: 26),
              decoration: BoxDecoration(
                  color: const Color(0xffC19E82),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, -0.2),
                      spreadRadius: 2,
                      blurRadius: 16,
                    ),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 18),
                  Text(
                    "Related for you",
                    style: textStyle,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: width,
                    height: height * 0.3,
                    child: FutureBuilder(
                      future: DBHelper.dbHelper.fetchAllAnimalRecords(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text("Error:${snapshot.error}"),
                          );
                        } else if (snapshot.hasData) {
                          List<AnimalDB> data = snapshot.data as List<AnimalDB>;

                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, i) {
                              return Row(
                                children: [
                                  Container(
                                    width: 182,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: height * 0.17,
                                          width: 180,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              image: DecorationImage(
                                                image: MemoryImage(
                                                  data[i].image,
                                                  //  scale: 10,
                                                ),
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        const Spacer(),
                                        Text(
                                          data[i].name.toUpperCase(),
                                          style: GoogleFonts.actor(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          data[i]
                                              .desc, // "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eligendi non quis exer ?",
                                          style: GoogleFonts.ubuntu(
                                            fontSize: 14,
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            wordSpacing: 1,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        const Spacer(flex: 3),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                ],
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
                  Text(
                    "Quick categories",
                    style: textStyle,
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Global.animalDataTableName = "bear";
                          setState(() {});
                        },
                        child: categoryBox(
                            height: height, width: width, image: "bear"),
                      ),
                      GestureDetector(
                        onTap: () {
                          Global.animalDataTableName = "lion";

                          setState(() {});
                        },
                        child: categoryBox(
                            height: height, width: width, image: "lion"),
                      ),
                      GestureDetector(
                        onTap: () {
                          Global.animalDataTableName = "snake";
                          setState(() {});
                        },
                        child: categoryBox(
                            height: height, width: width, image: "snake"),
                      ),
                      GestureDetector(
                        onTap: () {
                          Global.animalDataTableName = "pets";
                          setState(() {});
                        },
                        child: categoryBox(
                            height: height, width: width, image: "pets"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
