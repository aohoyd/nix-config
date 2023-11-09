{config, lib, ...}:
{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -x TERM xterm-256color
      set -x EDITOR hx
      set -x VISUAL code
      set -x LC_ALL en_US.UTF-8

      fish_add_path /opt/homebrew/bin /opt/homebrew/sbin /opt/homebrew/opt/coreutils/libexec/gnubin
      fish_add_path ~/go/bin ~/.krew/bin /run/current-system/sw/bin 
    '';
    shellAbbrs = {
      e = "$EDITOR";
      v = "$VISUAL";

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
    };
    shellAliases = {
      cat = "bat --paging=never";
      ls = "eza --group-directories-first";
    };
    functions = {
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
