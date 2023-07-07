import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/question_controller.dart';

class Option extends StatelessWidget {
  const Option({
    Key? key,
    required this.text,
    required this.index,
    required this.press,
  }) : super(key: key);

  final String text;
  final int index;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, watch, _) {
        final questionController = watch(questionControllerProvider);

        Color getTheRightColor() {
          if (questionController.isAnswered) {
            if (index == questionController.correctAns) {
              return Colors.green;
            } else if (index == questionController.selectedAns &&
                questionController.selectedAns !=
                    questionController.correctAns) {
              return Colors.red;
            }
          }
          return const Color.fromRGBO(193, 193, 193, 1);
        }

        IconData getTheRightIcon() {
          return getTheRightColor() == Colors.red ? Icons.close : Icons.done;
        }

        return InkWell(
          onTap: press,
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(
                color: getTheRightColor(),
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${index + 1}. $text',
                  style: TextStyle(
                    color: getTheRightColor(),
                  ),
                ),
                Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    color: getTheRightColor() ==
                            const Color.fromRGBO(193, 193, 193, 1)
                        ? Colors.transparent
                        : getTheRightColor(),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: getTheRightColor()),
                  ),
                  child: getTheRightColor() ==
                          const Color.fromRGBO(193, 193, 193, 1)
                      ? null
                      : Icon(getTheRightIcon(), size: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
