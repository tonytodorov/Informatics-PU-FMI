--set serveroutput on;

--begin
--DBMS_OUTPUT.put_line('Hello world');
--end;


declare
l_first_name VARCHAR2(105) := 'Petar';
begin
DBMS_OUTPUT.put_line('First name: '||l_first_name);
end;



declare
l_first_name VARCHAR2(105) := 'Petar';
l_country VARCHAR2(105) := 'BG';
l_is_bg BOOLEAN;
l_bool_string VARCHAR2(105);

begin


l_bool_string := case when l_is_bg then 'true' else 'false' end;

DBMS_OUTPUT.put_line(l_bool_string);

--
--if l_country = 'BG'
--then
--l_is_bg := True;
--end if;
--IF l_is_bg THEN
--DBMS_OUTPUT.put_line('BG here');
--ELSE 
--NULL;
--END IF;

end;

