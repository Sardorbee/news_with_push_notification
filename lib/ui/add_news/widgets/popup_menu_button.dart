import 'package:flutter/material.dart';
import 'package:news_with_push_notification/provider/news_provider.dart';
import 'package:provider/provider.dart';

class MyPopupMenuButton extends StatefulWidget {
  final List<String> items;
  final String initialValue;
  final Function(String) onChanged;
  final String tooltip;

  const MyPopupMenuButton({
    super.key,
    required this.items,
    required this.initialValue,
    required this.onChanged,
    this.tooltip = 'Select a topic',
  });

  @override
  _MyPopupMenuButtonState createState() => _MyPopupMenuButtonState();
}

class _MyPopupMenuButtonState extends State<MyPopupMenuButton> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      initialValue: _selectedValue,
      tooltip: widget.tooltip,
      onSelected: (String value) {
        setState(() {
          _selectedValue = value;
        });
        context.read<NewsProvider>().updateSelectedTopic(value);
        widget.onChanged(value);
      },
      itemBuilder: (BuildContext context) {
        return widget.items.map((String item) {
          return PopupMenuItem<String>(
            value: item,
            child: Text(
              item,
              style: const TextStyle(fontSize: 20),
            ),
          );
        }).toList();
      },
      child: Text(
        _selectedValue,
        style: const TextStyle(fontSize: 25, color: Colors.blue),
      ),
    );
  }
}
