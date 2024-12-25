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
  AlternativeData? winner;
  double? score;

  @override
  void initState() {
    winner = SawInstance().getWinner()['winner'];
    score = SawInstance().getWinner()['score'];

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
          margin: const EdgeInsets.only(bottom: 90),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              const Text("Hasil akhir kalkulasi :"),
              Text("Produk ${winner!.alternative} merupakan produk yang terbaik dengan skor akhir $score"),
            ],
          ),
        ),
      ),
    );
  }
}
