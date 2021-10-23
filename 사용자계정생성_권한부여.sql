--오라클 12c로 넘어오면서 계정이름 앞에 C##을 붙여줘야 공통 사용자 생성가능
alter session set "_ORACLE_SCRIPT"=true;
create user the IDENTIFIED by oracle;
--권한 또는 롤을 적용해야함
GRANT connect to the;
grant resource to the;
grant create table to the;