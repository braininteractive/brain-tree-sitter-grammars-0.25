// IF / ELSEIF / ELSE
dcl-s score int(5);
dcl-s grade char(1);

if score >= 90;
  grade = 'A';
elseif score >= 80;
  grade = 'B';
elseif score >= 70;
  grade = 'C';
else;
  grade = 'F';
endif;

if grade = 'A' and score > 95;
  dsply 'excellent';
endif;
