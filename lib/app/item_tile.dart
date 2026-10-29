import 'package:axcend/ui.dart';

class ItemTile extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final VoidCallback? onTap;

  const ItemTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      clipBehavior: .hardEdge,
      color: theme.colorScheme.surface,
      borderRadius: AppStyle.borderRadiusMedAll,
      elevation: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppStyle.borderRadiusMedAll,
          border: BoxBorder.all(
            color: theme.colorScheme.outline.withAlpha(96),
            width: 1,
          ),
        ),
        clipBehavior: .hardEdge,
        child: ListTile(
          leading: leading,
          tileColor: theme.colorScheme.surface,
          titleTextStyle: theme.textTheme.titleLarge?.copyWith(
            overflow: .ellipsis,
          ),
          title: title,
          subtitleTextStyle: theme.textTheme.labelMedium?.copyWith(
            overflow: .ellipsis,
          ),
          subtitle: subtitle,
          onTap: onTap,
        ),
      ),
    );
  }
}
