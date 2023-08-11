import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CircleAvatarIconButton extends StatelessWidget {
  const CircleAvatarIconButton(
      {super.key,
      required this.backgroundColor,
      required this.iconColor,
      required this.icon,
      required this.onPressed,
      required this.iconSize});

  final Color backgroundColor;
  final Color iconColor;
  final IconData icon;
  final VoidCallback? onPressed;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: backgroundColor,
      child: IconButton(
        iconSize: iconSize,
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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(9)),
        offset: const Offset(0, -5),
      ),
      hint: const Text(
        '참여 가능한 장소',
        style: TextStyle(
            overflow: TextOverflow.ellipsis, color: Colors.black, fontSize: 15),
      ),
      isExpanded: true,
      items: widget.itemList?.keys.toList().map((String itemText) {
        return DropdownMenuItem<String>(
            value: itemText,
            child: Container(
              width: 290,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: .5, color: Color(0xff707070))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    itemText,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${widget.itemList![itemText]!['start_date']!}~${widget.itemList![itemText]!['end_date']!}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            )
            // Text(
            //   itemText,
            //   style: const TextStyle(
            //     overflow: TextOverflow.ellipsis,
            //   ),
            // ),
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

class DropdownMapButtonNull extends StatefulWidget {
  DropdownMapButtonNull({super.key, required this.itemList});

  final Map<String, dynamic>? itemList;

  @override
  _DropdownMapButtonNullState createState() => _DropdownMapButtonNullState();
}

class _DropdownMapButtonNullState extends State<DropdownMapButton> {
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
      onChanged: (String? newValue) {},
    );
  }
}
