;==================================
;File: 
;Description:
;Author: 
;Version: 
;=================================

.code
	JMP mostrar_questao_um

mostrar_questao_um:
	LDI primeiro_ptr
	SUB last_caracter
	JZ responder_questao_um
	INT output

	MOV 1
	ADD primeiro_ptr
	STA primeiro_ptr
	JMP mostrar_questao_um

responder_questao_um:
	LDA mask_input
	INT input
	STA escolha

	MOV 0
	SUB escolha
	JN checar_resposta

	JMP responder_questao_um

checar_resposta:
	LDA escolha
	SUB resposta
	JZ resposta_correta
	JMP valor_final

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
	JMP end

valor_final:
	LDA mask_output
	ADD acertos
	INT output
	JMP end

end:
	INT exit

.data
	;syscall exit
	exit: DD 25
	input: DD 20
	mask_input: DD 0x100
	last_caracter: DD 0

	primeira_questao: INITB "Onde rufino bebe?", " 1 - Preta", " 2 - Tonhao", " 3 - Vermelho", 0
	resposta: DD 49
	primeiro_ptr: DD primeira_questao

	acerto: INITB "Acertou", 0
	ptr_acerto: DD acerto
	valor_caracter: DD 0

	output: DD 21
	questao: DD 1
	mask_output: DD 0x000
	opcao: DD 49

	acertos: DD 0
	
.bss
	escolha: RESD 1

.stack 10

