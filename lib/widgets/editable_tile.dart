import 'package:flutter/material.dart';

class EditableTile extends StatefulWidget {
  final String title;
  final dynamic value;
  final ValueChanged<dynamic> onChanged;
  final bool editMode;
  final Icon? icon;

  const EditableTile({
    super.key,
    required this.title,
    required this.value,
    required this.editMode,
    required this.onChanged,
    this.icon,
  });

  @override
  State<EditableTile> createState() => _EditableTileState();
}

class _EditableTileState extends State<EditableTile> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          widget.icon ?? const Icon(Icons.settings),
          const SizedBox(width: 8),
          Flexible(
            child: widget.editMode
                ? TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      label: Text(widget.title),
                    ),
                    onChanged: (value) {
                      widget.onChanged(value);
                    },
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        widget.title,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    Text(
                        widget.value.toString(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                  ],
                ),
          ),
        ],
      ),
    );
  }
}
