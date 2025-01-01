import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:blogify_flutter/theme/app_theme.dart';
import 'package:blogify_flutter/widgets/common/menu_widget.dart';

class AppHeader extends StatefulWidget implements PreferredSizeWidget {
  final bool isLarge;
  final double? height;

  const AppHeader({
    Key? key,
    this.isLarge = false,
    this.height,
  }) : super(key: key);

  @override
  State<AppHeader> createState() => _AppHeaderState();

  @override
  Size get preferredSize =>
      Size.fromHeight(height ?? (isLarge ? 100 : kToolbarHeight + 16));
}

class _AppHeaderState extends State<AppHeader> {
  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontSize: widget.isLarge ? 16 : 14,
      fontWeight: FontWeight.w500,
      color: Colors.grey.shade800,
    );

    return Material(
      color: Colors.white,
      elevation: 0,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: widget.isLarge ? 48 : 32,
            vertical: widget.isLarge ? 20 : 12,
          ),
          child: Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.edit_note_rounded,
                    size: widget.isLarge ? 40 : 32,
                    color: Colors.blue.shade700,
                  ),
                  SizedBox(width: widget.isLarge ? 12 : 8),
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Colors.blue.shade700, Colors.purple.shade700],
                    ).createShader(bounds),
                    child: Text(
                      'Blogify',
                      style: TextStyle(
                        fontSize: widget.isLarge ? 32 : 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: widget.isLarge ? 64 : 48),
              TextButton(
                onPressed: () => context.go('/'),
                child: Text('Home', style: textStyle),
              ),
              SizedBox(width: widget.isLarge ? 40 : 32),
              TextButton(
                onPressed: () => context.go('/explore'),
                child: Text('Explore', style: textStyle),
              ),
              SizedBox(width: widget.isLarge ? 40 : 32),
              TextButton(
                onPressed: () => context.go('/categories'),
                child: Text('Categories', style: textStyle),
              ),
              SizedBox(width: widget.isLarge ? 40 : 32),
              TextButton(
                onPressed: () => context.go('/stories'),
                child: Text('Stories', style: textStyle),
              ),
              Spacer(),
              SizedBox(width: widget.isLarge ? 24 : 16),
              IconButton(
                icon: Icon(
                  Icons.notifications_outlined,
                  size: widget.isLarge ? 28 : 24,
                ),
                onPressed: () {},
              ),
              SizedBox(width: widget.isLarge ? 24 : 16),
              IconButton(
                icon: Icon(
                  Icons.person_outline,
                  size: widget.isLarge ? 28 : 24,
                ),
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: MaterialLocalizations.of(context)
                        .modalBarrierDismissLabel,
                    barrierColor: Colors.transparent,
                    transitionDuration: Duration(milliseconds: 200),
                    pageBuilder: (context, animation1, animation2) {
                      return MenuWidget();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
