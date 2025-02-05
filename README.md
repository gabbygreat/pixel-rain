# 🌧️ Pixel Rain Painter 🎨

Welcome to **Pixel Rain Painter**! This is a fun and visually stunning Flutter app that makes pixels "rain down" to form an image. Watch as the pixels fall randomly from the top of the screen and assemble into a beautiful picture. 🌈✨

---

## 🎥 Demo

Check out the demo below to see the magic in action:

![Pixel Rain Painter Demo](assets/images/demo.gif){width=180 height=360}

---

## 🚀 Features

- **Pixel Rain Effect**: Watch pixels fall from the top of the screen and form an image. 🌧️🖼️
- **Smooth Animations**: Enjoy buttery-smooth animations powered by Flutter's `AnimationController`. 🎬
- **Dynamic Reload**: Click the shuffle button to reverse the animation or load a new image. 🔄🎲

---

## 🛠️ How It Works

The app uses Flutter's `CustomPaint` to draw each pixel individually. Here's the breakdown:

1. **Pixel Data**: The image is loaded and converted into pixel data. 🖼️➡️🔢
2. **Random Start Positions**: Each pixel starts at a random position at the top of the screen. 🎲⬆️
3. **Animation**: Pixels "rain down" to their final positions using a smooth animation. 🌧️➡️🎯
4. **Reverse Animation**: Click the shuffle button to reverse the animation or load a new image. 🔄✨

---

## 🧑‍💻 Installation

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/gabbygreat/pixel-rain.git
   cd pixel-rain
   ```

2. **Add Your Images**:
   - Place your images in the `assets/images/` folder.
   - Update the `pubspec.yaml` file to include the assets:
     ```yaml
     flutter:
       assets:
         - assets/images/your_image.png
     ```

3. **Run the App**:
   ```bash
   flutter run
   ```

---

## 🙏 Credits

- **Flutter**: For making UI development a breeze. 🐦
- **You**: For checking out this project! ❤️

---

## 📄 License

This project is licensed under the MIT License. Feel free to use, modify, and share it! 📜

---

## 🎉 Enjoy!

Have fun playing with the Pixel Rain Painter! If you like it, give it a ⭐ on GitHub and share it with your friends. Happy coding! 🚀🎨

---

Made with 💙 by GabbyGreat