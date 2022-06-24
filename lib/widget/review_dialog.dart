import 'package:dekoki/common/style.dart';
import 'package:dekoki/data/model/review.dart';
import 'package:dekoki/provider/detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewDialog extends StatelessWidget {
  final RestaurantDetailProvider provider;
  final String id;

  const ReviewDialog({Key? key, required this.provider, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _nameController = TextEditingController();
    var _reviewController = TextEditingController();
    var _formKey = GlobalKey<FormState>();

    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      title: Text(
        "Tambahkan Review",
        style: GoogleFonts.roboto(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: ColorStyles.primaryTextColor,
        ),
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              cursorColor: ColorStyles.focusedBorderColor,
              keyboardType: TextInputType.name,
              style: const TextStyle(
                color: ColorStyles.primaryTextColor
              ),
              decoration: const InputDecoration(
                labelText: 'Nama',
                hintText: 'Masukkan Nama',
                hintStyle: TextStyle(
                  color: ColorStyles.secondaryTextColor
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorStyles.focusedBorderColor),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorStyles.enabledBorderColor),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorStyles.errorBorderColor),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) return "This field is required!";
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _reviewController,
              cursorColor: ColorStyles.focusedBorderColor,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                  color: ColorStyles.primaryTextColor
              ),
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: 'Review',
                hintText: 'Masukkan Review',
                hintStyle: TextStyle(
                    color: ColorStyles.secondaryTextColor
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorStyles.focusedBorderColor),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorStyles.enabledBorderColor),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ColorStyles.errorBorderColor),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              validator: (value) {
                if (value!.isEmpty) return "This field is required!";
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: TextButton.styleFrom(
                  primary: ColorStyles.primaryTextColor,
                  backgroundColor: ColorStyles.tertiaryColor,
                ),
                child: Text(
                  "Batal",
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ),
            const SizedBox(width: 5),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  CustomerReview review = CustomerReview(
                    id: id,
                    name: _nameController.text,
                    review: _reviewController.text,
                    date: '',
                  );
                  provider.restaurantReview(review).then((value) {
                    Navigator.pop(context);
                  });
                }
              },
              style: TextButton.styleFrom(
                primary: ColorStyles.primaryColor,
                backgroundColor: ColorStyles.secondaryColor,
              ),
              child: Text(
                "Tambah",
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(width: 15),
          ],
        ),
      ],
    );
  }
}
