import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavIcon extends StatefulWidget {
  NavIcon(
      {super.key,
      required this.iconPath,
      required this.label,
      required this.appStateActivity,
      required this.widgetName,
      required this.onIconStateChange});

  final String iconPath;
  final String label;
  final Map appStateActivity;
  final String widgetName;
  final onIconStateChange;

  void notifyParent(bool isActive) {
    onIconStateChange(isActive, widgetName);
  }

  @override
  State<NavIcon> createState() => _NavIconState();
}

class _NavIconState extends State<NavIcon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            widget.appStateActivity
                .update(widget.widgetName, (value) => !value);
            setState(() {});
            widget.notifyParent(widget.appStateActivity[widget.widgetName]);
          },
          child: SvgPicture.asset(
            widget.iconPath,
            color: widget.appStateActivity[widget.widgetName] &&
                    widget.appStateActivity.containsValue(true)
                ? Colors.blue
                : Colors.grey[600],
          ),
        ),
        Text(widget.label,
            style: TextStyle(
              fontSize: 12,
              color: widget.appStateActivity[widget.widgetName] &&
                      widget.appStateActivity.containsValue(true)
                  ? Colors.blue
                  : Colors.grey[600],
            ))
      ],
    );
  }
}
