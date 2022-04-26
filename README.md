# App do consultor

Aplicativo Pacto para vendas de planos, produtos e atividades relacionadas

## Roadmap

* Millestone: Start

1.  [X] Layout: Dashboard, cards com icones, header com avatar|nome usuário|nome da emprsa, menu inferior com navegação - **Geziel**
2.  [X] Busca, pesquisa de alunos: **Jefferson**
3.  [X] Pesquisa de planos: **Regis**
4.  [X] Pesquisa de produtos: **Artur**
5.  [X] Perfil do usuário: **Miguel**
6.  [X] Login: Utilizar o mesmo fluxo do login do app do gestor: **Miguel**
7.  [X] Api de login: **Kévio**
8.  [X] Api de pesquisa de alunos: **Kévio**
9.  [X] Api de pesquisa de planos: **Kévio**
10. [X] Api de pesquisa de produtos: **Kévio**

* Millestone: Integração com api

11. [X] Api de cadastro de aluno: **Kévio**
12. [X] Login: Integração com api **Miguel** e **Geziel**
13. [X] Busca, pesquisa de alunos: Integração com api **Jefferson** e **Artur**
14. [X] Pesquisa de planos: Integração com api **Regis**, **Miguel** e **Geziel**
15. [X] Pesquisa de produtos: Integração com api **Jefferson** e **Artur**
16. [X] Cadastro do aluno: Falta deinir a tela
17. [X] Api de compra de plano: **Kévio**
18. [X] Api de compra de produto: **Kévio**
19. [X] Api de carrinho de compra: **Kévio**

* Millestone: Compra

20. [X] Compra de plano recorrente: A definir
21. [X] Compra de produto: A definir
22. [X] Carrinho de compra: A definir

* Millestone: Resisões e melhorias

> A definir

* Millestone: Automatização do teste

> A definir

* Millestone: Liberação do app

> A definir

* Millestone: Xablau

## Missão

Liberar o consultor do computador do balcão, dando liberdade e velocidade no atendimento.

[Projeto do figma](https://www.figma.com/proto/OQ3McWBszDSZhRPlZ8BR3b/Telas?page-id=0%3A1&node-id=2%3A2&viewport=355%2C-12%2C0.16492168605327606&scaling=scale-down&starting-point-node-id=2%3A2)

![](/docs/media/app-resume.gif)

## Arquitetura

1. Estrutura de pastas

- telas
    > Contém os compoentes para compor a tela e a logica da interação entre os componentes na tela
- controladores
    > Contém classes de contraladores para serem reutilizados entre telas
- componentes
    > Contém componentes customizados de ui especificos do app
- modelos
    > Classes com definição de entidades
- servicos
    > Classes de integração com Api dos micro serviços da pacto
- uteis
    > Código utilitario para reutilização em todo app, por exemplo: formatar textos, datas, etc.

## Flutter

Este é um projeto flutter.

Se você é novo com flutter, você pode obter ajuda no [Curso Pacto de Flutter]\*(https://drive.google.com/drive/folders/1CE835y-zfJq82EVcrssob3RaCTdK24UW?usp=sharing)

Na [documentação oficial](https://flutter.dev/docs), que oferece tutoriais,
amostras, orientação sobre desenvolvimento móvel e uma referência completa de API.

Alguns recursos para você começar, se este for seu primeiro projeto Flutter:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
