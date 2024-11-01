import 'package:flutter/material.dart';
import 'package:saw_project/presentation/InputAlternatives.dart';
import 'package:saw_project/presentation/component/CustomButton.dart';

class Home extends StatefulWidget {
  static const ID = "home";

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.center,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomMaterialButton(caption: "Buat Perhitungan Baru", function: () {
                Navigator.pushNamed(context, InputAlternatives.ID);
              }),
            ],
          ),
        ),
      ),
    );
  }
}
