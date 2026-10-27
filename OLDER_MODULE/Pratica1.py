# Utilize o comando 'input' para receber ao menos 2 números de entrada do usuário.

# numero1 = float(input("Digite o primeiro número: "))
# numero2 = float(input("Digite o segundo número: "))

# Converta os valores recebidos pelo usuário para número inteiro (int) ou ponto flutuante (float)

# numero1 = int(numero1)
# numero2 = int(numero2)

# Implemente ao menos 4 operações matemáticas básicas (adição, subtração, multiplicação e divisão) com os números recebidos.

# Permita que o usuário escolha a operação que será realizada.

# Permita que o usuário consiga desfazer ou escolher novamente os números e a operação desejada.

import re

while True:

    entrada = input("Digite a operação (exemplo: 2 + 5) ou 'exit' para sair: ")
    entrada = entrada.lower().strip() # Padroniza a entrada e remove espaços extras.

    if entrada == 'exit':
        print("Finalizando o programa...")
        break


    regex = r"(\d+(?:\.\d+)?)\s*([\+\*\-\/])\s*(\d+(?:\.\d+)?)"
    resultado = re.search(regex, entrada)

    if resultado:
        num1 = float(resultado.group(1))
        operador = resultado.group(2)
        num2 = float(resultado.group(3))

        while True:
            if operador == "+":
                resultado_final = num1 + num2
                break
            elif operador == "-":
                resultado_final = num1 - num2
                break
            elif operador == "*":
                resultado_final = num1 * num2
                break
            elif operador == "/":
                if num2 != 0:
                    resultado_final = num1 / num2
                    break
                else:
                    print("Não é possível dividir por zero. Tente novamente.")
                    break

        print(f"Resultado da operação: {resultado_final}")
    else:
        print("Entrada inválida. Tente novamente.")

    

