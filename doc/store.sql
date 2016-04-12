create proc killrestore (@dbname varchar(20),@dbpath varchar(40))
as
begin
declare @sql   nvarchar(500)
declare @spid  int
set @sql='declare getspid cursor for select spid from sysprocesses where dbid=db_id('''+@dbname+''')'
exec (@sql)
open getspid
fetch next from getspid into @spid
while @@fetch_status <> -1
begin
exec('kill '+@spid)         
fetch next from getspid into @spid
end
close getspid
deallocate getspid
restore database @dbname from disk= @dbpath with replace
end