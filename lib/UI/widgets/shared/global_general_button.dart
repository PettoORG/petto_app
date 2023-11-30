import 'package:flutter/material.dart';
import 'package:petto_app/UI/widgets/widgets.dart';
import 'package:sizer/sizer.dart';

class GlobalGeneralButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final bool isLoading;
  const GlobalGeneralButton({super.key, this.onPressed, required this.text, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    return Center(
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return colors.primaryContainer;
            }
            return colors.primary;
          }),
          fixedSize: MaterialStateProperty.all(Size(75.w, 6.5.h)),
          elevation: MaterialStateProperty.all(10),
          side: MaterialStateProperty.all(BorderSide.none),
        ),
        child: isLoading
            ? PettoLoading(color: Theme.of(context).colorScheme.primary, size: 10.w)
            : Text(
                text,
              ),
      ),
    );
  }
}
