import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AnswerMarkdown extends StatelessWidget {
  final String text;
  const AnswerMarkdown({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: text.isEmpty ? 'No answer yet' : text,
      selectable: true,
      styleSheetTheme: MarkdownStyleSheetBaseTheme.platform,
      styleSheet: MarkdownStyleSheet(
        codeblockDecoration: const BoxDecoration(color: Color(0xff4e586e)),
        code: TextStyle(
          background: Paint()..color = const Color(0xff4e586e),
          color: const Color(0xffffffff),
        ),
      ),
    );
  }
}
