import 'package:flutter/material.dart';

class SingleSizesWidget extends StatefulWidget {
  bool? viewSize = true;
   SingleSizesWidget({this.viewSize});

  @override
  State<SingleSizesWidget> createState() => _SingleSizesWidgetState();
}

class _SingleSizesWidgetState extends State<SingleSizesWidget> {
  int sizeIndex = 0;
  List<String> sizes = [
    "0.5k",
    "1k",
    "5k",
    "10k",
    "50k",
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisAlignment: (widget.viewSize == true)? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
         if(widget.viewSize == true) const Text("SIZE:", style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Color(0xff1B1B1B)
          ),),
          const SizedBox(width: 8),
          Container(
            height: 24,
            child: ListView.separated(
                shrinkWrap: true,
                reverse: false,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index)=> GestureDetector(
                  onTap: (){
                    setState(() {
                      sizeIndex = index;
                    });
                  },
                  child: Container(
                    margin:const EdgeInsets.symmetric(horizontal: 4),
                    width: 29,
                    height: 30,
                    alignment: Alignment.center ,
                    decoration: BoxDecoration(
                      color: (sizeIndex != index) ? Colors.transparent : const Color(0xffE6007E),
                      border: Border.all(color:(sizeIndex != index) ? const Color(0xff000000).withOpacity(0.43): Colors.transparent),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(sizes[index], style: TextStyle(
                        color: (sizeIndex != index) ?const Color(0xff1B1B1B) : const Color(0xffFFFFFF),
                        fontSize: 8,
                        fontWeight: FontWeight.w500
                    ),),
                  ),
                ),
                separatorBuilder: (context, index)=>const SizedBox(width: 0,),
                itemCount: sizes.length
            ),
          )
        ],
      ),
    );
  }
}
