import 'package:flutter/material.dart';
import 'package:widgets_book/widgets_book.dart';

class AppExpandableCard extends StatefulWidget {
  const AppExpandableCard({
    required this.title,
    required this.children,
    this.fontSize,
    this.stepNo,
    this.isList = true,
    this.isExpanded = true,
    super.key,
  });

  final String title;
  final String? stepNo;
  final double? fontSize;
  final List<Widget> children;
  final bool? isExpanded;
  final bool isList;

  @override
  State<AppExpandableCard> createState() => _AppExpandableCardState();
}

class _AppExpandableCardState extends State<AppExpandableCard> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded ?? true;
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.title;
    final children = widget.children;
    return Column(
      children: [
        Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: ListTile(
            horizontalTitleGap: 18.h,
            contentPadding:
                EdgeInsets.symmetric(vertical:  8.h,  horizontal: 18.h),
            tileColor: AppColors.primary800,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            title: Text(
              title,
              style: theme.textTheme.titleSmall?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w400,
                  fontFamily: FontFamily.saira),
            ),
            trailing: Icon(
              !_isExpanded ? Icons.expand_less : Icons.expand_more,
              color: AppColors.white,
            ),
          ),
        ),
        if (_isExpanded && widget.isList && children.isNotEmpty) ...[12.verticalSpace, ...children],
        if (_isExpanded && !widget.isList && children.isNotEmpty) ...[
          12.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.h),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisExtent: 170.h, crossAxisCount: 3, crossAxisSpacing: 8.h, mainAxisSpacing: 8.h,),
              itemBuilder: (context, index) => children[index],
              itemCount: children.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
          )
        ]
      ],
    );
  }
}
