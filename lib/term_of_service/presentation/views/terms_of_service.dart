import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TermsOfServicePage extends ConsumerWidget {
  const TermsOfServicePage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms of Service"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Soterix System'),
            Text('Terms Of Service', style: TextStyle(fontSize: 20),)
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
             color: const Color(0xff032531),
            
            child: Column(
              children: [
                Divider(),
                CheckboxListTile(
                title: const Text(
                  "I accept the terms and conditions of the Soterix System Terms of Service",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
                value: true,
                activeColor: Colors.white, // color when checked
                checkColor: Colors.black, // tick color
                onChanged: (bool? value) {},
                controlAffinity: ListTileControlAffinity.leading,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (){
                    if(context.mounted){
                      context.go('/landing');
                    }
                  }, 
                  child: Text("Submit")),
              )
              ],
            ),
          ),
        ),
      ),
    );
  }

}