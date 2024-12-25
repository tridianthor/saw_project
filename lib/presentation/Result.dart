import 'package:flutter/material.dart';
import 'package:saw_project/model/AlternativeData.dart';
import 'package:saw_project/model/SAW.dart';
import 'package:saw_project/presentation/component/CustomAppBar.dart';

class Result extends StatefulWidget {
  static const ID = "result";

  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Winners winners = SawInstance().getWinners();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar().getAppBar(
          leadAction: () => Navigator.pop(context),
          caption: "Hasil perhitungan",
        ),
        body: Container(
          margin: const EdgeInsets.only(bottom: 90, right: 30, left: 30),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              const Text("Hasil akhir kalkulasi :"),
              if(winners.indices.length == 1)
                Text("Produk ${winners.indices.first} merupakan produk terbaik dengan skor akhir ${winners.value}")
              else
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: winners.indices.length,
                  itemBuilder: (context, index) {
                    return Text("-Produk ${SawInstance().saw.alternatives[index].alternative} merupakan salah satu produk terbaik dengan skor akhir ${winners.value}");
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
