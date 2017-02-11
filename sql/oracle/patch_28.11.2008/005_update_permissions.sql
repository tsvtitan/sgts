/* »зменение данных в таблице прав доступа */

BEGIN
  UPDATE PERMISSIONS
     SET INTERFACE='¬вод данных'
   WHERE INTERFACE='¬вод исходных данных';

  COMMIT;        
END;

--

