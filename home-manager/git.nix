{config, ...}:
{
  programs.git = {
    enable = true;
    delta = {
      enable = true;
      options = {
        features = "decorations";
        interactive = { keep-plus-minus-markers = false; };
        decorations = {
          commit-decoration-style = "blue ol";
          commit-style = "raw";
          file-style = "omit";
          hunk-header-decoration-style = "blue box";
          hunk-header-file-style = "red";
          hunk-header-line-number-style = "#067a00";
          hunk-header-style = "file line-number syntax";
        };
      };
    };
    aliases = {
      next = "stack next";
      prev = "stack previous";
      reword = "stack reword";
      amend = "stack amend";
      sync = "stack sync";
      run = "stack run";
    };
    extraConfig = {
      core.editor = "$EDITOR";
      gitget = { root = "${config.home.homeDirectory}/Git"; };
      stack.protected-branch = "main";
      filter."lfs" = {
        clean = "git-lfs clean -- %f";
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
      };
      mergetool.smerge = {
        cmd = "smerge mergetool \"$BASE\" \"$LOCAL\" \"$REMOTE\" -o \"$MERGED\"";
        trustExitCode = true;
      };
      merge.tool = "smerge";
    };
  };
}
