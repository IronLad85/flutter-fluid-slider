# Flutter - Fluid Slider

### If this project has helped you out, please support us with a star. :star2:

## Preview

![Alt Text](preview.gif)


<style type="text/css">
    img{ border:1px solid black }
</style>

## Getting Started

```yamlgit
dependencies:
	...
	fluid_slider: 1.0.0
```

## Usage Example

Adding the widget

```dart
import 'package:fluid_slider/fluid_slider.dart';

FluidSlider(
  min: 0,
  max: 100,
  sliderColor: Colors.indigo,
  textColor: Colors.white,
  onValue: (value) => {},
  onSlide: (value) => {},
)
```

## Slider Properties

| Property            | Type          | Required | Default Value |
| ------------------- | ------------- | -------- | ------------- |
| min                 | int           | Yes      | --            |
| max                 | int           | Yes      | --            |
| sliderColor         | Color         | No       | Colors.indigo |
| textColor           | Color         | No       | Colors.indigo |
| onValue             | Function      | Yes      | --            |
| onSlide             | Function      | No       | --            |
