ctl-opt dftactgrp(*no) actgrp(*new) option(*srcstmt:*nodebugio);
ctl-opt bnddir('MYBNDDIR');

// Prototype declarations
dcl-pr addTax packed(11:2);
  amount packed(11:2) const;
  rate packed(5:4) const;
end-pr;

dcl-pr QCMDEXC extpgm('QCMDEXC');
  command char(3000) const;
  length packed(15:5) const;
end-pr;

dcl-s tax packed(11:2);
tax = addTax(100 : 0.19);
