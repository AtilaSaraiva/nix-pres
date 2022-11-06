with (import <nixpkgs> {});

dockerTools.streamLayeredImage {
  name = "saig";
  tag = "latest";
  contents = [
    gcc
    bash
  ];
  config = {
    Cmd = [
      "bash"
    ];
  };
}
