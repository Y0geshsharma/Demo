import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class PurchaseLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Shimmer(
        duration: Duration(seconds: 5),
        //Default value: Duration(seconds: 0)
        interval: Duration(seconds: 5),
        //Default value
        color: Colors.white,
        //Default value
        enabled: true,
        //Default value
        direction: ShimmerDirection.fromLTRB(),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
              width: MediaQuery.of(context).size.width - 60,
              height: 100.0,
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    width: MediaQuery.of(context).size.width - 60,
                    height: 60.0,
                  ),
                ),
                buildStepShimmer(context),
                buildStepShimmer(context),
                buildStepShimmer(context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding buildStepShimmer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey[300],
        ),
        width: MediaQuery.of(context).size.width - 80,
        height: 40.0,
      ),
    );
  }
}
