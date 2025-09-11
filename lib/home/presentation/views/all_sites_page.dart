import 'package:flutter/material.dart';

class AllSitesPage extends StatelessWidget {
  const AllSitesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF03171f),
      child: ListView.separated(
         padding: const EdgeInsets.symmetric(vertical: 8),
         itemCount: 20,
         itemBuilder: (context,index){
          return ListTile(
            title: Text("Test", style: TextStyle(color: Colors.white),),
            trailing: Icon(Icons.keyboard_arrow_right),
            );
      },
      separatorBuilder: (context, index) {
      return const Divider(
        color: Colors.white54, // divider color
        thickness: 0.5,          // divider thickness
        indent: 16,            // left padding
        endIndent: 16,         // right padding
      );
        },),
    );
  }
}