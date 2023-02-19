SELECT DISTINCT STO.STOFCY_0,
                ITM.ITMREF_0,
                ITM.ITMDES1_0,
                ITM.CCE_1,
                ITM.CCE_3,
                ITM.TSICOD_0,
                ( CAST(STO.QTYPCU_0 AS INT) ),
                STO.PCU_0,
                STO.LOC_0,
                STO.LOCTYP_0,
                MIN(PPL.PRI_0),
                ( ( STO.QTYPCU_0 * STO.PCUSTUCOE_0 ) *
                ( MIN(PPL.PRI_0) * 1.12 ) ),
                CASE
                  WHEN MAX(PRD.CREDAT_0) IS NULL THEN MAX(ITV.LASRCPDAT_0)
                  ELSE MAX(PRD.CREDAT_0)
                END,
                MAX(SIH.CREDAT_0),
                CASE
                  WHEN MAX(SIH.CREDAT_0) IS NULL THEN
                  DATEDIFF(DAY, MAX(ITV.LASRCPDAT_0),
                  GETDATE())
                  ELSE DATEDIFF(DAY, MAX(SIH.CREDAT_0), GETDATE())
                END
FROM   LIVE.ITMMASTER ITM
       LEFT OUTER JOIN LIVE.STOCK STO
                    ON ITM.ITMREF_0 = STO.ITMREF_0
                       AND ( STO.LOCTYP_0 BETWEEN 'WHS1' AND 'WHSR' )
       LEFT OUTER JOIN LIVE.PRECEIPTD PRD
                    ON STO.ITMREF_0 = PRD.ITMREF_0
                       AND STO.STOFCY_0 = PRD.PRHFCY_0
                       AND ( PRD.BPSNUM_0 NOT BETWEEN '1200' AND '2800' )
       LEFT OUTER JOIN LIVE.ITMMVT ITV
                    ON STO.ITMREF_0 = ITV.ITMREF_0
                       AND STO.STOFCY_0 = ITV.STOFCY_0
                       AND ( ITV.VCRTYP_0 = 19 )
       LEFT OUTER JOIN LIVE.PPRICLIST PPL
                    ON STO.ITMREF_0 = PPL.PLICRD_0
                       AND ( PPL.PLI_0 = 'T20' )
       LEFT OUTER JOIN LIVE.SINVOICED SID
                    ON STO.ITMREF_0 = SID.ITMREF_0
       LEFT OUTER JOIN LIVE.SINVOICE SIH
                    ON SID.NUM_0 = SIH.NUM_0
WHERE  ( SIH.INVTYP_0 = 1
          OR SIH.INVTYP_0 IS NULL )
       AND STO.QTYPCU_0 > 0
       AND ( ( STO.STOFCY_0 >= %1%
               AND ( STO.STOFCY_0 <= %2%
                      OR RTRIM(%2%) IS NULL
                      OR RTRIM(%2%) = '' ) )
             AND STO.STOFCY_0 <> 'DC31' )
       AND ( ITM.ITMREF_0 >= %3%
             AND ( ITM.ITMREF_0 <= %4%
                    OR RTRIM(%4%) IS NULL
                    OR RTRIM(%4%) = '' ) )
       AND ( ITM.CCE_1 >= %5%
             AND ( ITM.CCE_1 <= %6%
                    OR RTRIM(%6%) IS NULL
                    OR RTRIM(%6%) = '' ) )
       AND ( ITM.TSICOD_0 >= %7%
             AND ( ITM.TSICOD_0 <= %8%
                    OR RTRIM(%8%) IS NULL
                    OR RTRIM(%8%) = '' ) )
GROUP  BY STO.STOFCY_0,
          ITM.ITMREF_0,
          SIH.INVTYP_0,
          ITM.ITMDES1_0,
          ITM.CCE_1,
          ITM.CCE_3,
          ITM.TSICOD_0,
          STO.QTYPCU_0,
          STO.PCU_0,
          STO.PCUSTUCOE_0,
          STO.LOC_0,
          STO.LOCTYP_0 