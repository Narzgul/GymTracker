import 'package:flutter/material.dart';

class SettingTile extends StatefulWidget {
  final String title;
  final dynamic value;
  final ValueChanged<dynamic> onChanged;
  final bool editMode;
  final Icon? icon;

  const SettingTile({
    super.key,
    required this.title,
    required this.value,
    required this.editMode,
    required this.onChanged,
    this.icon,
  });

  @override
  State<SettingTile> createState() => _SettingTileState();
}

class _SettingTileState extends State<SettingTile> {
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
