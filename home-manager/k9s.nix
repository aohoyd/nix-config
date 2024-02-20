{pkgs, config, lib, ...}:
{
  programs.k9s = {
    enable = true;
    plugin = {
      get-all-namespace = {
        shortCut = "g";
        confirm = false;
        description = "get-all";
        scopes = [ "namespaces" ];
        command = "sh";
        background = false;
        args = [
          "-c"
          "kubectl get-all -n $NAME | less"
        ];
      };
      get-all-other = {
        shortCut = "g";
        confirm = false;
        description = "get-all";
        scopes = [ "all" ];
        command = "sh";
        background = false;
        args = [
          "-c"
          "kubectl get-all -n $NAMESPACE | less"
        ];
      };
      jqlogs = {
        shortCut = "Ctrl-J";
        confirm = false;
        description = "Logs (jq)";
        scopes = [ "po" ];
        command = "kubectl";
        background = false;
        args = [
          "jq"
          "$NAME"
          "$NAMESPACE"
          "$CONTEXT"
        ];
      };
      sternlogs = {
        shortCut = "Ctrl-L";
        confirm = false;
        description = "Logs (stern)";
        scopes = [ "po" ];
        command = "bash";
        background = false;
        args = [
          "-c"
          "\"$@\" | tspin -f"
          "dummy-arg"
          "stern"
          "$NAME"
          "-n"
          "$NAMESPACE"
        ];
      };
      sternlogsContainers = {
        shortCut = "Ctrl-L";
        confirm = false;
        description = "Logs (stern)";
        scopes = [ "containers" ];
        command = "bash";
        background = false;
        args = [
          "-c"
          "\"$@\" | tspin -f"
          "dummy-arg"
          "stern"
          "$POD"
          "-n"
          "$NAMESPACE"
          "-c"
          "$NAME"
        ];
      };
      watch-events = {
        shortCut = "Shift-E";
        confirm = false;
        description = "Get Events";
        scopes = [ "all" ];
        command = "sh";
        background = false;
        args = [
          "-c"
          "\"viddy -d -n 5 kubectl get events --namespace $NAMESPACE --field-selector involvedObject.name=$NAME\""
        ];
      };
    };
    settings.k9s.ui = {
      headless = true;
      logoless = true;
      crumbsless = true;
    };
  };
}
