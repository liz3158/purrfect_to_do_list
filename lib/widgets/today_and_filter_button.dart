import 'package:doable_todo_list_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TodayAndFilterButton extends StatelessWidget {
  final bool showCompletedTasks;
  final VoidCallback onFilterToggle;

  const TodayAndFilterButton({
    super.key,
    this.showCompletedTasks = true,
    required this.onFilterToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Today",
          style: Theme.of(context).textTheme.displayMedium,
        ),
        GestureDetector(
          onTap: onFilterToggle,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width * 0.25,
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            decoration: BoxDecoration(
                color: blackColor,
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.width)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  showCompletedTasks ? "All" : "Active",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(
                          color: whiteColor, fontSize: 13),
                ),
                SvgPicture.asset("assets/filter.svg",
                    height: MediaQuery.of(context).size.height *
                        0.014),
              ],
            ),
          ),
        ),
      ],
    );
  }
}