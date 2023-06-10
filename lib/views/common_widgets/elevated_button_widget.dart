import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatefulWidget {
  final Future Function()? onPressed;
  final Widget child;
  final Size? size;
  const ElevatedButtonWidget({super.key, required this.onPressed, required this.child, this.size});
  
  @override
  State<ElevatedButtonWidget> createState() => _ElevatedButtonWidgetState();
}

class _ElevatedButtonWidgetState extends State<ElevatedButtonWidget> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: widget.size
      ),
      onPressed: widget.onPressed == null || isLoading ? null : ()async{
          setState(() {
            isLoading = true;
          });
          await widget.onPressed!();
          setState(() {
            isLoading = false;
          });
      },
      child: widget.child);
  }
}