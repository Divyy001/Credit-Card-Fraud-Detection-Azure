CREATE SCHEMA synapse

CREATE MASTER KEY ENCRYPTION BY PASSWORD = '{Password}'

CREATE DATABASE SCOPED CREDENTIAL AzureStorageAccountkey
WITH IDENTITY = '<fraudanalyticssa>',
SECRET = 'V7bV4bNT2XFz9OGJ/Quay5CPVJxx8/JU3+bkBrlejhbi88BGKDJP9eO+JDisidwuhajnxhwiahci890+2pscnohshvfysm37hHyYU';

CREATE EXTERNAL DATA SOURCE CSVDataSource WITH
(
  TYPE = HADOOP,
  LOCATION = 'wasbs://files@fraudanalyticssa.blob.core.windows.net',
  CREDENTIAL = AzureStorageAccountkey
);

CREATE EXTERNAL FILE FORMAT CSVFileFormat
WITH ( 
  FORMAT_TYPE = DELIMITEDTEXT,
  FORMAT_OPTIONS (
    FIELD_TERMINATOR = ',',
    STRING_DEIМІТЕR = '"',
    FIRST_ROW = 2,
    USE_TYPE_DEFAULT = TRUE
    )
);
GO

CREATE EXTERNAL FILE FORMAT csv
WITH (
  FORMAT_TYPE = DELIMITEDTEXT,
  FORMAT_OPTIONS (
    FIELD_TERMINATOR = ',',
    STRING_DEIМІТЕR = '"',
    DATE_FORMAT = '',
    USE_TYPE_DEFAULT = FALSE
    )
);
GO


CREATE EXTERMAL TABLE synapse.exCreditCard
(
   [Time] float,
   [V1] float, [V2] float, [V3] float, [V4] float, [V5] float, [V6] float, [V7] float, [V8] float, [V9] float, [V10] float, [V11] float, [V12] float, [V13] float, [V14] float, [V15] float, [V16] float, [V17] float, [V18] float, [V19] float, [V20] float, [V21] float, [V22] float, [V23] float, [V24] float, [V25] float, [V26] float, [V27] float, [V28] float, 
[Amount] float, [Class] bigint, [id] bigint
)
WITH
(
	LOCATION = 'CreditCard.csv'
	DATA_SOURCE = [CSVDataSource]
	FILE_FORMAT = [CSVFileFormat]	
);
GO

CREATE EXTERNAL TABLE synapse.[MLModelExt]
(
[Model] [varbinary](max) NULL
)
WITH
(
	LOCATION = 'credit_card_model.onnx.hex',
	DATA_SOURCE = [CSVDataSource],
	FILE_FORMAT = csv,
 	REJECT_TYPE = VALUE,
	REJECT_VALUE = 0
);
GO


DECLARE @modelexample varbinary(max) = (SELECT [Model] FROM synapse.[MLModelExt]);

SELECT
d.*, p.*
INTO synapse.CreditCard
FROM PREDICT(MODEL = @modelexample,
	DATA = synpase.exCrediCard AS d,
	RUNTIME = ONNX) WITH (output_label bigint) AS p;

