/COPY QCPYSRC,PROTOS
/DEFINE TESTING
/IF DEFINED(TESTING)
dcl-s debugMode ind inz(*on);
/ENDIF
/FREE
dcl-s legacy int(10);
legacy = 42;
/END-FREE
