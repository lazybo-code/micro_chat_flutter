import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color textColor;
  final bool loading;
  final bool enabled;

  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.textColor = Colors.white,
    this.loading = false,
    this.enabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 17, horizontal: 40),
          color: Theme.of(context).primaryColorDark.withOpacity(.8),
          disabledColor: Theme.of(context)
              .primaryColorDark
              .withOpacity(loading == false ? .5 : .1),
          onPressed: enabled == false ? loading == true ? null : press : null,
          child: loading == false
              ? Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 17
                  ),
                )
              : CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}
