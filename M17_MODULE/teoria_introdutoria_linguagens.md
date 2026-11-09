# Teorias Introdutórias - Python para Analistas [Compilação & Interpretação]

## O que é uma linguagem Compilada?

Na linguagem compilada, o código-fonte é completamente traduzido para uma linguagem de máquina (ou para algo próximo disso) através de um compilador, antes de sua execução. Resultando em um arquivo executável que o computador vai rodar diretamente.

**Exemplos:**
Linguagens como C, C++, Rust e Go.


## O que é uma Linguagem Interpretada?

Nesta, o código-fonte será lido e executado através de um interpretador linha por linha, no momento em que oo programa rodar. Não é gerado um executável prévio, tendo a necessidade de intalar o interpretador para rodar o código.

**Exemplos:**
Linguagens como Python, Ruby, PHP e JavaScript Clássico.


## O que é uma Linguagem de Modelo Híbrido?

Os modelos híbridos são aqueles que combinam compilação e interpretação, onde o código-fonte passa por uma etapa de compilação, mas o resultado não é um executável, mas um intermediário (bytecode), que é executado depois por uma máquina virtual ou um interpretador.

+ Como isso funciona?
    1. O compilador vai traduzir o código-fonte para bytecode (um formato mais simples e independente de plataforma).
    2. Uma máquina virtual (VM) executa esse bytecode, interpretando ou compilando para linguagem de máquina durante a execução.

