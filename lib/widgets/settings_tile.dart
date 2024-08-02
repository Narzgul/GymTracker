import 'package:flutter/material.dart';

class SettingsTile extends StatefulWidget {
  final String title;
  final dynamic value;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedValue;
  final Function onDelete;
  final bool editMode;
  final Icon? icon;

  const SettingsTile({
    super.key,
    required this.title,
    required this.value,
    required this.editMode,
    required this.onChangedTitle,
    required this.onChangedValue,
    this.icon,
    required this.onDelete,
  });

  @override
  State<SettingsTile> createState() => _EditableTileState();
}

class _EditableTileState extends State<SettingsTile> {
  late TextEditingController titleController, valueController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title.toString());
    valueController = TextEditingController(text: widget.value.toString());
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
                ? Row(
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            TextFormField(
                              controller: titleController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                label: Text('Title'),
                              ),
                              onChanged: (value) {
                                widget.onChangedTitle(value);
                              },
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            TextFormField(
                              controller: valueController,
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                label: Text('Value'),
                              ),
                              onChanged: (value) {
                                widget.onChangedValue(value);
                              },
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 40,
                        margin: const EdgeInsets.only(left: 8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(0),
                          ),
                          onPressed: () => widget.onDelete(),
                          child: const Icon(Icons.delete),
                        ),
                      ),
                    ],
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
