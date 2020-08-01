import 'package:flutter/material.dart';

import 'animation_on_color.dart';

class MenuList extends StatelessWidget {
  final Iterable<Widget> tiles;
  final Color background;

  const MenuList({
    Key key,
    this.tiles,
    this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background ?? Theme.of(context).backgroundColor,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: ListTile.divideTiles(
          context: context,
          tiles: tiles,
        ).toList(),
      ),
    );
  }
}

class MenuListCustom extends StatelessWidget {
  final List<Widget> child;
  final ValueChanged<int> onTap;
  final Color background;

  const MenuListCustom({
    Key key,
    this.child,
    this.onTap,
    this.background,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MenuList(
      background: background,
      tiles: List.generate(child.length, (index) {
        return AnimationOnColor(
          child: ListTile(title: child[index]),
          onTap: () {
            if (onTap != null) onTap(index);
          },
        );
      }),
    );
  }
}

class MenuListIconItem {
  final String message;
  final IconData icon;

  MenuListIconItem(this.icon, this.message);
}

class MenuListIcon extends StatelessWidget {
  final List<MenuListIconItem> child;
  final ValueChanged<String> onTap;

  const MenuListIcon({
    Key key,
    this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MenuList(
      tiles: child.map((e) {
        return AnimationOnColor(
          child: ListTile(
            leading: Icon(e.icon),
            title: Text(e.message),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          onTap: () {
            if (onTap != null) onTap(e.message);
          },
        );
      }).toList(),
    );
  }
}

class MenuListMessage extends StatelessWidget {
  final List<String> messages;
  final ValueChanged<String> onTap;

  const MenuListMessage({
    Key key,
    this.messages,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MenuList(
      tiles: messages.map((e) {
        return AnimationOnColor(
          child: ListTile(
            title: Text(e),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
          onTap: () {
            if (onTap != null) onTap(e);
          },
        );
      }).toList(),
    );
  }
}
