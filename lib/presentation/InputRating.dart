import 'dart:developer';

import 'package:flutter/material.dart';
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
  List<List<TextEditingController>> ratingController = [[TextEditingController(), TextEditingController()]];

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
              CustomOutlineButton(
                caption: "Tambahkan form",
                function: () {
                  setState(() {
                    ratingController.add([TextEditingController(), TextEditingController()]);
                  });
                },
                width: 160,
              ),
              CustomMaterialButton(
                caption: "Simpan dan Lanjut",
                function: () {
                  if (ratingController.length < 2) {
                    throw Exception("Must have more than 1 rating");
                  }

                  try {
                    for (var item in ratingController) {
                      if (item[0].text.isEmpty || item[1].text.isEmpty) {
                        throw Exception("Check input. Form can't be empty");
                      }

                      RatingComponent ratingComponent = RatingComponent(rating: item[0].text.trim(), value: double.parse(item[1].text.trim()));

                      if (!TemporaryCalculation().saw.ratingComponents.contains(ratingComponent)) {
                        TemporaryCalculation().saw.ratingComponents.add(ratingComponent);
                      }
                    }
                  } catch (exception, stackTrace) {
                    log("$exception\n$stackTrace");
                  }

                  log("saw criteria count : ${TemporaryCalculation().saw.criterias.length}");
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
                  itemCount: ratingController.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Row(
                        children: [
                          Flexible(
                            child: Column(
                              children: [
                                TextField(
                                  controller: ratingController[index][0],
                                  decoration: const InputDecoration(
                                    hintText: "Nilai Rating Kecocokan",
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextField(
                                  controller: ratingController[index][1],
                                  decoration: const InputDecoration(
                                    hintText: "Nilai",
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (index != 0)
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  ratingController.removeAt(index);
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
            ],
          ),
        ),
      ),
    );
  }
}
