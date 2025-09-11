import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexa_iq/auth/presentation/state/auth_notifier.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 150,
            height: 150,
            fit: BoxFit.contain,
          ),
          Text("Login", style: TextStyle(fontSize: 30)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(color: Colors.white), // text color
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: const TextStyle(
                  color: Color(0xFF5a5f60),
                ), // label color
                filled: true,
                fillColor: Color(0xFF03171f), // background color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // rounded edges
                  borderSide: const BorderSide(
                    color: Color(0xFF313838),
                    width: 2,
                  ), // highlight on focus
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF5a5f60),
                    width: 2,
                  ), // highlight on focus
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: const TextStyle(color: Colors.white), // text color
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: const TextStyle(
                  color: Color(0xFF5a5f60),
                ), // label color
                filled: true,
                fillColor: Color(0xFF03171f), // background color
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // rounded edges
                  borderSide: const BorderSide(
                    color: Color(0xFF313838),
                    width: 2,
                  ), // highlight on focus
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF5a5f60),
                    width: 2,
                  ), // highlight on focus
                ),
              ),
            ),
          ),

          CheckboxListTile(
            title: const Text(
              "Remember Me",
              style: TextStyle(color: Colors.white),
            ),
            value: true,
            activeColor: Colors.white, // color when checked
            checkColor: Colors.black, // tick color
            onChanged: (bool? value) {},
            controlAffinity: ListTileControlAffinity.leading,
          ),

          ElevatedButton(onPressed: (){
            if(context.mounted){
              context.push("/termsOfService");
            }
          }, child: Text("Login"))
        ],
      ),
    );
  }
}
