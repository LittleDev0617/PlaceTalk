import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CircleAvatarIconButton extends StatelessWidget {
  const CircleAvatarIconButton(
      {super.key,
      required this.backgroundColor,
      required this.iconColor,
      required this.icon,
      required this.onPressed});

  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}

class DropdownMapButton extends StatefulWidget {
  DropdownMapButton({super.key, required this.itemList, this.controller});

  final Map<String, dynamic>? itemList;

  final NaverMapController? controller;

  @override
  State<DropdownMapButton> createState() => _DropdownMapButtonState();
}

class _DropdownMapButtonState extends State<DropdownMapButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton2(
      underline: const SizedBox.shrink(),
      dropdownStyleData: DropdownStyleData(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        offset: const Offset(0, -5),
      ),
      hint: const Text(
        '참여 가능한 장소',
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
        ),
      ),
      isExpanded: true,
      items: widget.itemList?.keys.toList().map((String itemText) {
        return DropdownMenuItem<String>(
          value: itemText,
          child: Text(
            itemText,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList(),
      onChanged: (String? newValue) {
        if (widget.controller != null) {
          widget.controller!.updateCamera(
            NCameraUpdate.withParams(
              target: NLatLng(widget.itemList![newValue]!['latitude']!,
                  widget.itemList![newValue]!['longitude']!),
            ),
          );
        }
      },
    );
  }
}
