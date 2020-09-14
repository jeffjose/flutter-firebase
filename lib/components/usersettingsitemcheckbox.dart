import 'package:flutter/material.dart';
import 'package:stream_state/stream_state.dart';

class UserSettingsItemCheckbox extends StatefulWidget {
  final IconData icon;
  final String text;
  final StreamState toggle;

  UserSettingsItemCheckbox(this.icon, this.text, this.toggle);

  @override
  _UserSettingsItemCheckboxState createState() =>
      _UserSettingsItemCheckboxState();
}

class _UserSettingsItemCheckboxState extends State<UserSettingsItemCheckbox> {
  bool isChecked;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.toggle.state = !widget.toggle.state;
      },
      child: Container(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Icon(widget.icon),
              ),
              Text(
                widget.text,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 16),
              ),
              Spacer(),
              Switch(
                  activeColor: Theme.of(context).colorScheme.onSecondary,
                  value: widget.toggle.state,
                  onChanged: (value) {
                    setState(() {
                      widget.toggle.state = value;
                    });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
