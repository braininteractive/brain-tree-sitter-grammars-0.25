// Data structure with subfields
dcl-ds address qualified;
  street varchar(60);
  city varchar(40);
  zip char(5);
  country char(2) inz('DE');
end-ds;

dcl-ds order_t qualified template;
  id int(10);
  total packed(11:2);
end-ds;

address.city = 'Berlin';
address.zip = '10115';
