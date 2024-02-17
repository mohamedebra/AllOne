import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingCoustomAllView extends StatelessWidget {
  const LoadingCoustomAllView({super.key});

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      height: MediaQuery.sizeOf(context).height + .01,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context,index){

        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey
                    ),),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 12,
                        width: MediaQuery.sizeOf(context).width * .4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey
                        ),
                      ),
                      SizedBox(height: 7,),
                      Container(
                        height: 12,
                        width: MediaQuery.sizeOf(context).width * .2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey
                        ),
                      ),

                    ],
                  )
                ],
              ),
              SizedBox(height: 7,)

            ],
          ),

        );
      },
        itemCount: 5,),
    );
  }
}
