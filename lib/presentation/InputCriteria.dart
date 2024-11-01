import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:saw_project/model/Criteria.dart';
import 'package:saw_project/model/SAW.dart';
import 'package:saw_project/presentation/component/CustomAppBar.dart';
import 'package:saw_project/presentation/component/CustomButton.dart';

class InputCriteria extends StatefulWidget {
  static const ID = "input-criteria";

  const InputCriteria({super.key});

  @override
  State<InputCriteria> createState() => _InputCriteriaState();
}

class _InputCriteriaState extends State<InputCriteria> {
  List<List<dynamic>> criteriaControllers = [
    [TextEditingController(), 0, TextEditingController()],
  ];

  List<DropdownMenuEntry> dropdownItems = [
    const DropdownMenuEntry(
      value: 0,
      label: "Cost",
    ),
    const DropdownMenuEntry(
      value: 1,
      label: "Benefit",
    )
  ];

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
                    criteriaControllers.add([TextEditingController(), 0, TextEditingController()]);
                  });
                },
                width: 160,
              ),
              CustomMaterialButton(
                caption: "Simpan dan Lanjut",
                function: () {

                  if (criteriaControllers.length < 2) {
                    throw Exception("Must have more than 1 criteria");
                  }

                  int index = 0;
                  try {
                    for (var item in criteriaControllers) {
                      if (item[0].text.isEmpty || item[2].text.isEmpty) {
                        throw Exception("Check input. Form can't be empty");
                      }

                      var criteriaController = item[0];
                      var criteriaCategory = item[1];
                      var weightController = item[2];

                      Criteria criteria = Criteria(
                        criteria: criteriaController.text.trim(),
                        weight: double.parse(weightController.text.trim()),
                        criteriaCategory: criteriaCategory,
                      );

                      if(!TemporaryCalculation().saw.criterias.contains(criteria)){
                        TemporaryCalculation().saw.criterias.add(criteria);
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
          caption: "Masukkan kriteria",
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
                  itemCount: criteriaControllers.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Row(
                        children: [
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextField(
                                  controller: criteriaControllers[index][0],
                                  decoration: const InputDecoration(
                                    hintText: "Nama kriteria",
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    DropdownMenu(
                                      initialSelection: 0,
                                      dropdownMenuEntries: dropdownItems,
                                      onSelected: (value) {
                                        log("value : $value");
                                        setState(() {
                                          criteriaControllers[index][1] = value;
                                        });
                                      },
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                      child: TextField(
                                        controller: criteriaControllers[index][2],
                                        decoration: const InputDecoration(
                                          hintText: "Bobot kriteria",
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          if (index != 0)
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  criteriaControllers.removeAt(index);
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
