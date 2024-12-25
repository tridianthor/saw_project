import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:saw_project/model/Criteria.dart';
import 'package:saw_project/model/RatingComponent.dart';
import 'package:saw_project/model/SAW.dart';
import 'package:saw_project/presentation/component/CustomAppBar.dart';
import 'package:saw_project/presentation/component/CustomButton.dart';

class InputRating extends StatefulWidget {
  static const ID = "input-rating";

  const InputRating({super.key});

  @override
  State<InputRating> createState() => _InputRatingState();
}

class _InputRatingState extends State<InputRating> {
  /*TODO simplify this array*/
  List<List<List<TextEditingController>>> ratingController = [
    [[TextEditingController(), TextEditingController(),TextEditingController(),]],
    [[TextEditingController(), TextEditingController(),TextEditingController(),]],
    [[TextEditingController(), TextEditingController(),TextEditingController(),]],
    [[TextEditingController(), TextEditingController(),TextEditingController(),]]
  ];

  List<Criteria> criterias = [];

  @override
  void initState() {
    super.initState();

    try {
      if (SawInstance().saw.criterias.isEmpty) {
        throw Exception("no criteria availabe");
      }

      criterias = SawInstance().saw.criterias;
      log("criterias : $criterias");

    } on Exception catch (error, stackTrace) {
      log("$error\n$stackTrace");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomMaterialButton(
                caption: "Simpan dan Lanjut",
                function: () {
                  if (ratingController.length < 2) {
                    throw Exception("Must have more than 1 rating");
                  }

                  try {
                    for (var item in ratingController) {
                      if (item[0][0].text.isEmpty || item[0][1].text.isEmpty) {
                        throw Exception("Check input. Form can't be empty");
                      }

                      RatingComponent ratingComponent = RatingComponent(rating: item[0][0].text.trim(), value: double.parse(item[0][1].text.trim()));

                      if (!SawInstance().saw.ratingComponents.contains(ratingComponent)) {
                        SawInstance().saw.ratingComponents.add(ratingComponent);
                      }
                    }
                  } catch (exception, stackTrace) {
                    log("$exception\n$stackTrace");
                  }

                  log("saw criteria count : ${SawInstance().saw.criterias.length}");
                },
                width: 150,
              ),
            ],
          ),
        ),
        appBar: CustomAppBar().getAppBar(
          leadAction: () => Navigator.pop(context),
          caption: "Masukkan rating",
        ),
        body: Container(
          margin: const EdgeInsets.only(bottom: 90),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: criterias.length,
                  itemBuilder: (context, index) {
                    var criteria = criterias[index];
                    var ratingArray = ratingController[index];
                    return ExpansionTile(
                      title: Text(criteria.criteria!),
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: 120,
                            maxHeight: 300,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: ratingArray.length,
                            itemBuilder: (context, innerIndex) {
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                child: Row(
                                  children: [
                                    Flexible(
                                      child: Column(
                                        children: [
                                          TextField(
                                            controller: ratingArray[innerIndex][0],
                                            decoration: const InputDecoration(
                                              hintText: "Nilai Rating Kecocokan",
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          TextField(
                                            controller: ratingArray[innerIndex][1],
                                            decoration: const InputDecoration(
                                              hintText: "Nilai",
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          TextField(
                                            controller: ratingArray[innerIndex][2],
                                            decoration: InputDecoration(
                                              hintText: criteria.criteria!,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (innerIndex != 0)
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            ratingArray.removeAt(innerIndex);
                                          });
                                        },
                                        icon: const Icon(Icons.remove_circle),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        CustomOutlineButton(
                          caption: "Tambahkan form",
                          function: () {
                            setState(() {
                              ratingArray.add([TextEditingController(), TextEditingController(),TextEditingController()]);
                            });
                          },
                          width: 160,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
