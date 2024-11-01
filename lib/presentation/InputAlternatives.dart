import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:saw_project/constants/AppTheme.dart';
import 'package:saw_project/model/AlternativeData.dart';
import 'package:saw_project/model/SAW.dart';
import 'package:saw_project/presentation/InputCriteria.dart';
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
    TemporaryCalculation().saw.clear();
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
                  if (alternativeControllers.length < 2) {
                    throw Exception("Must have more than 1 alternative");
                  }

                  int index = 0;
                  try {
                    for (var controller in alternativeControllers) {
                      if (controller.text.isEmpty) {
                        throw Exception("Check input. Form can't be empty");
                      }

                      AlternativeData alternative = AlternativeData(
                        alternative: controller.text.trim(),
                      );

                      if (!TemporaryCalculation().saw.alternatives.contains(alternative)) {
                        TemporaryCalculation().saw.alternatives.add(alternative);
                      }
                    }
                  } catch (exception, stackTrace) {
                    log("$exception\n$stackTrace");
                  }

                  log("saw alternative count : ${TemporaryCalculation().saw.alternatives.length}");

                  Navigator.pushNamed(context, InputCriteria.ID);
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
