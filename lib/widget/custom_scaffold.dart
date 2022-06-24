import 'package:dekoki/common/style.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;

  const CustomScaffold({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            body,
            _buildShortAppBar(context),
          ],
        ),
      ),
    );
  }
}

Widget _buildShortAppBar(BuildContext context) {
  return Card(
    margin: const EdgeInsets.all(0),
    child: Row(
      mainAxisSize: MainAxisSize.min,
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
      ],
    ),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(15.0),
      ),
    ),
  );
}
