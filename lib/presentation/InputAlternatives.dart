import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:saw_project/constants/AppTheme.dart';
import 'package:saw_project/model/AlternativeData.dart';
import 'package:saw_project/model/Criteria.dart';
import 'package:saw_project/model/RatingComponent.dart';
import 'package:saw_project/model/RatingPerCriteria.dart';
import 'package:saw_project/model/SAW.dart';
import 'package:saw_project/presentation/InputCriteria.dart';
import 'package:saw_project/presentation/InputData.dart';
import 'package:saw_project/presentation/component/CustomAppBar.dart';
import 'package:saw_project/presentation/component/CustomButton.dart';

class InputAlternatives extends StatefulWidget {
  static const ID = "input-alternative";

  const InputAlternatives({super.key});

  @override
  State<InputAlternatives> createState() => _InputAlternativesState();
}

class _InputAlternativesState extends State<InputAlternatives> {
  List<TextEditingController> alternativeControllers = [TextEditingController()];

  @override
  void initState() {
    super.initState();
    SawInstance().saw.clear();

    SawInstance().saw.criterias = Criteria.generateCriteria();
    SawInstance().saw.ratingComponents = RatingComponent.generateRatingComponent();
    SawInstance().saw.ratingPerCriteria = RatingPerCriteria.generateRatingPerCriteria();
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
              CustomOutlineButton(
                caption: "Tambahkan form",
                function: () {
                  setState(() {
                    alternativeControllers.add(TextEditingController());
                  });
                },
                width: 160,
              ),
              CustomMaterialButton(
                caption: "Simpan dan Lanjut",
                function: () {
                  try {
                    if (alternativeControllers.length < 2) {
                      throw Exception("Must have more than 1 alternative");
                    }

                    for (var controller in alternativeControllers) {
                      if (controller.text.isEmpty) {
                        throw Exception("Check input. Form can't be empty");
                      }

                      AlternativeData alternative = AlternativeData(
                        alternative: controller.text.trim(),
                      );

                      if (!SawInstance().saw.alternatives.contains(alternative)) {
                        SawInstance().saw.alternatives.add(alternative);
                      }
                    }
                  } catch (exception, stackTrace) {
                    log("$exception\n$stackTrace");
                    QuickAlert.show(context: context, type: QuickAlertType.error, text: exception.toString());
                  }

                  log("saw alternative count : ${SawInstance().saw.alternatives.length}");

                  Navigator.pushNamed(context, InputData.ID);
                },
                width: 150,
              ),
            ],
          ),
        ),
        appBar: CustomAppBar().getAppBar(
          leadAction: () => Navigator.pop(context),
          caption: "Masukkan alternatif",
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
                  itemCount: alternativeControllers.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Row(
                        children: [
                          Flexible(
                            child: TextField(
                              controller: alternativeControllers[index],
                              decoration: const InputDecoration(
                                hintText: "Nama alternatif",
                              ),
                            ),
                          ),
                          if (index != 0)
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  alternativeControllers.removeAt(index);
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
