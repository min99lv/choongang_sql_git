-- Backup Dir ����
create or replace DIRECTORY mdBackup2 as 'C:\BACKUP\orabackup';
grant read,write on directory mdBackup2 to scott;