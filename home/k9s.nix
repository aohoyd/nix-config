{pkgs, config, lib, ...}:
{
  programs.k9s = {
    enable = true;
  };
  home.file.k9s = {
    target = "Library/Application Support/k9s/plugin.yml";
    text = ''
      plugin:
        #get all resources in a namespace using the krew get-all plugin
        get-all-namespace:
          shortCut: g
          confirm: false
          description: get-all
          scopes:
          - namespaces
          command: sh
          background: false
          args:
          - -c
          - "kubectl get-all -n $NAME | less"
        get-all-other:
          shortCut: g
          confirm: false
          description: get-all
          scopes:
          - all
          command: sh
          background: false
          args:
          - -c
          - "kubectl get-all -n $NAMESPACE | less"
        # Sends logs over to jq for processing. This leverages kubectl plugin kubectl-jq.
        jqlogs:
          shortCut: Ctrl-J
          confirm: false
          description: "Logs (jq)"
          scopes:
            - po
          command: kubectl
          background: false
          args:
            - jq
            - $NAME
            - $NAMESPACE
            - $CONTEXT
        # Sends logs over to stern for processing.
        sternlogs:
          shortCut: Ctrl-L
          confirm: false
          description: "Logs (stern)"
          scopes:
            - po
          command: bash
          background: false
          args:
            - -c
            - '"$@" | lnav -q'
            - dummy-arg
            - kubectl
            - logs
            - -f
            - -n
            - $NAMESPACE
            - $NAME
        # watch events
        watch-events:
          shortCut: Shift-E
          confirm: false
          description: Get Events
          scopes:
          - all
          command: sh
          background: false
          args:
          - -c
          - "viddy -d -n 5 kubectl get events --namespace $NAMESPACE --field-selector involvedObject.name=$NAME"
    '';
  };
}
