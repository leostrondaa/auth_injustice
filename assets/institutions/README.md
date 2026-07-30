# Arquivos de cada instituicao

Cada instituicao possui uma pasta propria:

```text
assets/institutions/<id-do-pacote>/
  branding/       logos
  event_banners/  imagens prontas de eventos
  map/            arquivos do mapa 3D
```

Logos pequenos e banners comprimidos podem acompanhar o aplicativo. Mapas 3D
grandes ou atualizados com frequencia devem ficar no Storage da instituicao.

As configuracoes correspondentes ficam em
`lib/institution/packages/<id-do-pacote>/`. O restante do app acessa esses
arquivos pelo pacote institucional ativo e nunca diretamente pela pasta de
outra instituicao.
