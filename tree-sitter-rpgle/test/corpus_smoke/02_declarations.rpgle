// Standalone declarations and named constants
dcl-s customerName varchar(100);
dcl-s orderTotal packed(11:2) inz(0);
dcl-s isActive ind inz(*off);
dcl-s hireDate date inz(d'2020-01-15');
dcl-c MAX_ITEMS const(500);
dcl-c TAX_RATE 0.19;
customerName = 'ACME Corp';
orderTotal = 1250.75;
