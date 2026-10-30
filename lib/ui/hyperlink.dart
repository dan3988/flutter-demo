import 'package:flutter_demo/ui.dart';

class Hyperlink extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final TextStyle? textStyle;

  const Hyperlink({
    super.key,
    required this.text,
    required this.onTap,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final style = textStyle ?? DefaultTextStyle.of(context).style;
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: style.copyWith(decoration: .underline, color: Colors.blue),
      ),
    );
  }
}
