// getStr('home:already_entered_quiz')

part of 'home_screen.dart';

class _AlreadyEnteredQuizDialog extends ConsumerWidget {
  const _AlreadyEnteredQuizDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      backgroundColor: Theme.of(context).quizAlreadyEnteredDialogBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              getStr('home:already_entered_quiz_dialog:text'),
              style: TextStyle(
                color: Theme.of(context).quizAlreadyEnteredDialogTextColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TertiaryBtn(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  text: getStr('home:already_entered_quiz_dialog:close_btn'),
                  eventName: 'home:already_entered_quiz_dialog:close_btn',
                ),
              ],
            ),
          ].joinWidgetList(
            (_) => const SizedBox(
              height: defPaddingSize,
            ),
          ),
        ),
      ),
    );
  }
}
