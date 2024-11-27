CREATE PROCEDURE TransferBooks(
	@FromStoreId INT,
	@ToStoreId INT,
	@ISBN13 CHAR(13),
	@Quantity INT = 1 )
AS

BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            IF EXISTS (SELECT 1 FROM Stores WHERE Id = @FromStoreId) 
               AND EXISTS (SELECT 1 FROM Stores WHERE Id = @ToStoreId)
               AND EXISTS (SELECT 1 FROM Inventories WHERE StoreId = @FromStoreId AND ISBN13 = @ISBN13)
            BEGIN
                DECLARE @CurrentQuantity INT;

                SELECT @CurrentQuantity = Quantity
                FROM Inventories
                WHERE ISBN13 = @ISBN13 AND StoreId = @FromStoreId;

                IF @CurrentQuantity >= @Quantity
                BEGIN
                    UPDATE Inventories
                    SET Quantity -= @Quantity
                    WHERE ISBN13 = @ISBN13 AND StoreId = @FromStoreId;
                    
					MERGE Inventories AS target
                    USING (SELECT @ToStoreId AS StoreId, @ISBN13 AS ISBN13) AS source
                    ON target.StoreId = source.StoreId AND target.ISBN13 = source.ISBN13
                    WHEN MATCHED THEN
                        UPDATE SET target.Quantity = target.Quantity + @Quantity
                    WHEN NOT MATCHED THEN
                        INSERT (StoreId, Isbn13, Quantity)
                        VALUES (@ToStoreId, @ISBN13, @Quantity);

                    COMMIT TRANSACTION;
                    PRINT 'Transfer succesfully executed';
                END
                ELSE
                BEGIN
                    ROLLBACK TRANSACTION;
                    PRINT 'Transfer cancelled. Not enough books in inventory.';
                END
            END
            ELSE
            BEGIN
                ROLLBACK TRANSACTION;
                PRINT 'Transfer cancelled. Invalid parameter.';
            END

    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Transfer cancelled. Unexpected error occured.';
        PRINT ERROR_MESSAGE();
    END CATCH
END;
