{config, lib, ...}:
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      format = lib.concatStrings [
        "$directory"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_metrics"
        "$git_status"
        "$c"
        "$golang"
        "$helm"
        "$kotlin"
        "$lua"
        "$nim"
        "$pulumi"
        "$python"
        "$rust"
        "$terraform"
        "$vagrant"
        "$zig"
        "$buf"
        "$nix_shell"
        "$memory_usage"
        "$env_var"
        "$custom"
        "$sudo"
        "$kubernetes"
        "$cmd_duration"
        "$line_break"
        "$jobs"
        "$battery"
        "$time"
        "$status"
        "$container"
        "$shell"
        "$character"
      ];
      # right_format = lib.concatStrings [
      #   "$cmd_duration"
      #   "$kubernetes"
      # ];
      scan_timeout = 30;
      command_timeout = 500;
      add_newline = true;

      golang = {
        format = "[$symbol($version )]($style)";
        symbol = " ";
        disabled = false;
      };

      helm = {
        format = "[$symbol($version )]($style)";
        symbol = "⎈ ";
        disabled = false;
      };

      kubernetes = {
        symbol = "⎈ ";
        format = "[$symbol$context( \($namespace\)) ]($style)";
        style = "blue bold";
        disabled = false;
      };

      rust = {
        format = "[$symbol($version )]($style)";
        symbol = " ";
        disabled = false;
      };

      python = {
        format = "[$symbol($version )]($style)";
        symbol = "🐍 ";
        disabled = false;
      };
    };
  };
}
