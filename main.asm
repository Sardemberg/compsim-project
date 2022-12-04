;==================================
;File: 
;Description:
;Author: 
;Version: 
;=================================

.code
	CALL mostrar_questao
	JMP valor_final

mostrar_questao:
	CALL reseta_acerto
	MOV 0x000d
	INT output

	MOV 1
	SUB questao
	JZ case_1

	MOV 2
	SUB questao
	JZ case_2

	MOV 3
	SUB questao
	JZ case_3

	MOV 4
	SUB questao
	JZ case_4

	MOV 5
	SUB questao
	JZ case_5

	RET

case_1:
	LDA resposta_um
	STA resposta
	JMP mostrar_questao_um

case_2:
	LDA resposta_dois
	STA resposta
	JMP mostrar_questao_dois

case_3:
	LDA resposta_tres
	STA resposta
	JMP mostrar_questao_tres

case_4:
	LDA resposta_quatro
	STA resposta
	JMP mostrar_questao_quatro

case_5:
	LDA resposta_cinco
	STA resposta
	JMP mostrar_questao_cinco

mostrar_questao_um:
	LDI primeiro_ptr
	SUB last_caracter
	JZ responder_questao
	INT output

	MOV 1
	ADD primeiro_ptr
	STA primeiro_ptr
	JMP mostrar_questao_um

mostrar_questao_dois:
	LDI segundo_ptr
	SUB last_caracter
	JZ responder_questao
	INT output

	MOV 1
	ADD segundo_ptr
	STA segundo_ptr
	JMP mostrar_questao_dois

mostrar_questao_tres:
	LDI terceiro_ptr
	SUB last_caracter
	JZ responder_questao
	INT output

	MOV 1
	ADD terceiro_ptr
	STA terceiro_ptr
	JMP mostrar_questao_tres

mostrar_questao_quatro:
	LDI quarto_ptr
	SUB last_caracter
	JZ responder_questao
	INT output

	MOV 1
	ADD quarto_ptr
	STA quarto_ptr
	JMP mostrar_questao_quatro

mostrar_questao_cinco:
	LDI quinto_ptr
	SUB last_caracter
	JZ responder_questao
	INT output

	MOV 1
	ADD quinto_ptr
	STA quinto_ptr
	JMP mostrar_questao_cinco

responder_questao:
	LDA mask_input
	INT input
	STA escolha

	MOV 0
	SUB escolha
	JN checar_resposta

	JMP responder_questao

checar_resposta:
	MOV 1
	ADD questao
	STA questao

	LDA escolha
	SUB resposta
	JZ resposta_correta
	JMP mostrar_questao

resposta_correta:
	LDI ptr_acerto
	INT output

	MOV 1
	ADD ptr_acerto
	STA ptr_acerto

	LDI ptr_acerto
	STA valor_caracter
	LDA last_caracter
	SUB valor_caracter

	JN resposta_correta

	MOV 1
	ADD acertos
	STA acertos
	JMP mostrar_questao

reseta_acerto:
	LDA valor_inicial_ptr_acerto
	STA ptr_acerto
	RET

valor_final:
	LDA mask_output
	MOV 48
	ADD acertos
	INT output

	MOV 32
	INT output

	CALL mostra_acertos_string
	JMP end

mostra_acertos_string:
	LDA mask_output
	LDI ptr_acertos_finais
	STA valor_caracter
	INT output

	MOV 1
	ADD ptr_acertos_finais
	STA ptr_acertos_finais

	MOV 0
	SUB valor_caracter
	JN mostra_acertos_string

	RET
	
end:
	INT exit

.data
	;syscall exit
	exit: DD 25
	input: DD 20
	mask_input: DD 0x100
	last_caracter: DD 0

	primeira_questao: INITB 0x000d, "1 - Qual bicho transmite Doenca de Chagas?", 0x000d, "1 - Abelha", 0x000d, "2 - Barata", 0x000d, "3 - Pulga", 0x000d, "4 - Barbeiro", 0x000d, 0
	resposta_um: DD 52
	primeiro_ptr: DD primeira_questao

	segunda_questao: INITB 0x000d, "2 - Qual e o coletivo de caes?", 0x000d, " 1 - Matilha", 0x000d, " 2 - Rebanho", 0x000d, "3 - Alcateia", 0x000d, "4 - Manada", 0x000d, 0
	resposta_dois: DD 49
	segundo_ptr: DD segunda_questao

	terceira_questao: INITB 0x000d, "3 - Qual e o triangulo que tem todos os lados diferentes?", 0x000d, " 1 - Equilatero", 0x000d, " 2 - Isosceles", 0x000d, "3 - Escaleno", 0x000d, "4 - Trapezio", 0x000d, 0
	resposta_tres: DD 51
	terceiro_ptr: DD terceira_questao

	quarta_questao: INITB 0x000d, "4 - Qual o pais cede da copa do mundo de 2010?", 0x000d, "1 - Franca", 0x000d, " 2 - Brasil", 0x000d, "3 - Africa do Sul", 0x000d, "4 - Russia", 0x000d, 0
	resposta_quatro: DD 51
	quarto_ptr: DD quarta_questao

	quinta_questao: INITB 0x000d, "5 - Seguindo a sequencia do baralho, qual carta vem depois do dez?", 0x000d, "1 - Rei", 0x000d, "2 - Valete", 0x000d, "3 - Nove", 0x000d, "4 - As", 0x000d, 0
	resposta_cinco: DD 50
	quinto_ptr: DD quinta_questao

	acerto: INITB "Acertou!", 0
	ptr_acerto: DD acerto
	valor_inicial_ptr_acerto: DD acerto
	valor_caracter: DD 0

	acertos_finais: INITB "Acertos!", 0
	ptr_acertos_finais: DD acertos_finais

	output: DD 21
	questao: DD 1
	resposta: DD 0
	mask_output: DD 0x000
	opcao: DD 49

	acertos: DD 0
	
.bss
	escolha: RESD 1

.stack 10



