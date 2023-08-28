// ignore_for_file: library_private_types_in_public_api, unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/question_controller.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: const Duration(seconds: 100), vsync: this);
    _animation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    _animationController.reverse(from: 1.0);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        final questionController =
            Provider.of<QuestionController>(context, listen: false);
        questionController.fetchQuestions();
      }
    });
  }

  void stopAnimation() {
    _animationController.stop();
  }

  void resetAnimation() {
    _animationController.reset();
    _animationController.reverse(from: 1.0);
  }

  @override
  void didUpdateWidget(ProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questionController =
        Provider.of<QuestionController>(context, listen: false);
   
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
                  width: constraints.maxWidth * _animation.value,
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
                      Text("${(_animation.value * 100).round()} sec"),
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
