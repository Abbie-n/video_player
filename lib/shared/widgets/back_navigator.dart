import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class BackNavigator extends StatelessWidget {
  const BackNavigator({Key? key, this.route}) : super(key: key);

  final PageRouteInfo? route;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.canPop(context)
          ? Navigator.pop(context)
          : context.router.push(route!),
      child: Container(
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
        child: const Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }
}
