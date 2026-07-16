// Procedure definition with procedure interface
dcl-proc addTax export;
  dcl-pi *n packed(11:2);
    amount packed(11:2) const;
    rate packed(5:4) const;
  end-pi;

  dcl-s result packed(11:2);

  result = amount + amount * rate;
  return result;
end-proc;

dcl-proc sayHello;
  dcl-pi *n;
    name varchar(50) const;
  end-pi;
  dsply ('Hello ' + name);
  return;
end-proc sayHello;
