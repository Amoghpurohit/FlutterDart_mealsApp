import 'package:flutter/material.dart';

class CustomSwitchListTile extends StatefulWidget {
  const CustomSwitchListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  State<CustomSwitchListTile> createState() => _CustomSwitchListTileState();
}

class _CustomSwitchListTileState extends State<CustomSwitchListTile> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: widget.value,
      onChanged: widget.onChanged,
      title: Text(
        widget.title,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      subtitle: Text(widget.subtitle),
    );
  }
}
