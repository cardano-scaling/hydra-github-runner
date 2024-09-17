let

  earthrealm = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEMuBv9vXsKsOsjS7B6zMOpuLw+gGGHR6hADuTeiNfKO lc@earthrealm";

  noon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIATz/Jv+AnBft+9Q01UF07OydvgTTaTdCa+nMqabkUNl";

  aws = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID0sPEGJz6opbVgbjq82PQawphIGBzJjWNwJ3VGQFpMr root@ip-172-31-6-250.eu-west-3.compute.internal";

  systems = [aws];

  users = [earthrealm noon];
in
{

  "hydra.tokenFile.age".publicKeys = users ++ systems;

}
