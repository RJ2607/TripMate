import 'package:flutter/material.dart';

class ProfileTileButton extends StatelessWidget {
  final String tileText;
  final IconData icon;
  final void Function()? onTap;
  final Color? bgColor;
  late bool forwardIcon = true;

  ProfileTileButton({
    required this.tileText,
    required this.icon,
    this.onTap,
    this.bgColor,
    this.forwardIcon = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: MediaQuery.of(context).size.height * 0.074,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: bgColor!.withOpacity(0.5),
            ),
            color: bgColor!.withOpacity(0.7),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(icon),
                  ), // Icon
                  Text(
                    tileText,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              forwardIcon
                  ? const Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                    )
                  : const SizedBox()
            ],
          ),
        ));
  }
}
