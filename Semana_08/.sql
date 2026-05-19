CREATE FUNCTION CalcularPuntualidad (@hora_ingreso DATETIME)
RETURNS VARCHAR(20)
AS
BEGIN
    DECLARE @estado_puntualidad VARCHAR(20);

    IF CONVERT(TIME, @hora_ingreso) > '08:00:00'
        SET @estado_puntualidad = 'Tardanza';
    ELSE
        SET @estado_puntualidad = 'Puntual';

    RETURN @estado_puntualidad;
END;

CREATE PROCEDURE RegistrarEntradaPersonal
    @p_InstructorID INT,
    @p_CodigoIngreso VARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @v_EstadoCalculado VARCHAR(20);
    DECLARE @v_HoraActual DATETIME = GETDATE();

    BEGIN TRY
        BEGIN TRANSACTION;

        SET @v_EstadoCalculado = dbo.CalcularPuntualidad(@v_HoraActual);

        INSERT INTO RegistroAsistencia (InstructorID, CodigoValidacion, HoraEntrada, EstadoAsistencia)
        VALUES (@p_InstructorID, @p_CodigoIngreso, @v_HoraActual, @v_EstadoCalculado);

        UPDATE Instructores
        SET EstadoOperativo = 'En Instalaciones'
        WHERE ID = @p_InstructorID;

        COMMIT TRANSACTION;

        SELECT CONCAT('Asistencia registrada correctamente. Estado: ', @v_EstadoCalculado) AS MensajeOperacion;

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        SELECT 'Error al registrar la asistencia. Se han revertido los cambios.' AS MensajeOperacion;
        -- Opcional: puedes lanzar el error original si quieres más detalle
        -- THROW;
    END CATCH
END;
