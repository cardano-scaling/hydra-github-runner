let

  earthrealm = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEMuBv9vXsKsOsjS7B6zMOpuLw+gGGHR6hADuTeiNfKO lc@earthrealm";

  noon = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIATz/Jv+AnBft+9Q01UF07OydvgTTaTdCa+nMqabkUNl";

  aws = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEetyTzugs3pA7jjzaPn31H28dAVIpnkqcq/R9jKrJS6 root@ip-172-31-9-242.eu-west-3.compute.internal";

  systems = [aws];

  users = [earthrealm noon];
in
{

  "hydra.tokenFile.age".publicKeys = users ++ systems;

}
