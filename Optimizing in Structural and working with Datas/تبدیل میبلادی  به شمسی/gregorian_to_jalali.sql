DROP FUNCTION IF EXISTS gregorian_to_jalai;
CREATE FUNCTION gregorian_to_jalai(gregorian_date DATETIME) RETURNS VARCHAR(255)   -- CONVERT DATE OF GREGORIN TO JALALI
DETERMINISTIC
BEGIN

   DECLARE GY ,GM ,GD, GY2 ,DAYS,JY,JM,JD INT ;

   SET GY = YEAR(gregorian_date);
   SET GM = MONTH (gregorian_date);
   SET GD = DAY(gregorian_date);

IF GM > 2 THEN
       SET GY2 = GY + 1;
       ELSE
       SET GY2 = GY ;
end if;
    SET days = 355666 + (365 * gy) + FLOOR((gy2 + 3) / 4) - FLOOR((gy2 + 99) /100) + FLOOR((gy2 + 399) / 400) + gd + ELT(GM,0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334);
    SET jy = -1595 + (33 * FLOOR(days / 12053));
    SET DAYS = MOD(DAYS,12053);
    SET jy = JY  + 4 * FLOOR(days / 1461);
    SET DAYS = MOD(DAYS,1461);
IF DAYS > 365  THEN
       SET JY = JY + FLOOR(DAYS - 1) / 365 ;
       SET DAYS = MOD(days - 1 ,365);
END IF;
IF DAYS < 186 THEN
       SET JM = 1 + FLOOR(days / 31);
       SET JD = 1 +MOD(DAYS,31);
ELSE
       SET jm = 7 + FLOOR((days - 186) / 30);
       SET jd = 1 + MOD(days - 186 , 30);
END IF;

   -- 1400/11/10
    -- CONCAT_WS


RETURN CONCAT_WS('/',JY,JM,JD);  -- FOR USING THIS QUERY = OPEN NEW QUERY AND INSERT SELECT('YEAR/MONTH/DAY')

END;