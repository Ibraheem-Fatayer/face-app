import 'package:flutter/material.dart';

class SingleChildScrollViewLayout extends StatelessWidget {
  const SingleChildScrollViewLayout({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.only(bottom: 00),
    this.scrollController,
    this.physics,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final ScrollController? scrollController;
  final ScrollPhysics? physics;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SingleChildScrollView(
        controller: scrollController,
        padding: padding,
        physics: physics ??
            const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
        child: ConstrainedBox(
          constraints: constraints.copyWith(
              minHeight: constraints.maxHeight, maxHeight: double.infinity),
          child: child,
        ),
      );
    });
  }
}
