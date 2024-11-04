{config, lib, pkgs, ...}:
{

  xdg.configFile = {
    "elvish/rc.elv".text = ''
      set-env TERM xterm-256color
      set-env GIT_EDITOR nvim
      set-env EDITOR nvim
      set-env VISUAL "neovide --no-tabs"
      set-env LC_ALL en_US.UTF-8
      set-env K9S_CONFIG_DIR ~/.config/k9s

      # run starship
      eval (${pkgs.starship}/bin/starship init elvish | slurp)
    '';
    "elvish/lib/aliases.elv".text = ''
      {
        var alias = {|&comp=$true name @cmd|
          eval (print 'edit:add-var '$name'~ {|@_args| ' $@cmd ' $@_args}')
          if (and $comp (has-key $edit:completion:arg-completer $cmd[0])) {
            eval (print 'set edit:completion:arg-completer['$name'] = {|@args| $edit:completion:arg-completer['$cmd[0]'] ' $@cmd ' (all $args) }')
          }
        }
        alias e nvim
        alias v neovide
        alias watch viddy
        alias gg git get
        alias gt git tag
        alias glol git log --graph --all --pretty='format:%C(auto)%h %C(cyan)%ar %C(auto)(%G?) %C(auto)%d %C(magenta)%an %C(auto)%s'
        alias gs git stack
        alias gsy git sync
        alias gne git next
        alias gpr git prev
        alias gam git amend
        alias gfp git fetch -p
        alias gi gitui
        alias k kubectl
        alias ka kubectl apply --recursive -f
        alias kex kubectl exec -i -t
        alias ked kubectl edit
        alias klo kubectl logs -f
        alias klop kubectl logs -f -p
        alias kp kubectl proxy
        alias kpf kubectl port-forward
        alias kg kubectl get
        alias kd kubectl describe
        alias krm kubectl delete
        alias krun kubectl run --rm --restart=Never --image-pull-policy=IfNotPresent -i -t
        alias kgpo kubectl get pods
        alias kdpo kubectl describe pods
        alias krmpo kubectl delete pods
        alias kgdep kubectl get deployment
        alias kddep kubectl describe deployment
        alias krmdep kubectl delete deployment
        alias kgsvc kubectl get service
        alias kdsvc kubectl describe service
        alias krmsvc kubectl delete service
        alias kging kubectl get ingress
        alias kding kubectl describe ingress
        alias krming kubectl delete ingress
        alias kgcm kubectl get configmap
        alias kdcm kubectl describe configmap
        alias krmcm kubectl delete configmap
        alias kgsec kubectl get secret
        alias kdsec kubectl describe secret
        alias krmsec kubectl delete secret
        alias kgno kubectl get nodes
        alias kdno kubectl describe nodes
        alias kgns kubectl get namespaces
        alias kdns kubectl describe namespaces
        alias krmns kubectl delete namespaces
        alias kgoyaml kubectl get -o=yaml
        alias kgpooyaml kubectl get pods -o=yaml
        alias kgdepoyaml kubectl get deployment -o=yaml
        alias kgsvcoyaml kubectl get service -o=yaml
        alias kgingoyaml kubectl get ingress -o=yaml
        alias kgcmoyaml kubectl get configmap -o=yaml
        alias kgsecoyaml kubectl get secret -o=yaml
        alias kgnooyaml kubectl get nodes -o=yaml
        alias kgnsoyaml kubectl get namespaces -o=yaml
        alias kgowide kubectl get -o=wide
        alias kgpoowide kubectl get pods -o=wide
        alias kgdepowide kubectl get deployment -o=wide
        alias kgsvcowide kubectl get service -o=wide
        alias kgingowide kubectl get ingress -o=wide
        alias kgcmowide kubectl get configmap -o=wide
        alias kgsecowide kubectl get secret -o=wide
        alias kgnoowide kubectl get nodes -o=wide
        alias kgnsowide kubectl get namespaces -o=wide
        alias kgojson kubectl get -o=json
        alias kgpoojson kubectl get pods -o=json
        alias kgdepojson kubectl get deployment -o=json
        alias kgsvcojson kubectl get service -o=json
        alias kgingojson kubectl get ingress -o=json
        alias kgcmojson kubectl get configmap -o=json
        alias kgsecojson kubectl get secret -o=json
        alias kgnoojson kubectl get nodes -o=json
        alias kgnsojson kubectl get namespaces -o=json
        alias kgojsonf kubectl get -o=json --recursive -f
        alias kn kubectl neat
        alias "9" k9s
        alias ldo lazydocker
        alias t tig
        alias ts tig status
        alias b br
      }
    '';
  };
#  programs.fish = {
#    enable = true;
#    interactiveShellInit = ''
#
#      fish_add_path /opt/homebrew/bin /opt/homebrew/sbin /opt/homebrew/opt/coreutils/libexec/gnubin /Applications/neovide.app/Contents/MacOS
#      fish_add_path ~/go/bin ~/.krew/bin /run/current-system/sw/bin 
#
#      # run starship
#      eval (${pkgs.starship}/bin/starship init fish)
#
#      set _fishprompt_aid "fish"$fish_pid
#      set _fishprompt_started 0
#      # empty if running; or a numeric exit code; or CANCEL
#      set _fishprompt_postexec ""
#
#      functions -c fish_prompt _fishprompt_saved_prompt
#      set _fishprompt_prompt_count 0
#      set _fishprompt_disp_count 0
#      function _fishprompt_start --on-event fish_prompt
#          set _fishprompt_prompt_count (math $_fishprompt_prompt_count + 1)
#          # don't use post-exec, because it is called *before* omitted-newline output
#          if [ -n "$_fishprompt_postexec" ]
#              printf "\033]133;D;%s;aid=%s\007" "$_fishprompt_postexec" $_fishprompt_aid
#          end
#          printf "\033]133;A;aid=%s;cl=m\007" $_fishprompt_aid
#      end
#
#      function fish_prompt
#          set _fishprompt_disp_count (math $_fishprompt_disp_count + 1)
#          printf "\033]133;P;k=i\007%b\033]133;B\007" (string join "\n" (_fishprompt_saved_prompt))
#          set _fishprompt_started 1
#          set _fishprompt_postexec ""
#      end
#
#      function _fishprompt_preexec --on-event fish_preexec
#          if [ "$_fishprompt_started" = 1 ]
#              printf "\033]133;C;\007"
#          end
#          set _fishprompt_started 0
#      end
#
#      function _fishprompt_postexec --on-event fish_postexec
#          set _fishprompt_postexec $status
#          _fishprompt_start
#      end
#
#      function __fishprompt_cancel --on-event fish_cancel
#          set _fishprompt_postexec CANCEL
#          _fishprompt_start
#      end
#
#      function _fishprompt_exit --on-process %self
#          if [ "$_fishprompt_started" = 1 ]
#              printf "\033]133;Z;aid=%s\007" $_fishprompt_aid
#          end
#      end
#
#      if functions -q fish_right_prompt
#          functions -c fish_right_prompt _fishprompt_saved_right_prompt
#          function fish_right_prompt
#              printf "\033]133;P;k=r\007%b\033]133;B\007" (string join "\n" (_fishprompt_saved_right_prompt))
#          end
#      end
#    '';
#    shellAbbrs = {
#      e = "nvim";
#      v = "neovide";
#
#      watch = "viddy";
#
#      gg = "git get";
#      gt = "git tag";
#      glol = "git log --graph --all --pretty='format:%C(auto)%h %C(cyan)%ar %C(auto)(%G?) %C(auto)%d %C(magenta)%an %C(auto)%s'";
#      gs = "git stack";
#      gsy = "git sync";
#      gne = "git next";
#      gpr = "git prev";
#      gam = "git amend";
#      gfp = "git fetch -p";
#      gi = "gitui";
#
#      k = "kubectl";
#      ka = "kubectl apply --recursive -f";
#      kex = "kubectl exec -i -t";
#      ked = "kubectl edit";
#      klo = "kubectl logs -f";
#      klop = "kubectl logs -f -p";
#      kp = "kubectl proxy";
#      kpf = "kubectl port-forward";
#      kg = "kubectl get";
#      kd = "kubectl describe";
#      krm = "kubectl delete";
#      krun = "kubectl run --rm --restart=Never --image-pull-policy=IfNotPresent -i -t";
#      kgpo = "kubectl get pods";
#      kdpo = "kubectl describe pods";
#      krmpo = "kubectl delete pods";
#      kgdep = "kubectl get deployment";
#      kddep = "kubectl describe deployment";
#      krmdep = "kubectl delete deployment";
#      kgsvc = "kubectl get service";
#      kdsvc = "kubectl describe service";
#      krmsvc = "kubectl delete service";
#      kging = "kubectl get ingress";
#      kding = "kubectl describe ingress";
#      krming = "kubectl delete ingress";
#      kgcm = "kubectl get configmap";
#      kdcm = "kubectl describe configmap";
#      krmcm = "kubectl delete configmap";
#      kgsec = "kubectl get secret";
#      kdsec = "kubectl describe secret";
#      krmsec = "kubectl delete secret";
#      kgno = "kubectl get nodes";
#      kdno = "kubectl describe nodes";
#      kgns = "kubectl get namespaces";
#      kdns = "kubectl describe namespaces";
#      krmns = "kubectl delete namespaces";
#      kgoyaml = "kubectl get -o=yaml";
#      kgpooyaml = "kubectl get pods -o=yaml";
#      kgdepoyaml = "kubectl get deployment -o=yaml";
#      kgsvcoyaml = "kubectl get service -o=yaml";
#      kgingoyaml = "kubectl get ingress -o=yaml";
#      kgcmoyaml = "kubectl get configmap -o=yaml";
#      kgsecoyaml = "kubectl get secret -o=yaml";
#      kgnooyaml = "kubectl get nodes -o=yaml";
#      kgnsoyaml = "kubectl get namespaces -o=yaml";
#      kgowide = "kubectl get -o=wide";
#      kgpoowide = "kubectl get pods -o=wide";
#      kgdepowide = "kubectl get deployment -o=wide";
#      kgsvcowide = "kubectl get service -o=wide";
#      kgingowide = "kubectl get ingress -o=wide";
#      kgcmowide = "kubectl get configmap -o=wide";
#      kgsecowide = "kubectl get secret -o=wide";
#      kgnoowide = "kubectl get nodes -o=wide";
#      kgnsowide = "kubectl get namespaces -o=wide";
#      kgojson = "kubectl get -o=json";
#      kgpoojson = "kubectl get pods -o=json";
#      kgdepojson = "kubectl get deployment -o=json";
#      kgsvcojson = "kubectl get service -o=json";
#      kgingojson = "kubectl get ingress -o=json";
#      kgcmojson = "kubectl get configmap -o=json";
#      kgsecojson = "kubectl get secret -o=json";
#      kgnoojson = "kubectl get nodes -o=json";
#      kgnsojson = "kubectl get namespaces -o=json";
#      kgojsonf = "kubectl get -o=json --recursive -f";
#      kn = "kubectl neat";
#
#      "9" = "k9s";
#
#      ldo = "lazydocker";
#      t = "tig";
#      ts = "tig status";
#
#      b = "br";
#    };
#    shellAliases = {
#      cat = "bat --theme='Monokai Extended' --paging=never";
#      ls = "eza --group-directories-first";
#    };
#    functions = {
#      ny = ''
#        argparse e/expand= -- $argv
#        or return
#        set -l cmd "cat | from yaml"
#        if count $argv > /dev/null
#          set cmd "$cmd | $argv[1]"
#        end
#        if set -ql _flag_expand
#          set cmd "$cmd | table --expand --expand-deep $_flag_expand"
#        end
#        nu -c $cmd
#      '';
#
#      nj = ''
#        argparse e/expand= -- $argv
#        or return
#        set -l cmd "cat | from json"
#        if count $argv > /dev/null
#          set cmd "$cmd | $argv[1]"
#        end
#        if set -ql _flag_expand
#          set cmd "$cmd | table --expand --expand-deep $_flag_expand"
#        end
#        nu -c $cmd
#      '';
#
#      kv = {
#        body = "kubectl view-secret $argv";
#        wraps = "kubectl get secret";
#      };
#      
#      kva = {
#        body = "kubectl view-secret --all $argv";
#        wraps = "kubectl get secret";
#      };
#
#      ks = {
#        body = "kubeswitch $argv";
#        wraps = "kubeswitch";
#      };
#
#      kns = {
#        body = "kubeswitch namespace $argv";
#        wraps = "kubeswitch namespace";
#      };
#    };
#  };
}
