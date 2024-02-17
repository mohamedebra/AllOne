import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomLoadingHome extends StatelessWidget {
  const CustomLoadingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      height: MediaQuery.sizeOf(context).height *.9,
      child: ListView.builder(

        itemBuilder: (context,index){
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          enabled: true,
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 10,top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
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
                          width: MediaQuery.sizeOf(context).width * .6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey
                          ),
                        ),
                        SizedBox(height: 7,),
                        Container(
                          height: 12,
                          width: MediaQuery.sizeOf(context).width * .3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey
                          ),
                        ),

                      ],
                    )
                  ],
                )

              ],
            ),
          ),

        );
      },
        itemCount: 10,),
    );
  }
}
