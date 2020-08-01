import 'package:flutter/material.dart';
import 'package:micro_chat/components/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final String hintText;
  final bool obscureText;
  final Function onVisibility;
  final FocusNode focusNode;
  final bool enabled;

  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.hintText = '请输入密码',
    this.obscureText = true,
    this.onVisibility,
    this.onSubmitted,
    this.focusNode,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        enabled: enabled,
        focusNode: focusNode,
        obscureText: obscureText,
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        cursorColor: Theme.of(context).cursorColor,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(
            Icons.lock,
            color: Theme.of(context).iconTheme.color,
          ),
          suffixIcon: GestureDetector(
            child: Icon(
              obscureText == true ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).iconTheme.color,
            ),
            onTap: onVisibility,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
