// EVAL and built-in functions
dcl-s name varchar(50) inz('John Smith');
dcl-s upper varchar(50);
dcl-s len int(10);
dcl-s msg varchar(100);

eval upper = %upper(name);
eval len = %len(%trim(name));
msg = 'Name: ' + %subst(name : 1 : 4);
msg = %char(%date()) + ' ' + %editc(len : 'Z');
eval(h) len = len * 2;
