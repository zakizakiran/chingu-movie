import 'package:chingu_app/shared/constant/colors.dart';
import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomListContainer extends StatelessWidget {
  final String? movieTitle;
  final String? movieViews;
  final String? index;
  final ImageProvider? image;

  const CustomListContainer({
    super.key,
    this.movieTitle,
    this.movieViews,
    this.index,
    this.image
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.lightGrey
          )
        )
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
        child: Row(
          children: [
            Text("# ${index ?? "0"}", style: AppTextStyles.hintText),
            SizedBox(width: 10.w),
            Container(
              height: 100.h,
              width: 70.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: image ?? AssetImage("assets/images/jumbo-poster.png"),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movieTitle ?? "Unknown Title", style: AppTextStyles.smallTextBold),
                Text("${movieViews ?? "0"} views", style: AppTextStyles.smallText),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
