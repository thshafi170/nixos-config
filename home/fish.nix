{
  ...
}:

{
  # Enable Fish shell
  programs.fish = {
    enable = true;
    # Useful shell aliases for common tasks
    shellAliases = {
      free = "free -m";
      nix-switch = "sudo nixos-rebuild switch";
      nix-upgrade = "sudo nixos-rebuild switch --upgrade";
      nix-clean = "sudo nix profile wipe-history --profile /nix/var/nix/profiles/system && sudo nix-collect-garbage && sudo nixos-rebuild boot";
    };
    # Custom Fish functions
    functions = {
      # Show system info on shell startup
      fish_greeting = {
        description = "Start fastfetch at launch.";
        body = "fastfetch";
      };
      # Pull all git repositories in subdirectories
      git-pull-all = {
        description = "Recursively pull all git repositories with error handling";
        body = ''
          for gitdir in (find . -name ".git" -type d)
            set repo (dirname "$gitdir")
            echo "Pulling $repo..."
            cd "$repo"

            if not git pull
              echo "Normal pull failed, trying force pull..."
              git fetch origin
              git reset --hard origin/(git rev-parse --abbrev-ref HEAD)
            end

            cd -
          end
        '';
      };
    };
  };
}
