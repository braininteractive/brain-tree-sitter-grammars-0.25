// File declarations and record I/O
dcl-f custfile usage(*input:*output) keyed;
dcl-f report printer oflind(*inof);
dcl-s custKey char(10);

chain (custKey) custfile;
if %found(custfile);
  update custrec;
else;
  write custrec;
endif;

setll *loval custfile;
read custfile;
dow not %eof(custfile);
  read custfile;
enddo;
