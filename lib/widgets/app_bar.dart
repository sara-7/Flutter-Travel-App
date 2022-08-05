import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    required this.title,
    this.backgroundColor,
    this.loading,
    this.actions,
  });
  final String title;
  final Color? backgroundColor;
  final IconButton? loading;
  final List<Widget>? actions;

  @override
  Size get preferredSize => Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: backgroundColor ?? Colors.white,
      title: Text(
        title,
        style: TextStyle(color: Colors.brown),
      ),
      centerTitle: true,
      elevation: 0,
      leading: loading,
      actions: actions,
    );
  }
}
