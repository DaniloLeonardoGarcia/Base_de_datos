CREATE PROCEDURE RegistrarEntradaPersonal (
    IN p_InstructorID INT,
    IN p_CodigoIngreso VARCHAR(20)
)
BEGIN
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        
        ROLLBACK;
        
        SELECT 'Error al registrar la asistencia. Se han revertido los cambios.' AS MensajeOperacion;
    END;
    START TRANSACTION;

    
    INSERT INTO RegistroAsistencia (InstructorID, CodigoValidacion, HoraEntrada, EstadoAsistencia)
    VALUES (p_InstructorID, p_CodigoIngreso, NOW(), 'Ingreso Registrado');

    
    UPDATE Instructores
    SET EstadoOperativo = 'En Instalaciones'
    WHERE ID = p_InstructorID;

    
    COMMIT;
    
    
    SELECT 'Asistencia registrada y estado actualizado correctamente.' AS MensajeOperacion;

END //


DELIMITER ;
