grammar faroukLab;

//parsers

declareion : Type Ws function Scol ;
declareString: STRING Ws string Scol;

string:ID Ws? Assignment Ws? (ID|Qout (ID Ws?)* Qout) ;
function:ID Ws? Assignment Ws?  (Integer|operation);
arifunction:ID Ws?  AssignmentOperation Ws? (Integer|operation);

operation:(ID|Integer)|((ID|Integer) ArtihmitcOperation  (ID|Integer));
ariOperation:((ID|Integer) AssignmentOperation  (ID|Integer));
condtion: operation ConditionalOperation operation ;

//parser if
bigcondition:condtion LogicalOperation condtion;
if:((IF Obr (condtion|bigcondition)+ Cbr Ws?) ((declareion|function Scol)*(if)* Ws?|BracketOpen Ws?(declareion|function Scol)* Ws?  (if)* BracketClose)) Ws? (else|elseif)?;
elseif:ELSE Ws if;
else:ELSE (Ws? (declareion|function Scol|if)* Ws?|BracketOpen Ws? (declareion|function Scol|if)* Ws? BracketClose);


//parser While
statement:Type Ws function(Comma function)* Scol;
while: Ws (WHILE Obr (condtion|bigcondition)+ Cbr Ws?) BracketOpen Ws?(declareion Ws?|function Scol Ws?|if Ws?|Counters Scol Ws?|ariOperation Scol|advancedfor|declareString)* Ws? (Break|Continue)? Ws?  (while)* BracketClose;


//parser for
fordeclaretion:Type Ws forfunction;
forfunction:ID Ws? Assignment Ws?  (Integer|ID) (Comma|Scol);
//for:(For Obr declareion   ID ConditionalOperation Integer Scol Counters Cbr);
finitefor:For Obr Scol Scol Cbr BracketOpen Ws? BracketClose;
advancedfor:For Obr ((fordeclaretion |forfunction)+)  condtion Scol (Counters Comma?)+ Cbr (Ws? (declareion|advancedfor|declareString|if|ariOperation Scol|function Scol)* Ws?|BracketOpen Ws? (declareion|advancedfor|declareString|if|ariOperation Scol)* Ws? BracketClose);
forloop:advancedfor|finitefor;

 //switch-case
 parameters:(Type|STRING|Char) Ws ID ;
 case:Ws? Case Ws (Integer|(ID|Qout (ID Ws?)* Qout)|SingleQuote ID SingleQuote) Colon (declareion|declareString|forloop|if|function Scol|Counters Scol|ariOperation Scol)* (Break|Continue)? Ws?;
 default:Default Colon (declareion|declareString|forloop|if|function Scol|Counters Scol)*;
switch: Switch Obr (ID) Cbr BracketOpen Ws? (case)+ Ws?default? Ws? BracketClose;
switchCase:(declareString Ws?|declareion Ws?|parameters Scol Ws?)* Ws? switch;

//Methods
content:(declareion Ws?|declareString Ws?|forloop Ws?|if Ws?|function Scol Ws?|Counters Scol Ws?|ariOperation Scol Ws?|parameters Scol Ws?)*;

return:RETURN Ws (ID|Integer) Scol;
fieldMethod:(MethodKind|PUBLIC) Ws Static? Ws (Type|STRING|Char) Ws ID Ws? Obr (parameters Comma?)* Cbr BracketOpen Ws? content Ws? return Ws? BracketClose;
voidMethod:(MethodKind|PUBLIC) Ws Static? Ws VOID Ws ID Ws? Obr (parameters Comma?)* Cbr BracketOpen Ws? content Ws?  BracketClose;
entryMethod:PUBLIC Ws Static Ws VOID Ws Main Obr STRING Ws? Array Ws? Args Cbr BracketOpen Ws? content Ws?  BracketClose;
methods:fieldMethod|voidMethod|entryMethod;
//tokens


Type : 'int' | 'double';
Main:'main';
PUBLIC:'public';
MethodKind:'private'|'protected';
VOID:'void';
RETURN:'return';
STRING:'String';
Char:'char';
Array:'[]';
Args:'args';
Comma:',';
Boolean:'true'|'false';
Static:'static';
SingleQuote:'\'';
IF:'if';
ELSE:'else';
WHILE:'while';
Break:'break;';
Continue:'continue;';
Switch:'switch';
Case:'case';
Default:'dafault';
For:'for';
ID:('a' .. 'z' | 'A' .. 'Z' |'_' | '$') +('a' .. 'z' | 'A' .. 'Z' |'_' |'$' |'0' .. '9')*;
Integer : ('0' .. '9')+;
Float:('0' .. '9')* '.' ('0' .. '9')+;
String:('a' .. 'z')+;
Scol : ';';
Assignment : '=';
ArtihmitcOperation : '+' | '-' | '*' | '/'|'%';
ConditionalOperation : '>' | '<' | '==' | '>=' | '<=';
LogicalOperation:'&&'|'||';
AssignmentOperation:'+='|'-='|'*='|'/=';
Colon:':';
Qout:'"';
Obr:'(';
Cbr:')';
BracketOpen:'{';
BracketClose:'}';
Ws : (' '|'\t'|'\r'|'\n')+{skip();};
Print: 'System.out.print';
Ln:'ln';
Counters:'++' ID|'--' ID|ID '++' | ID'--';
