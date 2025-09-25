/*
 * custom loading animation button
 */

import 'dart:ui' show lerpDouble;

import 'package:app/core/utils/extension/color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/config/theme/app_colors.dart';
import '../../../core/utils/constants/assets.dart';
import 'colored_background_button.dart';

/// [LoadingAnimatedButton] used to show loading animation
/// when user click on button
/// animation will show for [duration]
/// and will stop after [duration]
/// [height] and [width] is the size of button,
/// which is required for the animation
/// don't keep it [double.infinity] as it will make the button size unbound
class LoadingAnimatedButton extends StatefulWidget {
  final double height;
  final double width;
  final double minWidth;
  final Widget? loader;
  final Duration animationDuration;
  final Curve curve;
  final Curve reverseCurve;
  final String text;
  final Function(
      Function startLoading, Function stopLoading, ButtonState btnState)? onTap;
  final ColoredButtonType btnColor;
  final double? elevation;
  final EdgeInsetsGeometry padding;
  final Clip clipBehavior;
  final FocusNode? focusNode;
  final MaterialTapTargetSize? materialTapTargetSize;
  final bool roundLoadingShape;
  final double borderRadius;
  final BorderSide borderSide;
  final double? disabledElevation;
  final Color? disabledColor;
  final Color? disabledTextColor;
  final bool animate;

  const LoadingAnimatedButton({
    super.key,
    required this.height,
    required this.width,
    this.minWidth = 0,
    this.loader,
    this.animationDuration = const Duration(milliseconds: 300),
    this.curve = Curves.linear,
    this.reverseCurve = Curves.linear,
    required this.text,
    this.onTap,
    required this.btnColor,
    this.elevation,
    this.padding = const EdgeInsets.all(0),
    this.borderRadius = 10.0,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.materialTapTargetSize,
    this.roundLoadingShape = true,
    this.borderSide = const BorderSide(color: Colors.transparent, width: 0),
    this.disabledElevation,
    this.disabledColor,
    this.disabledTextColor,
    this.animate = true,
  });

  @override
  State<LoadingAnimatedButton> createState() => _LoadingAnimatedButtonState();
}

class _LoadingAnimatedButtonState extends State<LoadingAnimatedButton>
    with TickerProviderStateMixin {
  double? loaderWidth;
  late Animation<double> _animation;
  late AnimationController _controller;
  ButtonState _btn = ButtonState.idle;

  final GlobalKey _buttonKey = GlobalKey();
  double _minWidth = 0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: widget.animationDuration);
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
        reverseCurve: widget.reverseCurve));
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        if (mounted) {
          setState(() {
            _btn = ButtonState.idle;
          });
        }
      }
    });
    _minWidth = widget.height;
    loaderWidth = widget.height;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void animateForward() {
    if (!mounted) return;
    setState(() {
      _btn = ButtonState.busy;
    });
    _controller.forward();
  }

  void animateReverse() {
    if (!mounted) return;
    _controller.reverse();
  }

  double? lerpWidth(double a, double b, double t) {
    if (a == 0.0 || b == 0.0) {
      return null;
    } else {
      return a + (b - a) * t;
    }
  }

  double get minWidth => _minWidth;

  set minWidth(double w) {
    if (widget.minWidth == 0) {
      _minWidth = w;
    } else {
      _minWidth = widget.minWidth;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return buttonBody();
      },
    );
  }

  bool get enabled => widget.onTap != null;

  Widget buttonBody() {
    String backgroundAsset;
    Color color;
    switch (widget.btnColor) {
      case ColoredButtonType.red:
        backgroundAsset = Assets.backgroundButtonBackgroundRed;
        color = AppColors.colorAppRed;
        break;
      case ColoredButtonType.green:
        backgroundAsset = Assets.backgroundButtonBackgroundGreen;
        color = AppColors.colorAppGreen;
        break;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      clipBehavior: widget.clipBehavior,
      child: SizedBox(
        height: widget.height,
        width: widget.animate
            ? lerpWidth(widget.width, minWidth, _animation.value)
            : widget.width,
        child: ElevatedButton(
          key: _buttonKey,
          onPressed: () {
            if (!enabled) return;
            widget.onTap!(() => animateForward(), () => animateReverse(), _btn);
          },
          style: ButtonStyle(
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                side: widget.borderSide,
                borderRadius: BorderRadius.circular(
                  widget.roundLoadingShape
                      ? lerpDouble(widget.borderRadius, widget.height / 2,
                          _animation.value)!
                      : widget.borderRadius,
                ),
              ),
            ),
            backgroundColor: WidgetStateProperty.all(
                color.shade((_animation.value.toInt() * 255))),
            elevation: WidgetStateProperty.all<double?>(widget.elevation),
            padding:
                WidgetStateProperty.all<EdgeInsetsGeometry>(widget.padding),
          ),
          focusNode: widget.focusNode,
          child: _buildButton(backgroundAsset, color, enabled),
        ),
      ),
    );
  }

  /// builds the main button
  /// based on the [_btn] state
  Widget _buildButton(String backgroundAsset, Color color, bool enabled) {
    if (_btn == ButtonState.idle) {
      final mainButtonBg = Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              backgroundAsset,
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Text(
              widget.text,
              style: TextStyle(
                  fontSize: 12.sp,
                  height: 1.0,
                  color: Colors.white.shade(50, darker: !enabled),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );

      return ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: enabled
            ? mainButtonBg
            : ColorFiltered(
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.saturation),
                child: mainButtonBg,
              ),
      );
    } else {
      return widget.loader ??
          AnimatedContainer(
            duration: widget.animationDuration,
            width: 40.r,
            height: 40.r,
            padding: EdgeInsets.all(6.r),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.shade((1 - _animation.value.toInt()) * 255)),
            child: Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                color.shade(_animation.value.toInt() * 255),
              ),
            )),
          );
    }
  }
}

enum ButtonState { busy, idle }
