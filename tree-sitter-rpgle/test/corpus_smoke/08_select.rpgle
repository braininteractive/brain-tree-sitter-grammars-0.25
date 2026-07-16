// SELECT / WHEN / OTHER
dcl-s dayNum int(3);
dcl-s dayName varchar(10);

select;
  when dayNum = 1;
    dayName = 'Monday';
  when dayNum = 6 or dayNum = 7;
    dayName = 'Weekend';
  other;
    dayName = 'Weekday';
endsl;

select dayNum;
  when 1;
    dsply 'first';
  other;
    dsply 'rest';
endsl;
