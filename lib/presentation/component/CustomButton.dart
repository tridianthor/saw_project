import 'package:flutter/material.dart';
import 'package:saw_project/constants/AppTheme.dart';
import 'package:saw_project/constants/Dimens.dart';

class CustomMaterialButton extends StatefulWidget {
  String? caption;
  double? captionSize;
  double? width;
  double? height;
  Color? color;
  Color? captionColor;
  Widget? prefix;
  Function()? function;

  CustomMaterialButton({
    super.key,
    required this.caption,
    this.captionSize,
    this.width,
    this.height,
    this.color,
    this.captionColor,
    this.prefix,
    required this.function,
  });

  @override
  State<CustomMaterialButton> createState() => _CustomMaterialButtonState();
}

class _CustomMaterialButtonState extends State<CustomMaterialButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? Dimens.buttonWidth,
      child: MaterialButton(
        onPressed: widget.function,
        color: widget.color ?? AppTheme.buttonBlack,
        padding: EdgeInsets.zero,
        height: widget.height ?? Dimens.buttonHeight,
        minWidth: widget.height ?? Dimens.buttonWidth,
        shape: Dimens.buttonRoundedBorder,
        child: SizedBox(
          width: widget.width ?? Dimens.buttonWidth,
          child: Text(
            widget.caption!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.captionColor ?? Colors.white,
              fontSize: widget.captionSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomOutlineButton extends StatefulWidget {
  String? caption;
  double? captionSize;
  double? width;
  double? height;
  Color? outlineColor;
  Color? captionColor;
  Widget? prefix;
  Function()? function;

  CustomOutlineButton({
    super.key,
    this.caption,
    this.captionSize,
    this.width,
    this.height,
    this.outlineColor,
    this.captionColor,
    this.prefix,
    this.function,
  });

  @override
  State<CustomOutlineButton> createState() => _CustomOutlineButtonState();
}

class _CustomOutlineButtonState extends State<CustomOutlineButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? Dimens.buttonWidth,
      child: OutlinedButton(
        onPressed: widget.function,
        style: OutlinedButton.styleFrom(
          minimumSize: Size(widget.width ?? Dimens.buttonWidth,
              widget.height ?? Dimens.buttonHeight),
          foregroundColor: widget.outlineColor ?? Theme.of(context).colorScheme.primary,
          surfaceTintColor: widget.outlineColor ?? Theme.of(context).colorScheme.primary,
          side: BorderSide(
            color: widget.outlineColor ?? Theme.of(context).colorScheme.primary,
          ),
          shape: Dimens.buttonRoundedBorder,
        ),
        child: SizedBox(
          width: widget.width ?? Dimens.buttonWidth,
          child: Text(
            widget.caption!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: widget.captionColor ?? AppTheme.black,
              fontSize: widget.captionSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
