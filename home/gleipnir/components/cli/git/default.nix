{ ... }: {
  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
      user = {
        name = "vaz";
        email = "nicovalmu2003@gmail.com";
      };
    };
  };
}
