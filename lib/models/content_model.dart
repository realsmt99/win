class UnbordingContent {
  final String image;
  final String title;
  final String description;

  UnbordingContent(
      {required this.image, required this.title, required this.description});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Welcome aboard!',
      image: 'assets/welcome.png',
      description: "Get ready to explore the world of seamless connectivity."
          "We're thrilled to have you as part of our internet family."
          "Let's get started! "),
  UnbordingContent(
      title: 'Connect Your Devices',
      image: 'assets/connect.png',
      description:
          "Connect all your devices to our network effortlessly.Stream,"
          "browse, game, and work without any interruptions."),
  UnbordingContent(
      title: 'Get 24/7 Support',
      image: 'assets/support.jpg',
      description:
          "Our dedicated support team is here to assist you round the clock."
          "Have questions or need assistance? Don't hesitate to reach out!"),
];
