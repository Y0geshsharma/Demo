import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class LoaderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                width: MediaQuery.of(context).size.width,
                height: 200.0,
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: 60.0,
                    ),
                  ),
                  buildStepShimmer(context),
                  buildStepShimmer(context),
                  buildStepShimmer(context),
                  buildStepShimmer(context),
                  buildStepShimmer(context),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300],
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 14.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300],
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 14.0,
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[300],
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[300],
                              ),
                              width: 100.0,
                              height: 14.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, bottom: 20.0, right: 20.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[300],
                      ),
                      width: 16,
                      height: 22.0,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300],
                        ),
                        height: 22.0,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 22.0,
                                height: 22.0,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  height: 22.0,
                                  color: Colors.grey[300],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 22.0,
                                height: 22.0,
                                color: Colors.grey[300],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300],
                                ),
                                width: 22.0,
                                height: 22.0,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  height: 22.0,
                                  color: Colors.grey[300],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300],
                                ),
                                width: 22.0,
                                height: 22.0,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 22.0,
                                height: 22.0,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  height: 22.0,
                                  color: Colors.grey[300],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300],
                                ),
                                width: 22.0,
                                height: 22.0,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 22.0,
                                height: 22.0,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  height: 22.0,
                                  color: Colors.grey[300],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[300],
                                ),
                                width: 22.0,
                                height: 22.0,
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
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
        width: MediaQuery.of(context).size.width,
        height: 40.0,
      ),
    );
  }
}
