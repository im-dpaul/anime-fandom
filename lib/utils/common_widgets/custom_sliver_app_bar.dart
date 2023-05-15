import 'package:anime_fandom/config/size_config.dart';
import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/constants/app_text_styles.dart';
import 'package:anime_fandom/utils/common_widgets/custom_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSliverAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  // final Color backgroundColor = Colors.red;
  final String title;
  final List<Widget>? actions;
  final Key? key;
  final Widget? leading;
  final BuildContext parentContext;
  final bool isBack;
  final VoidCallback? onTap;
  final double? leadingIconWidth;
  final Widget? titleWidget;
  final double? elevation;
  final Color? statusBarColor;
  final double? height;

  /// you can add more fields that meet your needs

  const CustomSliverAppBar({
    this.title = "title",
    this.titleWidget,
    required this.parentContext,
    this.key,
    this.leading,
    this.actions,
    this.isBack = false,
    this.onTap,
    this.leadingIconWidth,
    this.elevation,
    this.statusBarColor,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      toolbarHeight: height ?? 45 * SizeConfig.heightMultiplier!,
      // expandedHeight: height ?? 50 * SizeConfig.heightMultiplier!,
      floating: true,
      snap: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        // Status bar color
        statusBarColor: statusBarColor ?? AppColors.bgColor,
        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.light, // For iOS (dark icons)
      ),
      automaticallyImplyLeading: false,
      elevation: elevation ?? 0,
      title: titleWidget ??
          Text(
            title,
            style: AppTextStyles.f22W600White,
          ),
      backgroundColor: AppColors.grey1,
      actions: actions,
      leading: isBack
          ? leading ??
              CustomBackButton(
                parentContext: parentContext,
                onTap: onTap,
              )
          : null,
      leadingWidth: leadingIconWidth ?? 26,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height + 20);
}
