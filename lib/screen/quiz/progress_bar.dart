import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/question_controller.dart';

class ProgressBar extends StatefulWidget {
  ProgressBar({Key? key}) : super(key: key);

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with TickerProviderStateMixin {
  late AnimationController ctrlDemo;
  @override
  void initState() {
    super.initState();
    ctrlDemo = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF3F4768), width: 3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Consumer<QuestionController>(
        builder: (context, questionController, _) {
          return Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) => Container(
                  // width:
                  //     constraints.maxWidth * questionController.animation.value,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 17, 137, 145),
                        Color.fromARGB(255, 21, 187, 216)
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30 / 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text(
                      //     "${(questionController.animation.value * 10).round()} sec"),
                      const Icon(Icons.lock_clock),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
