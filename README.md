# ShowDoMarcao

**Disciplina**: FGA0210 - PARADIGMAS DE PROGRAMAÇÃO - T01 <br>
**Nro do Grupo (de acordo com a Planilha de Divisão dos Grupos)**: 02<br>
**Paradigma**: Funcional<br>

## Alunos
|Matrícula | Aluno |
| -- | -- |
| 19/0041871  |  Abner Filipe Cunha Ribeiro   |
| 19/0102390  |  André Macedo Rodrigues Alves |
| 19/0012307  |  Eduardo Afonso Dutra Silva   |
| 18/0018728  |  Igor Batista Paiva           |
| 18/0033620  |  João Henrique Cunha Paulino  |
| 16/0152615  |  João Pedro Elias de Moura    |
| 18/0054554  |  Paulo Batista                |
| 19/0019158  |  Rafael Leão Teixeira de Magalhães |
| 19/0020903  |  Vitor Magalhães Lamego       |

## Sobre

Marcos é um jovem professor recém formado no curso de letras da Universidade de Brasília (UnB), com foco nas linguas: português e inglês.
O jovem professor está extremamente animado, dado que seus alunos estão muito interessados em suas aulas, que vão da leitura de poemas 
de Augusto dos Anjos (em litetratura) à diferenciação de adjundo adnominal e complemento nominal (em gramática). 

Certo dia, quando andava pelos corredores da escola, um grupo de alunos se aproximou de Marcos. Os jovens, com brilho no olhar, começaram
a conversar com o professor sobre a ultima live do [Casimiro](https://www.youtube.com/watch?v=_dWp3ZbP_DA&ab_channel=CortesdoCasimito%5BOFICIAL%5D),
live esta que o streamer estava jogando a versão virtual do [Show do milhão](https://pt.wikipedia.org/wiki/Show_do_Milh%C3%A3o). Certamente aqueles
alunos pediriam para Marcos implementar uma dinâmica semelhante ao jogo em uma de suas aulas, pensou o professor. Logo após este pensamento, um dos alunos
diz: "Professor, o senhor bem que podia fazer um Show do milhão valendo a aprovação neste bimestre, né ?".

Marcos ri e diz: "Tudo bem, eu posso pensar em uma dinâmica como esta valendo alguma nota que não seja superior a 25% do total do bimestre. A propósito, o jogo
vai se chamar Show do Marcão!". Com esta ideia na cabeça e a necessidade de avaliar 5 turmas, cada uma com 35 alunos, o docente sabe que precisa de automatizar
este jogo para tornar viável a execução deste método de avaliação. Diante desta situação, ele logo se lembrou dos seus tempos de faculdade, e que sempre ouvia falar
dos excelentíssimos graduandos em Engenharia de Software da Faculdade do Gama(FGA). Ele pegou o seu celta 2009, que é o melhor carro que um professor consegue comprar
com o seu salário, e foi ao câmpus gama.

Chegando lá, ele conversa com  Milene, professora de PARADIGMAS DE PROGRAMAÇÃO. Com a progressão da conversa, ela diz para Marcos que esta ideia é muito interessante
para que seus alunos criem um pequeno projeto em Haskell e que na semana subsequente (25/11/2022) seus alunos já entregariam uma versão inicial do jogo.

Para mais informações leia as issues do repositório, que foram descritas pelo professor.

## Screenshots
Adicione 2 ou mais screenshots do projeto em termos de interface e/ou funcionamento.

## Instalação 
**Linguagens**: Haskell<br>
**Tecnologias**: Haskell, Docker, stack<br>

O projeto usa a linguagem Haskell e como gerenciador de pacotes usa o software chamado stack. Nesta pasta do repositório existe um Dockerfile que auxiliará
na instalação e execução do projeto.

Caso não tenha instalado o docker na sua máquina basta seguir o tutorial da digital [ocean](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-20-04).

### Rodando o projeto com Docker

Com esta ferramenta instalada e dentro desta pasta execute os seguintes comandos:

```
    $ docker build . -t haskellzitos
    $ docker run -it haskellzitos:latest
```

### Rodando o projeto com Stack

Com o stack instalado e dentro desta pasta execute os seguintes comandos:

```
    $ stack build
    $ stack exec showdomilhao-exe
```

Ao executar estes comandos deve abrir um terminal iterativo indicando o inicio do jogo.

## Uso 
O projeto se baseia em uma interface de linha de comando, segue as regras impostas pelo show do milhão original. O player pode: responder a questão, então acertar a resposta, ganhar
mais dinheiro/pontos e progredir para a próxima questão; ou errar a resposta e perder metade do que ganhou até o momento e o jogo termina; ademais o player também tem a opção de parar o jogo
e conservar a quantia que recebeu até o momento. Além disto também existem movimentos especiais que o jogador pode fazer, como: 

- **Pular a questão**, esta ação pode ser executada até 3 vezes. Ao pular uma questão o aumento de pontos não é executado, ou seja: se O player está em uma questão de 50 mil reais e pula ela, ele apenas receberá uma nova questão e o montante não será somado ao seu prêmio.
- **Cartas**. O jogador pode escolher entre quatro cartas, que estão numeradas de 0 até 3, o número indica a quantidade de resposta erradas que serão retiradas da lista de respostas possíveis. Ex: se o jogador tirar uma carta com o número 2 então serão retiradas 2 questões que não correspondem à resposta certa, sobrando apenas 2 alternativas restantes.
- **Universitários**. Três universitários responderão a questão, sendo que 2 deles tem 75% de chance de acertar e o outro 65%. Ex: A diz que a resposta certa é 1, B diz que a resposta certa é 1, C diz que a resposta certa é 3. Independente do fato de A e B concordarem isto não garante que a resposta certa é 1, e nem que a resposta certa é 3. Mas existe uma grande chance de que a resposta seja 1 ou 3, dadas as porcentagens citadas.
- **Placas**.  Esta ação é semelhante a ajuda dos universitários, o que difere é o número de porcentagens e pessoas participantes. É como se 4 pessoas comuns fossem perguntadas, e não os especialistas. As acurácias dos quatro participantes são: 35%, 45%, 55% e 59%.

Todas as ações, que não **Pular a questão**, só podem ser executadas uma única vez durante o jogo. 

## Vídeo
Adicione 1 ou mais vídeos com a execução do projeto.
Procure: 
(i) Introduzir o projeto;
(ii) Mostrar passo a passo o código, explicando-o, e deixando claro o que é de terceiros, e o que é contribuição real da equipe;
(iii) Apresentar particularidades do Paradigma, da Linguagem, e das Tecnologias, e
(iV) Apresentar lições aprendidas, contribuições, pendências, e ideias para trabalhos futuros.
OBS: TODOS DEVEM PARTICIPAR, CONFERINDO PONTOS DE VISTA.
TEMPO: +/- 15min

## Participações
Apresente, brevemente, como cada membro do grupo contribuiu para o projeto.
|Nome do Membro | Contribuição | Significância da Contribuição para o Projeto (Excelente/Boa/Regular/Ruim/Nula) |
| -- | -- | -- |
| Fulano  |  Programação dos Fatos da Base de Conhecimento Lógica | Boa |

## Outros 
Quaisquer outras informações sobre o projeto podem ser descritas aqui. Não esqueça, entretanto, de informar sobre:
(i) Lições Aprendidas;
(ii) Percepções;
(iii) Contribuições e Fragilidades, e
(iV) Trabalhos Futuros.

## Fontes
Referencie, adequadamente, as referências utilizadas.
Indique ainda sobre fontes de leitura complementares.
