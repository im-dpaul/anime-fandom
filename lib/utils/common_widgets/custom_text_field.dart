import 'package:anime_fandom/config/size_config.dart';
import 'package:anime_fandom/constants/app_colors.dart';
import 'package:anime_fandom/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final int? maxLength;
  final bool? readOnly;
  final FocusNode focusNode;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? initialValue;
  final VoidCallback? onTap;
  final TextStyle textStyle;
  final TextStyle hintTextStyle;
  final BoxConstraints? iconSize;
  final TextCapitalization textCapitalization;
  CustomTextField({
    super.key,
    this.textEditingController,
    this.maxLength,
    this.onChanged,
    required this.focusNode,
    this.keyboardType,
    this.prefixIcon,
    this.hintText,
    this.initialValue,
    this.readOnly,
    this.onTap,
    this.suffixIcon,
    this.textStyle = AppTextStyles.f16W400White,
    this.hintTextStyle = AppTextStyles.f16W400Grey3,
    this.iconSize,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  onFocusChangeLisner() {
    // log('-----> on focus change:  ${widget.focusNode.hasFocus} ');
    setState(() {
      hasFocus = widget.focusNode.hasFocus;
    });
  }

  bool hasFocus = false;

  @override
  void initState() {
    widget.focusNode.addListener(onFocusChangeLisner);

    super.initState();
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(onFocusChangeLisner);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: hasFocus
                    ? AppColors.textFieldOuterBorder.withOpacity(0.2)
                    : AppColors.bgColor,
                width: 4,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    enabled: true,
                    focusNode: widget.focusNode,
                    maxLength: widget.maxLength,
                    controller: widget.textEditingController,
                    onChanged: (value) {
                      if (widget.onChanged != null) {
                        widget.onChanged!(value);
                      }
                    },
                    textCapitalization: widget.textCapitalization,
                    keyboardType: widget.keyboardType,
                    initialValue: widget.initialValue,
                    style: widget.textStyle,
                    decoration: InputDecoration(
                        counterText: '',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                const BorderSide(color: AppColors.grey2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 98, 143, 255))),
                        prefixIcon: widget.prefixIcon,
                        suffix: hasFocus ? widget.suffixIcon : null,
                        hintText: widget.hintText,
                        border: InputBorder.none,
                        hintStyle: widget.hintTextStyle,
                        prefixIconConstraints: widget.iconSize),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: hasFocus ||
                (widget.initialValue != null ||
                    widget.textEditingController!.text.isNotEmpty),
            child: Positioned(
              top: -2 * SizeConfig.heightMultiplier!,
              child: Container(
                margin: EdgeInsets.only(left: 12 * SizeConfig.widthMultiplier!),
                padding: const EdgeInsets.symmetric(horizontal: 6),
                color: AppColors.bgColor,
                child: Text(
                  widget.hintText ?? '',
                  style: hasFocus
                      ? AppTextStyles.f14W400Blue
                      : AppTextStyles.f14W400Grey3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
