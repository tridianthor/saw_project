import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:saw_project/model/Criteria.dart';
import 'package:saw_project/model/SAW.dart';
import 'package:saw_project/presentation/Result.dart';
import 'package:saw_project/presentation/component/CustomAppBar.dart';
import 'package:saw_project/presentation/component/CustomButton.dart';

class InputData extends StatefulWidget {
  static const ID = "input-data";

  const InputData({super.key});

  @override
  State<InputData> createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  Map<String, dynamic> dataInputMap = {};

  List<DropdownMenuEntry> dropdownItems = SawInstance().saw.ratingPerCriteria[3].value.map<DropdownMenuEntry>((element) {
    return DropdownMenuEntry(value: element, label: element);
  }).toList();

  @override
  void initState() {
    for (var alternative in SawInstance().saw.alternatives) {
      dataInputMap[alternative.alternative!] = SawInstance().saw.criterias.map((criteria) {
        return TextEditingController();
      }).toList();
    }

    dataInputMap.forEach((key, value) {
      for(var controller in value){
        log("key: $key, value: ${controller.text}");
      }
    });

    super.initState();
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
                  try {
                    dataInputMap.forEach((key, element){
                      for(var controller in element){
                        if (controller.text.isEmpty) {
                          throw Exception("Check input. Form can't be empty");
                        }
                      }
                    });

                    dataInputMap.forEach((key, element){
                      SawInstance().saw.data[key] = element
                          .map((TextEditingController controller) => controller.text)
                          .cast<String>()
                          .toList();
                    });

                    SawInstance().calculateMatrix();

                    Navigator.pushNamed(context, Result.ID);
                  } catch (exception, stackTrace) {
                    log("$exception\n$stackTrace");
                    QuickAlert.show(context: context, type: QuickAlertType.error, text: exception.toString());
                  }
                },
                width: 150,
              ),
            ],
          ),
        ),
        appBar: CustomAppBar().getAppBar(
          leadAction: () => Navigator.pop(context),
          caption: "Masukkan data",
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
                  itemCount: SawInstance().saw.alternatives.length,
                  itemBuilder: (context, index) {
                    var alternative = SawInstance().saw.alternatives[index];
                    return ExpansionTile(
                      title: Text(alternative.alternative!),
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minHeight: 120,
                            maxHeight: 300,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: SawInstance().saw.criterias.length,
                            itemBuilder: (context, criteriaIndex) {
                              var criteria = SawInstance().saw.criterias[criteriaIndex];
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(criteria.criteria!),
                                    SizedBox(
                                        width: 270,
                                        child: criteria.inputType == InputType.num
                                            ? TextField(
                                                controller: dataInputMap[alternative.alternative][criteriaIndex],
                                                decoration: InputDecoration(
                                                  hintText: criteria.hint!,
                                                ),
                                              )
                                            : DropdownMenu(
                                                initialSelection: 0,
                                                dropdownMenuEntries: dropdownItems,
                                                onSelected: (value) {
                                                  log("value : $value");
                                                  setState(() {
                                                    dataInputMap[alternative.alternative][criteriaIndex].text = value;
                                                  });
                                                },
                                                hintText: "Input Type",
                                              ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
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
