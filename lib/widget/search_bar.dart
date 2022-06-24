import 'package:dekoki/common/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchBar extends StatefulWidget {
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  const SearchBar({Key? key, required this.focusNode, required this.onChanged}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 0, right: 0, left: 0, bottom: 1),
      child: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: ColorStyles.secondaryColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: TextField(
                controller: controller,
                focusNode: widget.focusNode,
                onChanged: widget.onChanged,
                cursorColor: ColorStyles.secondaryColor,
                cursorWidth: 1.7,
                style: GoogleFonts.roboto(
                  fontSize: 17,
                  color: ColorStyles.primaryTextColor,
                ),
                decoration: InputDecoration(
                  hintText: "Cari Restoran",
                  hintStyle: GoogleFonts.roboto(
                    color: ColorStyles.secondaryTextColor,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            GestureDetector(
              onTap: controller.clear,
              child: const Icon(
                Icons.clear,
                color: ColorStyles.tertiaryTextColor,
              ),
            ),
            const SizedBox(width: 8)
          ],
        ),
    );
  }
}
