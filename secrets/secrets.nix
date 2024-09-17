let

  earthrealm = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEMuBv9vXsKsOsjS7B6zMOpuLw+gGGHR6hADuTeiNfKO lc@earthrealm";

  aws = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIc2fso0/cVCP+u0TgAiuuHqce1msPqpaDHK11OWsdKN root@ip-172-31-46-187.eu-west-3.compute.internal";

  systems = [aws];

  users = [earthrealm];
in
{

  "hydra.tokenFile.age".publicKeys = users ++ systems;

}
