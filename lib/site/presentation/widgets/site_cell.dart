import 'package:flutter/material.dart';

class SiteCell extends StatelessWidget {
  const SiteCell({super.key,  this.onTap});
  final  Function? onTap;
  @override
  Widget build(BuildContext context) {
    return 
Padding(
  padding: const EdgeInsets.all(8.0),
  child: InkWell(
    onTap: (){
      onTap?.call();
    },
    child: Card(
     shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(50), // round corners
    ),
      elevation: 3,
      child: GridTile(footer: Container(
        color: const Color.fromARGB(96, 0, 0, 0),
        height: 30,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(maxRadius: 5, backgroundColor: Colors.amber,),
            ),
            Text("Camera 1")
          ],
        ),
      ),child: Container(
        color: const Color.fromARGB(255, 99, 99, 99),
        width: 80,
        height: 40,
        
      ),),
    ),
  ),
);
  }
}