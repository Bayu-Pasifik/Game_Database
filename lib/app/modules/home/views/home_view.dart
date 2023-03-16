import 'package:flutter/material.dart';
import 'package:game_database/app/data/models/game_models.dart';
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
import 'package:game_database/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(3),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Welcome Gamer"),
              IconButton(
                  onPressed: () {
                    Get.toNamed(Routes.SEARCH);
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Action Game", style: GoogleFonts.poppins()),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOAD_MORE, arguments: "action");
                  },
                  child: Text("Load More", style: GoogleFonts.poppins()))
            ],
          ),
          ActionView(actions: controller.action),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Indie Game", style: GoogleFonts.poppins()),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOAD_MORE, arguments: "indie");
                  },
                  child: Text("Load More", style: GoogleFonts.poppins()))
            ],
          ),
          IndieView(indie: controller.indie),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Adventure Game", style: GoogleFonts.poppins()),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOAD_MORE, arguments: "adventure");
                  },
                  child: Text("Load More", style: GoogleFonts.poppins()))
            ],
          ),
          AdventureView(adventure: controller.adventure),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("RPG Game", style: GoogleFonts.poppins()),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOAD_MORE, arguments: "5");
                  },
                  child: Text("Load More", style: GoogleFonts.poppins()))
            ],
          ),
          RpgView(rpg: controller.rpg),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Strategy Game", style: GoogleFonts.poppins()),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOAD_MORE, arguments: "strategy");
                  },
                  child: Text("Load More", style: GoogleFonts.poppins()))
            ],
          ),
          StrategyView(strategy: controller.strategy),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Casual Game", style: GoogleFonts.poppins()),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOAD_MORE, arguments: "casual");
                  },
                  child: Text("Load More", style: GoogleFonts.poppins()))
            ],
          ),
          CasualView(casual: controller.casual),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Simulation Game", style: GoogleFonts.poppins()),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOAD_MORE, arguments: "simulation");
                  },
                  child: Text("Load More", style: GoogleFonts.poppins()))
            ],
          ),
          SimulationView(simulation: controller.simulation),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Puzzle Game", style: GoogleFonts.poppins()),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOAD_MORE, arguments: "puzzle");
                  },
                  child: Text("Load More", style: GoogleFonts.poppins()))
            ],
          ),
          PuzzleView(puzzle: controller.puzzle),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Arcade Game", style: GoogleFonts.poppins()),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOAD_MORE, arguments: "arcade");
                  },
                  child: Text("Load More", style: GoogleFonts.poppins()))
            ],
          ),
          ArcadeView(arcade: controller.arcade),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Platformer Game", style: GoogleFonts.poppins()),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOAD_MORE, arguments: "platformer");
                  },
                  child: Text("Load More", style: GoogleFonts.poppins()))
            ],
          ),
          PlatformerView(platformer: controller.platformer),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Racing Game", style: GoogleFonts.poppins()),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOAD_MORE, arguments: "racing");
                  },
                  child: Text("Load More", style: GoogleFonts.poppins()))
            ],
          ),
          RacingView(racing: controller.racing),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Massive Multiplayer Game", style: GoogleFonts.poppins()),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOAD_MORE, arguments: "59");
                  },
                  child: Text("Load More", style: GoogleFonts.poppins()))
            ],
          ),
          MultiPlayerView(multi: controller.mmo),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Sport Game", style: GoogleFonts.poppins()),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOAD_MORE, arguments: "sports");
                  },
                  child: Text("Load More", style: GoogleFonts.poppins()))
            ],
          ),
          SportView(sport: controller.sport),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Fighting Game", style: GoogleFonts.poppins()),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOAD_MORE, arguments: "fighting");
                  },
                  child: Text("Load More", style: GoogleFonts.poppins()))
            ],
          ),
          FightingView(fighting: controller.fighting),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Family Game", style: GoogleFonts.poppins()),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOAD_MORE, arguments: "family");
                  },
                  child: Text("Load More", style: GoogleFonts.poppins()))
            ],
          ),
          FamilyView(family: controller.family),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Board Game", style: GoogleFonts.poppins()),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOAD_MORE, arguments: "28");
                  },
                  child: Text("Load More", style: GoogleFonts.poppins()))
            ],
          ),
          BoardView(board: controller.board),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Educational Game", style: GoogleFonts.poppins()),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOAD_MORE, arguments: "34");
                  },
                  child: Text("Load More", style: GoogleFonts.poppins()))
            ],
          ),
          EducationalView(educational: controller.educational),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Card Game", style: GoogleFonts.poppins()),
              TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOAD_MORE, arguments: "card");
                  },
                  child: Text("Load More", style: GoogleFonts.poppins()))
            ],
          ),
          CardView(card: controller.card),
          const SizedBox(height: 10),
        ],
      ),
    ));
  }
}
