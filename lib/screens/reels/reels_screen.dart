import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.network(
              'https://images.pexels.com/photos/4526482/pexels-photo-4526482.jpeg?auto=compress&cs=tinysrgb&w=600',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Positioned(
          top: 30,
          left: 20,
          child: Row(
            children: [
              Text(
                'Following',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              SizedBox(width: 5),
              FaIcon(
                FontAwesomeIcons.chevronDown,
                color: Colors.white,
                size: 20,
              ),
            ],
          ),
        ),
        Positioned(
          top: 20,
          right: 15,
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.magnifyingGlass,
                  color: Colors.white,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.camera,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10.0,
          right: 15.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                  size: 38,
                ),
              ),
              const Text(
                '100k',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.comment,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              const Text(
                '2508',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              // Share button
              IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.paperPlane,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              const Text(
                '55k',
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              // Share button
              IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.gift,
                  color: Colors.white,
                  size: 35,
                ),
              ),
              const Text(
                '199',
                style: TextStyle(color: Colors.white),
              ),

              IconButton(
                onPressed: () {},
                icon: const FaIcon(
                  FontAwesomeIcons.ellipsisVertical,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10.0,
          left: 20.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 27,
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.black,
                      foregroundImage: NetworkImage(
                        "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=600",
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(colors: [
                          Color(0xff560b6a),
                          Color(0xffef017d),
                        ])),
                    child: const Text(
                      'Follow',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              const Text(
                "Username",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5.0),
              const Text(
                'This is a sample video description.',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
