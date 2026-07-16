// DOW, DOU and FOR loops
dcl-s i int(10);
dcl-s total int(10) inz(0);

dow i < 10;
  total = total + i;
  i += 1;
enddo;

dou total >= 100;
  total = total * 2;
enddo;

for i = 1 to 10 by 2;
  total += i;
endfor;

for i = 10 downto 1;
  dsply %char(i);
endfor;
