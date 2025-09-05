import 'package:bullseye2d/bullseye2d.dart';

class Model {
  int _counter;

  Model() : _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
  }
}

abstract interface class ViewObserver {
  void onUpdate(bool wasMouseJustClicked);

  void onRender();
}

class View {
  late Bullseye2DView _bullseye2dView;

  void start(ViewObserver observer) {
    _bullseye2dView = Bullseye2DView(observer); // Starts game loop
  }

  void showCounter(int counter) {
    _bullseye2dView.showCounter(counter);
  }

  void clearScreen() {
    _bullseye2dView.clearScreen();
  }

  void showMouseCoords() {
    _bullseye2dView.showMouseCoords();
  }
}

class Bullseye2DView extends App {
  late BitmapFont _font;
  final ViewObserver _observer;

  Bullseye2DView(this._observer) : super();

  @override
  onCreate() {
    _font = resources.loadFont("fonts/roboto/Roboto-Regular.ttf", 96);
    log("MyApp :: MyApp created");
  }

  @override
  onUpdate() {
    _observer.onUpdate(mouse.mouseHit(MouseButton.Left));
  }

  @override
  onRender() {
    _observer.onRender();
  }

  void clearScreen() {
    gfx.clear(0, 0, 0);
  }

  void showCounter(int counter) {
    gfx.drawText(
      _font,
      "$counter",
      x: width / 2,
      y: height / 2,
      alignX: 0.5,
      alignY: 0.5,
    );
  }

  void showMouseCoords() {
    gfx.drawText(_font, "(${mouse.x}, ${mouse.y})", x: 0, y: 0);
  }
}

class Controller implements ViewObserver {
  final Model _model;
  final View _view;

  Controller(this._model, this._view);

  @override
  void onUpdate(bool wasMouseJustClicked) {
    if (wasMouseJustClicked) {
      _model.increment();
    }
  }

  @override
  void onRender() {
    var counter = _model.counter;

    _view.clearScreen();
    _view.showCounter(counter);
  }

  void start() {
    _view.start(this);
  }
}

void main() {
  Model model = Model();
  View view = View();
  Controller controller = Controller(model, view);

  controller.start();
}

