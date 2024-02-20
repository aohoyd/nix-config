{pkgs, config, lib, ...}:
{
  home.file.kubeswitch = {
    target = ".kube/switch-config.yaml";
    text = ''
      kind: SwitchConfig
      version: v1alpha1
      # refreshIndexAfter: 1h
      kubeconfigStores:
        - kind: filesystem
          id: clusters
          kubeconfigName: "*config"
          paths:
          - ~/.kube/configs/ 
    '';
  };
}
