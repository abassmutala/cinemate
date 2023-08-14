import 'package:cinemate/widgets/empty_state_layout.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class APIListBuilder<T> extends StatelessWidget {
  const APIListBuilder({
    Key? key,
    required this.snapshot,
    required this.buildWidget,
    this.nullIcon,
    this.errorIcon = LucideIcons.alertTriangle,
    this.nullLabel,
    this.errorTitle,
    this.nullSubLabel,
    this.errorSubtitle,
    this.referralButtonTitle,
    this.referralAction,
    this.separatorWidget = const SizedBox(
      height: 4.0,
    ),
    this.scrollDirection = Axis.vertical,
    this.padding,
  }) : super(key: key);
  final AsyncSnapshot<T> snapshot;
  final Widget buildWidget;
  final IconData? nullIcon;
  final IconData errorIcon;
  final String? nullLabel;
  final String? errorTitle;
  final String? nullSubLabel;
  final String? errorSubtitle;
  final String? referralButtonTitle;
  final GestureTapCallback? referralAction;
  final Widget separatorWidget;
  final Axis scrollDirection;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List? items = snapshot.data as List?;
      if (items!.isNotEmpty) {
        return buildWidget;
      } else {
        return Container(
          color: Theme.of(context).colorScheme.surface,
          child: EmptyStateLayout(
            nullIcon: nullIcon,
            nullLabel: nullLabel,
            nullSubLabel: nullSubLabel,
            referralAction: referralAction,
            referralButtonLabel: referralButtonTitle,
          ),
        );
      }
    } else if (snapshot.hasError) {
      debugPrint(snapshot.error.toString());
      debugPrint(snapshot.error.toString());
      return EmptyStateLayout(
        nullIcon: errorIcon,
        nullLabel: errorTitle,
        nullSubLabel: errorSubtitle,
      );
    }
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }

}




              

              // if (snapshot.connectionState == ConnectionState.done) {
              //   Map<String, dynamic> data =
              //       snapshot.data!.data() as Map<String, dynamic>;
              //   final _host = CarHost.fromMap(data);
              //   return ListTile();
              // }

              // return const CircularProgressIndicator.adaptive();