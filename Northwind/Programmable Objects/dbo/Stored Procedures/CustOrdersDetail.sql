IF OBJECT_ID('[dbo].[CustOrdersDetail]') IS NOT NULL
    DROP PROCEDURE [dbo].[CustOrdersDetail];

GO
SET QUOTED_IDENTIFIER ON;
GO
SET ANSI_NULLS ON;
GO

CREATE PROCEDURE [dbo].[CustOrdersDetail] @OrderID INT
AS
    BEGIN
        SELECT
                PR.ProductName,
                UnitPrice     = ROUND(Od.UnitPrice, 2),
                Od.Quantity,
                Discount      = CONVERT(INT, Od.Discount * 100),
                ExtendedPrice = ROUND(CONVERT(MONEY, Od.Quantity * (1 - Od.Discount) * Od.UnitPrice), 2)
        FROM
                dbo.Products        PR
            JOIN
                dbo.[Order Details] Od
                    ON Od.ProductID = PR.ProductID
        WHERE
                Od.OrderID = @OrderID;
    END;
GO
