# WhereIF

## Comece o backend aqui

1. Implemente os contratos `I...Service` dentro do `data` de cada setor.
2. Ligue as implementacoes em `lib/core/di/backend_dependency_bindings.dart`.
3. Mude o `runtime` do pacote institucional somente quando todos os adaptadores
   daquele modo estiverem prontos.

Hoje, eventos, notificacoes, horas e usuarios usam o backend de demonstracao.
Login, verificacao de e-mail, redefinicao e troca de credenciais usam
`Unconfigured...`: recusam operacoes de proposito e nunca fingem sucesso.

## Onde fica cada assunto

```text
lib/authentication/data/        login, sessao e verificacao
lib/account/data/               perfil da conta
lib/events/data/                eventos e imagens
lib/notifications/data/         feed e comunicados
lib/complementary_hours/data/   registros pessoais e horas
lib/user_management/data/       usuarios e cargos
lib/settings/data/              senha e e-mail
```

Dentro de cada `data`:
- `services/`: conversa diretamente com Firebase, Storage ou API.
- `repositories/`: fornece esses dados para as regras do app.
- `mappers/`: converte documentos do banco em models Dart.

As telas e ViewModels nao acessam Firebase diretamente. Erros retornam uma chave
de l10n, nunca a mensagem crua do servidor.

## Instituicao

`lib/institution/` nao e banco nem backend. Ela descreve o campus ativo: nome,
logos, cores, idiomas, categorias, meta de horas, mapa e projeto Firebase.

## Configuracao Firebase

Os arquivos gerados do Firebase nao ficam no Git. Em uma maquina nova, execute
`flutterfire configure` para o projeto indicado pelo pacote institucional.

Operacoes confiaveis ficam fora de `lib`, por exemplo:
```text
firebase/functions/             cargos e operacoes administrativas
firebase/firestore.rules        permissoes do banco
firebase/storage.rules          permissoes das imagens
firebase/firestore.indexes.json indices das consultas
```
