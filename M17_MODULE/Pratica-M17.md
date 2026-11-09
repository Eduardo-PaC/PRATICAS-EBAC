# Tarefa Prática: Módulo 17 - Python: Criação de Script e IDE

### **Índice:**

| N° Atividade | Enunciado da Questão |
|--------------|---------------------|
| [N° 01](#1-linguagens-compiladas-e-interpretadas) | Primeira Questão: Linguagens Compiladas e Interpretadas |
| [N° 02](#2-ides-e-terminais) | Segunda Questão: IDEs e Terminais|
| [N° 03](#3-jupyter-notebook-e-pycharm) | Terceira Questão: Jupyter Notebook e Pycharm |

## 1. Linguagens Compiladas e Interpretadas
Explique a diferença entre as formas de execução paresentadas no módulo. Descreva o papel de um compilador e de um interpretador e dê exemplos de linguagens associados a cada abordagem.


### Qual a diferença entre as formas de execução apresentadas no módulo:

Na linguagem compilada, o código-fonte é completamente traduzido para uma linguagem de máquina (ou para algo próximo disso) através de um compilador, antes de sua execução. Resultando em um arquivo executável que o computador vai rodar diretamente.

Na linguagem interpretada, o código-fonte será lido e executado através de um interpretador linha por linha, no momento em que oo programa rodar. Não é gerado um executável prévio, tendo a necessidade de intalar o interpretador para rodar o código.

### Descreva o papel de um compilador e de um interpretador:

Compilador é o programa que traduz todo o código-fonte para linguagem de máquina antes da execução, resultando em um executável que roda sem o código original. Durante essa tradução, ele também analisa o código e aponta erros de sintaxe e de tipos, impedindo a finalização do programa até que os erros sejam corrigidos.

Interpretador é o programa que lê e executa o código diretamente, linha a linha, traduzindo enquanto o programa roda. Não há uma etapa separada para gerar um executável. Para rodar o código é necessário ter o interpretador instalado. Isso torna o ciclo de escrever, testar e corrigir mais rápido, enquanto executar pode ser mais lentos e alguns erros só irão aparecer quando a linha com problema for executada, tornando o processo de depuração mais lento.


**Exemplos: Linguagem Compilada**
Linguagens como C, C++, Rust e Go.|

**Exemplos: Linguagem Interpretada**
Linguagens como Python, Ruby, PHP e JavaScript Clássico.


## 2. IDEs e Terminais
Compare a execução de um script Python em uma IDE e no Terminal. Explique uma vantagem e uma limitação de cada forma de trabalho e dê um exemplo de situação em que cada uma pode ser útil

### Compare a execução de um script Python em uma IDE e no Terminal:

Na IDE, você abre o arquivo e executa com um botão "Run" ou um atalho. A IDE chama o interpretador Python por baixo dos panos e mostra a saída em um painel integrado.

No terminal, você roda o script manualmente, direto da pasta do arquivo. Você consegue controlar qual interpretador usar e pode passar argumentos ou combinar com outros comandos.


### Explique uma vantagem e uma limitação de cada forma de trabalho:

**IDE (Integrated Development Environment)**  
***Vantagens:***
*Reúne tudo em um lugar só, acelerando o trabalho e facilitando encontrar erros, ajuda a organizar projetos grandes e é mais amigável para iniciantes.*

***Limitações:***
*É mais pesada e consome mais memória, exige intalação e configuração, pode não estar disponível em servidores remotos sem interface gráfica e o excesso de recursos pode atrapalhar quem está começando, escondendo o código real.*


**Terminal (CMD ou Linha de Comando)**  
***Vantagens:***
*É leve, rápido e funciona em praticamente qualquer máquina, inclusive via SSH, permite automatizar tarefas com scripts, combina comandos entre si e da um contorle preciso sobre o que está sendo executado.*

***Limitações:***
*Sua curva de aprendizado inicial, pois é preciso decorar diversos comandos, não possui depuração visual nem autocompletar, é menos intuitivo para navegação em projetos grandes, erros de digitação são mais problemáticos, como a exclusão de arquivos importantes por engano.*


### Dê um exemplo de situação em que cada uma pode ser útil:

**A IDE tende a ser melhor quando:**
+ Você está desenvolvendo um projeto com muitos arquivos e precisa navegar e refatorar o código.

+ Precisa depurar um bug complexo, pausando a execução e inspecionando variáveis.

+ é iniciante e quer um ambiente que sinalize erros e sugira correções.


**O terminal tende a ser melhor quando:**
+ Está trabalhando em um servidor remoto sem interface gráfica.

+ Precisa automatizar ou agendar tarefas.

+ Quer instalar pacotes, usar Git, criar ambientes virtuais ou executar comandos rápidos sem abrir uma aplicação pesada.



## 3. Jupyter Notebook e PyCharm
Com base nas aulas, compare as principais características do Jupyter Notebook e do PyCharm. Explique como cada ambiente organiza o trabalho com código e indique uma situação em que você poderia escolher cada um deles. Você pode responder a partir das demonstrações do professor; não é necessário experimentar as duas ferramentas.


### Compare as principais características do Jupyter Notebook e do PyCharm:

**Jupyter Notebook:**  
Ambiente interativo, executado no navegador, organizado em células que misturam código, texto, gráficos e resultados no mesmo documento.

**PyCharm:**  
IDE completa da JetBrains, voltada ao desenvolvimento de projetos em Python, com editor avançado, depurador, testes e integração com Git.


### Explique como cada ambiente organiza o trabalho com código:

**Jupyter Notebook:**  
Organiza por células, onde o trabalho gira em torno de um único documento, dividido em células, que podem ser de código ou de texto.

**PyCharm:**  
Organiza por projetos, onde o trabalho gira em torno de uma pasta com diversos arquivos e pacotes que a IDE conhece e gerencia por inteiro.


### Indique uma situação em que você poderia escolher cada um deles.

**Jupyter Notebook:**  
No recebimento de um arquivo CSV com as vendas dos últimos dois anos, precisamos descobrir quais produtos tem mais saída em cada mês e apresentar isso ao nosso gestor.

*Por quê?*

+ Você carrega os dados de uma vez e testa várias ideias em células separadas, sem reexecutar tudo.

+ Os gráficos e tabelas aparecem logo abaixo do código, o que ajuda a enxergar padrões rapidamente.

+ Dá para escrever explicações em Markdown entre as células, e o notebook final já serve como relatório para o gestor.


**PyCharm:**  
Precisamos desenvolver uma API que cadastra clientes, processa pedidos e se conecta a um banco de dados, e que será mantida por uma equipe durante anos.

*Por quê?*  

+ O projeto terá muitos módulos, e a árvore de arquivos e a navegação entre eles facilitam o trabalho.

+ O depurador permite investigar erros em fluxos complexos com breakpoints.

+ A refaturação segura, os testes integrados e o Git nativo ajudam a manter o código limpo e confiável conforme ele cresce.