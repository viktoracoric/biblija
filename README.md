# biblija

Čitajte Bibliju (prijevod Kršćanske sadašnjosti, uključuje i apokrife) u terminalu.

Forkano od [https://github.com/LukeSmithxyz/kjv](https://github.com/LukeSmithxyz/kjv).


## Korištenje

    korištenje: ./biblija [zastavice] [reference...]

      -l      popis knjiga
      -W      bez prelamanja redaka
      -h      pomoć

      Tipovi referenci:
          <Knjiga>
              Individualna knjiga
          <Knjiga>:<Poglavlje>
              Individualno poglavlje neke knjige
          <Knjiga>:<Poglavlje>:<Stih>[,<Stih>]...
              Individualni stih(ovi) nekog poglavlja neke knjige
          <Knjiga>:<Poglavlje>-<Poglavlje>
              Od-do poglavlja neke knjige.
          <Knjiga>:<Poglavlje>:<Stih>-<Stih>
              Od-do stiha nekog poglavlja neke knjige.
          <Knjiga>:<Poglavlje>:<Stih>-<Poglavlje>:<Stih>
              Od stiha iz nekog poglavlja do stiha iz nekog drugog poglavlja

          /<Pojam za pretraživanje>
              Svi stihovi koji sadrže pojam za pretraživanje
          <Knjiga>/<Pojam za pretraživanje>
              Svi stihovi unutar neke knjige koji sadrže pojam za pretraživanje
          <Knjiga>:<Poglavlje>/<Pojam za pretraživanje>
              Svi stihovi unutar nekog poglavlja neke knjige koji sadrže pojam za pretraživanje

## Instalacija

    git clone https://github.com/viktoracoric/biblija.git
    cd biblija
    sudo make install

## Arch User Repository

`biblija` je korisnicima Arch Linuxa i njegovih derivata dostupna unutar Arch User Repositorya

[https://aur.archlinux.org/packages/biblija](https://aur.archlinux.org/packages/biblija)

Npr., pomoću `yay`-a bibliju može instalirati naredbom

```
yay biblija
```

ili pomoću `pamac`-a naredbom

```
pamac install biblija
```

## Licenca

Javna domena
