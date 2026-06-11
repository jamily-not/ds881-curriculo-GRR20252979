# Currículo Online — DS881

Currículo profissional publicado via GitHub Pages, desenvolvido como projeto individual da disciplina DS881. 
O projeto aplica conceitos de conteinerização, pipeline CI/CD e governança de código com Git.

🔗 **[Acesse o currículo em produção](https://jamily-not.github.io/ds881-curriculo-GRR20252979)**

---

## Stack

- HTML5 e CSS3 puro
- Docker + Docker Compose para ambiente local
- GitHub Actions para CI/CD
- GitHub Pages para hospedagem

---

## Ambiente local com Docker

O ambiente de desenvolvimento é totalmente containerizado. 
Não é necessário ter Node.js instalado na máquina.

**Pré-requisitos:** Docker e Docker Compose.

### Subir o servidor de desenvolvimento

```bash
docker compose up --build
```

Acesse `http://localhost:8080` no navegador. O volume está mapeado para o diretório local, então alterações no código refletem automaticamente sem reiniciar o container.

Para encerrar:

```bash
docker compose down
```

### Rodar o lint localmente

```bash
docker compose --profile lint run --rm lint
```

Executa a verificação de HTML e CSS dentro do container e encerra. Nenhuma dependência local necessária.

---

## Pipeline CI/CD

O workflow `.github/workflows/main.yml` é disparado em todo push e pull request para a `main`, com quatro jobs em sequência:

```
lint → test → build → deploy
```

| Job | O que faz |
| :--- | :--- |
| **Lint** | Valida sintaxe do HTML com HTMLHint e do CSS com Stylelint |
| **Test** | Verifica links e recursos quebrados com broken-link-checker |
| **Build** | Confirma que os arquivos obrigatórios existem e empacota o site |
| **Deploy** | Publica no GitHub Pages (apenas na `main`) |

O deploy só é executado após os três jobs anteriores passarem com sucesso.

---

## Governança de código

### Proteção da branch `main`

A branch `main` está configurada como protegida no GitHub com as seguintes regras:

- Push direto bloqueado — toda alteração entra via Pull Request
- Merge só permitido com o pipeline de CI verde (status check obrigatório)

![Branch-Protection](image.png)

### Fluxo de trabalho

Toda feature ou correção segue o fluxo:

1. Criar uma branch a partir da `main` — ex: `feat/nova-secao`, `ci/melhorias-pipeline`
2. Abrir um Pull Request descrevendo a mudança
3. Aguardar o CI passar
4. Realizar o merge

### Conventional Commits

As mensagens de commit seguem o padrão [Conventional Commits](https://www.conventionalcommits.org/):

| Tipo | Uso |
| :--- | :--- |
| `feat` | nova funcionalidade ou seção |
| `fix` | correção de conteúdo ou estilo |
| `ci` | alterações no pipeline ou Docker |
| `docs` | alterações no README ou documentação |
| `style` | ajustes de formatação sem mudança de lógica |
| `chore` | atualizações de dependências e configurações gerais |

---

## Estrutura do projeto

```
.
├── .github/
│   ├── ISSUE_TEMPLATE/
│   │   └── issue_template.md
│   ├── workflows/
│   │   └── main.yml
│   └── pull_request_template.md
├── assets/
│   └── css/
│       └── style.css
├── .dockerignore
├── .gitignore
├── .stylelintrc.json
├── Dockerfile
├── docker-compose.yml
├── index.html
└── package.json
```