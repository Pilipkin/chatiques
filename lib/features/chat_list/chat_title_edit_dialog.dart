import 'package:flutter/material.dart';

class ChatTitleEditDialog extends StatefulWidget {
  final String initialTitle;

  const ChatTitleEditDialog({Key? key, required this.initialTitle})
      : super(key: key);

  @override
  State<ChatTitleEditDialog> createState() => _ChatTitleEditDialogState();
}

class _ChatTitleEditDialogState extends State<ChatTitleEditDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialTitle);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Редактировать название чата'),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'Введите новое название',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(_controller.text),
          child: const Text('Сохранить'),
        ),
      ],
    );
  }
}
