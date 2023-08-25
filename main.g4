grammar main;


//Parser
compilationUnit : mainClass (classDeclaration)*;

mainClass:('class' Identifier Ocarl 'public' 'static' 'void' 'main' Obrac 'String' '[' ']' Ws? Identifier Cbrac Ocarl statement? Ccarl Ccarl);
classDeclaration:'class' Identifier Ocarl ((Identifier Ws Identifier Scol Ws?|varDeclaration)* (methodDeclaration|statement)*)Ccarl;
varDeclaration : type Identifier Scol;

methodDeclaration : 'public' type Identifier Obrac ( type Identifier ( Comma type Identifier )* )? Cbrac Ocarl ( varDeclaration )* ( statement )* 'return' expression Scol Ccarl ;

type : 'int' '[' ']' | 'boolean' | 'int' | Identifier ;

statement : Ocarl ( statement )* Ccarl
          | 'if' Obrac expression Cbrac statement 'else' statement
          | 'while' Obrac expression Cbrac statement
          | 'System.out.println' Obrac expression Cbrac Scol
          | Identifier Equals expression Scol
          | Identifier '[' expression ']' Equals expression Scol
          | (commint_singl|commint_mul);

expression : expression '&&' expression
           | expression '<' expression
           | expression '+' expression
           | expression '-' expression
           | expression '*' expression
           | expression '[' expression ']'
           | expression Dot 'length'
           | expression Dot Identifier Obrac ( expression ( Comma expression )* )? Cbrac
           | INTEGER_LITERAL
           | 'true'
           | 'false'
           | Identifier
           |Quot Identifier Quot
           | 'this'
           | 'new' 'int' '[' expression ']' Scol?
           | 'new' Identifier Obrac Cbrac Scol?
           | '!' expression
           | Obrac expression Cbrac;


commint_mul: '/*'  (Identifier|Quot Identifier Quot|'$'|'!'|'@'|'#'|'$'|'%'|'^'|'&'|'*'|'('|')'|'_'|'+'|'-'|'class'|','|'new'|'if'|'true'|'false'|WS)*  '*/' ;

commint_singl: '//'  (Identifier|Quot Identifier Quot|'$'|'!'|'@'|'#'|'$'|'%'|'^'|'&'|'*'|'('|')'|'_'|'+'|'-'|'class'|','|'new'|'if'|'true'|'false'|WS)*;


//Tokens
Identifier : ('a'..'z'|'A'..'Z'|'_'|'$')+('0'..'9'|'a'..'z'|'A'..'Z'|'_'|'$')* ;
INTEGER_LITERAL : ('0'..'9')+;
Float: ('0'..'9')*('.')('0'..'9');
Condoperation:('>'|'<'|'<='|'>='|'==');
Logicaloperator:('&&'|'||');
Arth:('+'|'-'|'*'|'/'|'%');
Obrac:'(';
Cbrac:')';
Ocarl:'{';
Ccarl:'}';
Scol:';';
Comma: ',';
Dot: '.';
Equals: '=';
Quot:'"';
WS : (' '|'\t'|'\r'|'\n') -> skip;