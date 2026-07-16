// MONITOR / ON-ERROR
dcl-s num int(10);
dcl-s den int(10) inz(0);
dcl-s result int(10);

monitor;
  result = num / den;
on-error 102;
  result = 0;
on-error *all;
  dsply 'unexpected error';
endmon;
