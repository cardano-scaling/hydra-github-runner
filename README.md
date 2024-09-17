# hydra-github-runner

`github-runner` NixOS system for hydra

## Deploying

```
nix run .#apps.nixinate.parasol
```

## Changing Host

If you need to redeploy the VM, ssh to the new host and

```
cat /etc/ssh/ssh_host_ed25519_key.pub
```

Take that value and put it in the `aws` value in `secrets/secrets.nix`.

Then

```
cd secrets.nix
nix run github:ryantm/agenix -- -e hydra.tokenFile.age
```

Grab a new runner token from the github project settings and rekey.

Now redeploy.
