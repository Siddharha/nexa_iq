import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa_iq/site/presentation/widgets/site_cell.dart';

class SitePage extends StatelessWidget {
  const SitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Newtown Area 1"),
      ),
      body: GridView.count(crossAxisCount: 2,
      children: [
        SiteCell(
          onTap : (){
            if(context.mounted){
              context.push("/landing/site/camera");
            }
          }
        ),
         SiteCell(),
          SiteCell()
      ],
      ),
    );
  }
}