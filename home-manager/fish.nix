{config, lib, pkgs, ...}:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -x TERM xterm-256color
      set -x GIT_EDITOR hx
      set -x EDITOR hx
      set -x VISUAL zed
      set -x LC_ALL en_US.UTF-8
      set -x K9S_CONFIG_DIR ~/.config/k9s
      
      set -x FZF_DEFAULT_OPTS \
          "--border=none" \
          "--color=fg:-1,fg+:#d0d0d0,bg:-1,bg+:#262626" \
          "--color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00" \
          "--color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf" \
          "--color=border:#262626,label:#aeaeae,query:#d9d9d9" \
          "--preview-window=\"border-rounded\"" \
          "--prompt=\"> \"" \
          "--marker=\">\"" \
          "--pointer=\"◆\"" \
          "--separator=\"\"" \
          "--scrollbar=\"│\""
      set -x FZF_FIND_FILE_OPTS \
          "--preview \"bat -n --color=always {}\""

      fish_add_path /opt/homebrew/bin /opt/homebrew/sbin /opt/homebrew/opt/coreutils/libexec/gnubin ~/go/bin ~/.krew/bin /run/current-system/sw/bin 

      # run starship
      eval (${pkgs.starship}/bin/starship init fish)
    '';
    shellAbbrs = {
      e = "hx";
      v = "zed";

      watch = "viddy";

      gg = "git get";
      gt = "git tag";
      glol = "git log --graph --all --pretty='format:%C(auto)%h %C(cyan)%ar %C(auto)(%G?) %C(auto)%d %C(magenta)%an %C(auto)%s'";
      gs = "git stack";
      gsy = "git sync";
      gne = "git next";
      gpr = "git prev";
      gam = "git amend";
      gfp = "git fetch -p";
      lgi = "lazygit";

      k = "kubectl";
      ka = "kubectl apply --recursive -f";
      kex = "kubectl exec -i -t";
      ked = "kubectl edit";
      klo = "kubectl logs -f";
      klop = "kubectl logs -f -p";
      kp = "kubectl proxy";
      kpf = "kubectl port-forward";
      kg = "kubectl get";
      kd = "kubectl describe";
      krm = "kubectl delete";
      krun = "kubectl run --rm --restart=Never --image-pull-policy=IfNotPresent -i -t";
      kgpo = "kubectl get pods";
      kdpo = "kubectl describe pods";
      krmpo = "kubectl delete pods";
      kgdep = "kubectl get deployment";
      kddep = "kubectl describe deployment";
      krmdep = "kubectl delete deployment";
      kgsvc = "kubectl get service";
      kdsvc = "kubectl describe service";
      krmsvc = "kubectl delete service";
      kging = "kubectl get ingress";
      kding = "kubectl describe ingress";
      krming = "kubectl delete ingress";
      kgcm = "kubectl get configmap";
      kdcm = "kubectl describe configmap";
      krmcm = "kubectl delete configmap";
      kgsec = "kubectl get secret";
      kdsec = "kubectl describe secret";
      krmsec = "kubectl delete secret";
      kgno = "kubectl get nodes";
      kdno = "kubectl describe nodes";
      kgns = "kubectl get namespaces";
      kdns = "kubectl describe namespaces";
      krmns = "kubectl delete namespaces";
      kgoyaml = "kubectl get -o=yaml";
      kgpooyaml = "kubectl get pods -o=yaml";
      kgdepoyaml = "kubectl get deployment -o=yaml";
      kgsvcoyaml = "kubectl get service -o=yaml";
      kgingoyaml = "kubectl get ingress -o=yaml";
      kgcmoyaml = "kubectl get configmap -o=yaml";
      kgsecoyaml = "kubectl get secret -o=yaml";
      kgnooyaml = "kubectl get nodes -o=yaml";
      kgnsoyaml = "kubectl get namespaces -o=yaml";
      kgowide = "kubectl get -o=wide";
      kgpoowide = "kubectl get pods -o=wide";
      kgdepowide = "kubectl get deployment -o=wide";
      kgsvcowide = "kubectl get service -o=wide";
      kgingowide = "kubectl get ingress -o=wide";
      kgcmowide = "kubectl get configmap -o=wide";
      kgsecowide = "kubectl get secret -o=wide";
      kgnoowide = "kubectl get nodes -o=wide";
      kgnsowide = "kubectl get namespaces -o=wide";
      kgojson = "kubectl get -o=json";
      kgpoojson = "kubectl get pods -o=json";
      kgdepojson = "kubectl get deployment -o=json";
      kgsvcojson = "kubectl get service -o=json";
      kgingojson = "kubectl get ingress -o=json";
      kgcmojson = "kubectl get configmap -o=json";
      kgsecojson = "kubectl get secret -o=json";
      kgnoojson = "kubectl get nodes -o=json";
      kgnsojson = "kubectl get namespaces -o=json";
      kgojsonf = "kubectl get -o=json --recursive -f";
      kn = "kubectl neat";

      "9" = "k9s";

      ldo = "lazydocker";
      t = "tig";
      ts = "tig status";

      b = "br";
    };
    shellAliases = {
      cat = "bat --theme='Monokai Extended' --paging=never";
      ls = "eza --group-directories-first";
    };
    functions = {
      __fzf_rg = ''
        rm -f /tmp/rg-fzf-{r,f}
        set -l RG_PREFIX "rg --column --line-number --no-heading --color=always --smart-case "
        fzf --ansi --disabled --query "$argv" \
            --bind "start:reload:$RG_PREFIX {q}" \
            --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
            --bind 'ctrl-t:transform:string match -q -- "*fzf*" $FZF_PROMPT &&
              echo "rebind(change)+change-prompt(1. ripgrep> )+disable-search+transform-query:echo \{q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r" ||
              echo "unbind(change)+change-prompt(2. fzf> )+enable-search+transform-query:echo \{q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f"' \
            --prompt '1. ripgrep> ' \
            --delimiter : \
            --header 'CTRL-T: Switch between ripgrep/fzf' \
            --preview 'bat --color=always {1} --highlight-line {2}' \
            --bind 'enter:become($EDITOR {1} +{2})'
      '';
      
      y = ''
      	set tmp (mktemp -t "yazi-cwd.XXXXXX")
      	yazi $argv --cwd-file="$tmp"
      	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
      		builtin cd -- "$cwd"
      	end
      	rm -f -- "$tmp"
      '';
      
      nix-search = ''
        nix-env -qaP $argv
      '';
      
      nix-install = ''
        nix-env -iA nixpkgs.$argv[1]
      '';
      
      ny = ''
        argparse e/expand= -- $argv
        or return
        set -l cmd "cat | from yaml"
        if count $argv > /dev/null
          set cmd "$cmd | $argv[1]"
        end
        if set -ql _flag_expand
          set cmd "$cmd | table --expand --expand-deep $_flag_expand"
        end
        nu -c $cmd
      '';

      nj = ''
        argparse e/expand= -- $argv
        or return
        set -l cmd "cat | from json"
        if count $argv > /dev/null
          set cmd "$cmd | $argv[1]"
        end
        if set -ql _flag_expand
          set cmd "$cmd | table --expand --expand-deep $_flag_expand"
        end
        nu -c $cmd
      '';

      kv = {
        body = "kubectl view-secret $argv";
        wraps = "kubectl get secret";
      };
      
      kva = {
        body = "kubectl view-secret --all $argv";
        wraps = "kubectl get secret";
      };

      ks = {
        body = "kubeswitch $argv";
        wraps = "kubeswitch";
      };

      kns = {
        body = "kubeswitch namespace $argv";
        wraps = "kubeswitch namespace";
      };
    };
  };
}
