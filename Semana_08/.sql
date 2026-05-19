CREATE FUNCTION CalcularPuntualidad (hora_ingreso DATETIME) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE estado_puntualidad VARCHAR(20);
    
    IF TIME(hora_ingreso) > '08:00:00' THEN
        SET estado_puntualidad = 'Tardanza';
    ELSE
        SET estado_puntualidad = 'Puntual';
    END IF;
    
    RETURN estado_puntualidad;
END //

DELIMITER ;

CREATE PROCEDURE RegistrarEntradaPersonal (
    IN p_InstructorID INT,
    IN p_CodigoIngreso VARCHAR(20)
)
BEGIN
    DECLARE v_EstadoCalculado VARCHAR(20);
    DECLARE v_HoraActual DATETIME;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SELECT 'Error al registrar la asistencia. Se han revertido los cambios.' AS MensajeOperacion;
    END;

    SET v_HoraActual = NOW();
    
    SET v_EstadoCalculado = CalcularPuntualidad(v_HoraActual);

    START TRANSACTION;

    INSERT INTO RegistroAsistencia (InstructorID, CodigoValidacion, HoraEntrada, EstadoAsistencia)
    VALUES (p_InstructorID, p_CodigoIngreso, v_HoraActual, v_EstadoCalculado);

    UPDATE Instructores
    SET EstadoOperativo = 'En Instalaciones'
    WHERE ID = p_InstructorID;

    COMMIT;
    
    SELECT CONCAT('Asistencia registrada correctamente. Estado: ', v_EstadoCalculado) AS MensajeOperacion;

END;
