/***************************/
/* Based on a template by Oren Ish-Shalom */
/***************************/

/*************/
/* USER CODE */
/*************/
import java_cup.runtime.*;



/******************************/
/* DOLAR DOLAR - DON'T TOUCH! */
/******************************/

%%

/************************************/
/* OPTIONS AND DECLARATIONS SECTION */
/************************************/

/*****************************************************/
/* Lexer is the name of the class JFlex will create. */
/* The code will be written to the file Lexer.java.  */
/*****************************************************/
%class Lexer

/********************************************************************/
/* The current line number can be accessed with the variable yyline */
/* and the current column number with the variable yycolumn.        */
/********************************************************************/
%line
%column

/******************************************************************/
/* CUP compatibility mode interfaces with a CUP generated parser. */
/******************************************************************/
%cup

/****************/
/* DECLARATIONS */
/****************/
/*****************************************************************************/
/* Code between %{ and %}, both of which must be at the beginning of a line, */
/* will be copied verbatim (letter to letter) into the Lexer class code.     */
/* Here you declare member variables and functions that are used inside the  */
/* scanner actions.                                                          */
/*****************************************************************************/
%{
	/*********************************************************************************/
	/* Create a new java_cup.runtime.Symbol with information about the current token */
	/*********************************************************************************/
	private Symbol symbol(int type)               {return new Symbol(type, yyline, yycolumn);}
	private Symbol symbol(int type, Object value) {return new Symbol(type, yyline, yycolumn, value);}

	/*******************************************/
	/* Enable line number extraction from main */
	/*******************************************/
	public int getLine()    { return yyline + 1; }
	public int getCharPos() { return yycolumn;   }
	public void yyerror()   { throw new java.lang.Error(); }

%}

/***********************/
/* MACRO DECALARATIONS */
/***********************/
LineTerminator	= \r|\n|\r\n
newLine			= "\n"
WhiteSpace		= \s+
INTEGER			= 0 | [1-9][0-9]*
IDENTIFIER		= [a-zA-Z][_a-zA-Z0-9]*
one_line_comment	= "//".* 
comment 		= "/*" ~"*/"
any 			= [.+]
/******************************/
/* DOLAR DOLAR - DON'T TOUCH! */
/******************************/

%%

/************************************************************/
/* LEXER matches regular expressions to actions (Java code) */
/************************************************************/

/**************************************************************/
/* YYINITIAL is the state at which the lexer begins scanning. */
/* So these regular expressions will only be matched if the   */
/* scanner is in the start state YYINITIAL.                   */
/**************************************************************/

<YYINITIAL> {
"class"				{ return symbol(sym.CLASS); }
"public"            { return symbol(sym.PUBLIC); }
"static"			{ return symbol(sym.STATIC); }
"void"				{ return symbol(sym.VOID); }
"main"				{ return symbol(sym.MAIN); }
"("					{ return symbol(sym.OPEN_BRACKETS); }
")"					{ return symbol(sym.CLOSE_BRACKETS); }
"{"					{ return symbol(sym.OPEN_CURLY_BRACKETS); }
"}"					{ return symbol(sym.CLOSE_CURLY_BRACKETS); }
"["					{ return symbol(sym.OPEN_SQUARE_BRACKETS); }
"]"					{ return symbol(sym.CLOSE_SQUARE_BRACKETS); }
"String"			{ return symbol(sym.STRING); }
"extends"			{ return symbol(sym.EXTENDS); }
";"					{ return symbol(sym.SEMICOLON); }
","					{ return symbol(sym.COMMA); }
"return" 			{ return symbol(sym.RETURN); }
"int"				{ return symbol(sym.INT); }
"boolean"			{ return symbol(sym.BOOLEAN); }
"if"				{ return symbol(sym.IF); }
"else"				{ return symbol(sym.ELSE); }
"while"				{ return symbol(sym.WHILE); }
"System.out.println" { return symbol(sym.PRINT); }
"="					{ return symbol(sym.EQUAL); }
"&&"				{ return symbol(sym.AND); }
"<"					{ return symbol(sym.LT); }
"+"					{ return symbol(sym.PLUS); }
"-"					{ return symbol(sym.MINUS); }
"*"					{ return symbol(sym.MULT); }
"."					{ return symbol(sym.DOT); }
"length"			{ return symbol(sym.LENGTH); }
"true"				{ return symbol(sym.TRUE); }
"false"				{ return symbol(sym.FALSE); }
"this"				{ return symbol(sym.THIS); }
"new"				{ return symbol(sym.NEW); }
"!"					{ return symbol(sym.NOT); }
{LineTerminator}	{ /* do nothing */ }
{WhiteSpace}		{ /* do nothing */ }
{comment}			{ /* do nothing */ }
{one_line_comment}	{ /* do nothing */ }
{INTEGER}    		{ return symbol(sym.NUMBER, Integer.parseInt(yytext())); }
{IDENTIFIER}		{ return symbol(sym.IDENTIFIER, new String(yytext())); }
<<EOF>>				{ return symbol(sym.EOF); }
"{any}"				{ yyerror(); }
}