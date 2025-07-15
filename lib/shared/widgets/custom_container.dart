import 'package:chingu_app/shared/constant/text_styles.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String? cardTitle;
  final String? total;
  final Icon? icon;

  const CustomContainer({
    super.key,
    this.cardTitle,
    this.total,
    this.icon
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.only(left: 10, right: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      icon ?? Icon(Icons.attach_money),
                      SizedBox(width: 8),
                      Text(cardTitle ?? "Null", style: AppTextStyles.smallText),
                    ],
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz)),
                ],
              ),
              Text(total ?? "0", style: AppTextStyles.dashboardCardNum),
            ],
          ),
        ),
      ),
    );
  }
}
