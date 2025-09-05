import 'package:bullseye2d/bullseye2d.dart';

class HelloWorld extends App {
  late BitmapFont font;

  // Initialization Logic
  @override
  onCreate() async {
    font = resources.loadFont("fonts/roboto/Roboto-Regular.ttf", 96);
    log("MyApp :: MyApp created");
  }

  // logic called every game loop
  @override
  onUpdate() {
  }

  //drawing called every game loop
  @override
  onRender() {
    gfx.clear(0, 0, 0);
    gfx.drawText(font, "One hundred & eighty!", x: width / 2, y: height / 2, alignX: 0.5, alignY: 0.5);
  }
}

main() {
  HelloWorld();
}
