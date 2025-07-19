import 'dart:io';

import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:chingu_app/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/input_movie_controller.dart';

class InputMovieView extends GetView<InputMovieController> {
  const InputMovieView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        title: Text('Input Movie', style: AppTextStyles.label),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.text),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customInputFieldFull(
                  controller: controller.titleController,
                  label: "Movie Title",
                  hint: "Exp: Jumbo",
                  maxLines: 1,
                ),
                SizedBox(height: 20.h),
                customInputFieldFull(
                  controller: controller.synopsisController,
                  label: "Synopsis",
                  hint: "Type here",
                  maxLines: 5,
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => customDropdownField(
                          label: "Genre",
                          items: ["Action", "Comedy", "Drama", "Horror"],
                          selectedValue: controller.selectedGenre.value,
                          onChanged: (value) {
                            if (value != null) {
                              controller.selectedGenre.value = value;
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: Obx(
                        () => customDatePickerField(
                          label: "Release Date",
                          selectedDate: controller.selectedDate.value,
                          onDateSelected: (date) {
                            controller.selectedDate.value = date;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                customInputFieldFull(
                  label: "Price / Seat",
                  hint: "Exp: Rp. 25.000",
                  maxLines: 1,
                  controller: controller.priceController,
                ),
                SizedBox(height: 20.h),
                Obx(
                  () => customImagePickerField(
                    label: "Movie Poster",
                    selectedImage: controller.selectedImage.value,
                    onImageSelected: (file) {
                      controller.selectedImage.value = file;
                    },
                  ),
                ),
                SizedBox(height: 20.h),
                CustomButton(
                  text: "Insert Movie",
                  textStyle: AppTextStyles.buttonLight,
                  backgroundColor: AppColors.primary,
                  borderRadius: 20.r,
                  height: 65.h,
                  onPressed: () {
                    final title = controller.titleController.text.trim();
                    final synopsis = controller.synopsisController.text.trim();
                    final price = controller.priceController.text.trim();
                    final genre = controller.selectedGenre.value;
                    final date = controller.selectedDate.value;
                    final image = controller.selectedImage.value;

                    if ([
                          title,
                          synopsis,
                          price,
                          genre,
                          date,
                        ].any((e) => e.isEmpty) ||
                        image == null) {
                      Get.snackbar(
                        "Error",
                        "All fields must be filled and image selected",
                      );
                      return;
                    }

                    print("Ready to send:");
                    print("Title: $title");
                    print("Synopsis: $synopsis");
                    print("Price: $price");
                    print("Genre: $genre");
                    print("Date: $date");
                    print("Image Path: ${image.path}");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget customInputFieldFull({
    required String label,
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    final isMultiline = maxLines > 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.smallText),
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 50,
            maxHeight: isMultiline ? 200 : 60,
          ),
          child: TextField(
            controller: controller,
            maxLines: isMultiline ? null : 1,
            keyboardType:
                isMultiline ? TextInputType.multiline : TextInputType.text,
            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.hintText,
              border: const UnderlineInputBorder(),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2),
              ),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 8,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget customDropdownField({
    required String label,
    required List<String> items,
    required String selectedValue,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.smallText),
        DropdownButtonFormField<String>(
          value: selectedValue.isEmpty ? null : selectedValue,
          isExpanded: true,
          items:
              items
                  .map(
                    (item) => DropdownMenuItem(
                      value: item,
                      child: Text(item, overflow: TextOverflow.ellipsis),
                    ),
                  )
                  .toList(),
          onChanged: onChanged,
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.only(bottom: 5),
            border: UnderlineInputBorder(),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
          ),
          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
          hint: Text('Select genre', style: AppTextStyles.hintText),
        ),
      ],
    );
  }

  Widget customDatePickerField({
    required String label,
    required String selectedDate,
    required Function(String) onDateSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.smallText),
        GestureDetector(
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: Get.context!,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (picked != null) {
              onDateSelected(picked.toIso8601String().split("T").first);
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey)),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    selectedDate.isEmpty ? 'Select date' : selectedDate,
                    style:
                        selectedDate.isEmpty
                            ? AppTextStyles.hintText
                            : AppTextStyles.body.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget customImagePickerField({
    required String label,
    required File? selectedImage,
    required void Function(File imageFile) onImageSelected,
  }) {
    Future<void> pickImage(BuildContext context) async {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 75,
      );

      if (pickedFile != null) {
        final imageFile = File(pickedFile.path);
        onImageSelected(imageFile);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.smallText),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => pickImage(Get.context!),
          child: Container(
            height: 250,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(12),
              color: AppColors.primaryLight,
            ),
            child:
                selectedImage != null
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        selectedImage,
                        fit: BoxFit.cover,
                        width: 200,
                        height: 250,
                      ),
                    )
                    : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add_a_photo, color: Colors.grey),
                          const SizedBox(height: 4),
                          Text(
                            "Tap to select image",
                            style: AppTextStyles.hintText,
                          ),
                        ],
                      ),
                    ),
          ),
        ),
      ],
    );
  }
}
