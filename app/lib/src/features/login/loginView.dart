import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder:
          (context) => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // SvgPicture.asset('assets/l.svg', width: 250),
                // const SizedBox(height: 24),
                // Text(
                //   'Exkatikulator',
                //   style: Theme.of(context).textTheme.displayLarge,
                // ),
                // const SizedBox(height: 24),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a search term',
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
