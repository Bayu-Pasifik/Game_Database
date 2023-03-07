import 'package:flutter/material.dart';
import 'package:game_database/app/modules/home/views/action_view.dart';
import 'package:game_database/app/modules/home/views/adventure_view.dart';
import 'package:game_database/app/modules/home/views/arcade_view.dart';
import 'package:game_database/app/modules/home/views/board_view.dart';
import 'package:game_database/app/modules/home/views/card_view.dart';
import 'package:game_database/app/modules/home/views/casual_view.dart';
import 'package:game_database/app/modules/home/views/educational_view.dart';
import 'package:game_database/app/modules/home/views/family_view.dart';
import 'package:game_database/app/modules/home/views/fighting_view.dart';
import 'package:game_database/app/modules/home/views/indie_view.dart';
import 'package:game_database/app/modules/home/views/multi_player_view.dart';
import 'package:game_database/app/modules/home/views/platformer_view.dart';
import 'package:game_database/app/modules/home/views/puzzle_view.dart';
import 'package:game_database/app/modules/home/views/racing_view.dart';
import 'package:game_database/app/modules/home/views/rpg_view.dart';
import 'package:game_database/app/modules/home/views/simulation_view.dart';
import 'package:game_database/app/modules/home/views/sport_view.dart';
import 'package:game_database/app/modules/home/views/strategy_view.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(3),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Action Game"),
                  TextButton(onPressed: () {}, child: Text("Load More"))
                ],
              ),
              ActionView(actions: controller.action),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Indie Game"),
                  TextButton(onPressed: () {}, child: Text("Load More"))
                ],
              ),
              IndieView(indie: controller.indie),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Adventure Game"),
                  TextButton(onPressed: () {}, child: Text("Load More"))
                ],
              ),
              AdventureView(adventure: controller.adventure),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("RPG Game"),
                  TextButton(onPressed: () {}, child: Text("Load More"))
                ],
              ),
              RpgView(rpg: controller.rpg),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Strategy Game"),
                  TextButton(onPressed: () {}, child: Text("Load More"))
                ],
              ),
              StrategyView(strategy: controller.strategy),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Casual Game"),
                  TextButton(onPressed: () {}, child: Text("Load More"))
                ],
              ),
              CasualView(casual: controller.casual),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Simulation Game"),
                  TextButton(onPressed: () {}, child: Text("Load More"))
                ],
              ),
              SimulationView(simulation: controller.simulation),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Puzzle Game"),
                  TextButton(onPressed: () {}, child: Text("Load More"))
                ],
              ),
              PuzzleView(puzzle: controller.puzzle),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Arcade Game"),
                  TextButton(onPressed: () {}, child: Text("Load More"))
                ],
              ),
              ArcadeView(arcade: controller.arcade),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Platformer Game"),
                  TextButton(onPressed: () {}, child: Text("Load More"))
                ],
              ),
              PlatformerView(platformer: controller.platformer),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Racing Game"),
                  TextButton(onPressed: () {}, child: Text("Load More"))
                ],
              ),
              RacingView(racing: controller.racing),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Massive Multiplayer Game"),
                  TextButton(onPressed: () {}, child: Text("Load More"))
                ],
              ),
              MultiPlayerView(multi: controller.mmo),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Sport Game"),
                  TextButton(onPressed: () {}, child: Text("Load More"))
                ],
              ),
              SportView(sport: controller.sport),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Fighting Game"),
                  TextButton(onPressed: () {}, child: Text("Load More"))
                ],
              ),
              FightingView(fighting: controller.fighting),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Family Game"),
                  TextButton(onPressed: () {}, child: Text("Load More"))
                ],
              ),
              FamilyView(family: controller.family),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Board Game"),
                  TextButton(onPressed: () {}, child: Text("Load More"))
                ],
              ),
              BoardView(board: controller.board),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Educational Game"),
                  TextButton(onPressed: () {}, child: Text("Load More"))
                ],
              ),
              EducationalView(educational: controller.educational),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Card Game"),
                  TextButton(onPressed: () {}, child: Text("Load More"))
                ],
              ),
              CardView(card: controller.card),
              const SizedBox(height: 10),
            ],
          ),
        ));
  }
}
