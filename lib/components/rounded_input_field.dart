import 'package:flutter/material.dart';
import 'package:micro_chat/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final FocusNode focusNode;
  final bool enabled;

  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.focusNode,
    this.onSubmitted,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        enabled: enabled,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        cursorColor: Theme.of(context).cursorColor,
        focusNode: focusNode,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Theme.of(context).iconTheme.color,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
