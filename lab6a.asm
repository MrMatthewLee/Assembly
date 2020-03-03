;******************************************************************************************
;* Program Name:	lab 6a
;* Programmer:		Matthew Lee
;* Class:	 		CSCI 2160-001
;* Lab:   			Lab 6a
;* Date:  			3/3/2020
;* Purpose:			Lab 6a showcasing and learning more about Procs and handling output
;******************************************************************************************

	.486			;tells the assembler we are working with 32-bit code
	.model flat		;tells the assembler we have a flat memory model - all addresses 32 bit
	.stack 100h		;tells the assembler how many bytes we want on the stack
	.LISTALL
	;tells the operating system (OS) to clean up our running program
	ExitProcess	PROTO	Near32	STDCALL, dwExitCode:DWORD
	GetStdHandle PROTO Near32 STDCALL, nStdHandle:DWORD
	putstring	PROTO Near32 STDCALL, lpString:DWORD
	WriteConsoleA PROTO Near32 STDCALL,
		hConsoleOutput:DWORD, 
		lpBuffer:PTR BYTE, 
		dwNumberOfCharsToWrite:DWORD, 
		lpNumberOfCharsWritten:PTR DWORD, 
		lpReserved:DWORD 
	STD_OUTPUT_HANDLE EQU -11	;-11 for STDOUT in Windows
	.data
;place your variables and other data for your programs here
strName				BYTE 13,10," Name: Matthew Lee",0
strClass			BYTE 13,10,"Class: CSCI 2160-001",0
strDate				BYTE 13,10," Date: End Of Lab",0
strLab				BYTE 13,10,"  Lab: Lab 6a",0
_stdOutput			DWORD ?
dBytesWritten		DWORD ?
	.code
_start:				;label for OS -- tells where to start execution
	mov EAX, -1
main PROC
	mov EAX, 0
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE	;Getting the OutputHandle for later use
	mov _stdOutput, EAX						;Moving return value to Memory for later use
	INVOKE WriteConsoleA, _stdOutput, ADDR strName, LENGTHOF strName, ADDR dBytesWritten, 0
	INVOKE WriteConsoleA, _stdOutput, ADDR strClass, LENGTHOF strClass, ADDR dBytesWritten, 0
	INVOKE WriteConsoleA, _stdOutput, ADDR strDate, LENGTHOF strDate, ADDR dBytesWritten, 0
	INVOKE WriteConsoleA, _stdOutput, ADDR strLab, LENGTHOF strLab, ADDR dBytesWritten, 0
	
	INVOKE ExitProcess, 0	;0 = normal termination in OS-land	
PUBLIC _start		;tells the linker this is a global label -- single entry point
main ENDP
;Other Procs
END					;tells the assembler to ignore all instructions beyond this point
