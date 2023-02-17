SELECT DISTINCT ITF.STOFCY_0,
                ITM.ITMREF_0,
                ITM.ITMDES1_0,
                ITM.CCE_1,
                ITM.CCE_3,
                ITM.TSICOD_0,
                CAST(ITV.PHYSTO_0 AS INT),
                STO.PCU_0,
                STO.LOC_0,
                STO.LOCTYP_0,
                MAX(PPL.PRI_0),
                MAX(PPL.PRI_0) * ( ITV.PHYSTO_0 * 1.12 ),
                CASE
                  WHEN MAX(PRD.PTHNUM_0) IS NULL
                       AND MAX(SMH.VCRNUM_0) IS NULL THEN 'No Vendor History'
                  WHEN MAX(PRD.PTHNUM_0) IS NULL THEN MAX(SMH.VCRNUM_0)
                  ELSE MAX(PRD.PTHNUM_0)
                END,
                CASE
                  WHEN MAX(PRD.PTHNUM_0) IS NULL
                       AND MAX(SMH.VCRNUM_0) IS NULL THEN 'No Vendor History'
                  WHEN MAX(PRD.PTHNUM_0) IS NULL THEN
                  CONVERT(VARCHAR(10), MAX(SMH.CREDAT_0), 103)
                  ELSE CONVERT(VARCHAR(10), MAX(PRD.CREDAT_0), 103)
                END,
                CASE
                  WHEN MAX(SIH.NUM_0) IS NULL THEN 'No Sales History'
                  ELSE MAX(SIH.NUM_0)
                END,
                CASE
                  WHEN MAX(SIH.NUM_0) IS NULL THEN 'No Sales History'
                  ELSE CONVERT(VARCHAR(10), MAX(SIH.CREDAT_0), 103)
                END
FROM   LIVE.ITMMASTER ITM
       LEFT OUTER JOIN LIVE.ITMFACILIT ITF
                    ON ITM.ITMREF_0 = ITF.ITMREF_0
                       AND ( STOFCY_0 BETWEEN 'DC30' AND 'DC52' )
                       AND ( STOFCY_0 <> 'DC31' )
       LEFT OUTER JOIN LIVE.STOCK STO
                    ON ITF.STOFCY_0 = STO.STOFCY_0
                       AND ITM.ITMREF_0 = STO.ITMREF_0
                       AND ( LOCTYP_0 BETWEEN 'WHS1' AND 'WHSR' )
       LEFT OUTER JOIN LIVE.ITMMVT ITV
                    ON STO.STOFCY_0 = ITV.STOFCY_0
                       AND STO.ITMREF_0 = ITV.ITMREF_0
       LEFT OUTER JOIN LIVE.PRECEIPTD PRD
                    ON ITM.ITMREF_0 = PRD.ITMREF_0
                       AND ITF.STOFCY_0 = PRD.PRHFCY_0
                       AND ( BPSNUM_0 NOT BETWEEN '1200' AND '2800' )
       LEFT OUTER JOIN LIVE.SMVTD SMD
                    ON ITM.ITMREF_0 = SMD.ITMREF_0
       LEFT OUTER JOIN LIVE.SMVTH SMH
                    ON ITF.STOFCY_0 = SMH.STOFCY_0
                       AND SMD.VCRNUM_0 = SMH.VCRNUM_0
       LEFT OUTER JOIN LIVE.SINVOICED SID
                    ON ITM.ITMREF_0 = SID.ITMREF_0
                       AND ( SIDORI_0 <> 6 )
       LEFT OUTER JOIN LIVE.SINVOICE SIH
                    ON SID.NUM_0 = SIH.NUM_0
                       AND ( INVTYP_0 = 1 )
       LEFT OUTER JOIN PPRICLIST PPL
                    ON ITM.ITMREF_0 = PPL.PLICRD_0
                       AND ( PLI_0 = 'T20' )
WHERE  ITV.PHYSTO_0 > 0
       AND ( ITF.STOFCY_0 >= %1%
             AND ( ITF.STOFCY_0 <= %2%
                    OR RTRIM(%2%) IS NULL
                    OR RTRIM(%2%) = '' ) )
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
GROUP  BY ITF.STOFCY_0,
          ITM.ITMREF_0,
          ITM.ITMDES1_0,
          ITM.CCE_1,
          ITM.CCE_3,
          ITM.TSICOD_0,
          ITV.PHYSTO_0,
          STO.PCU_0,
          STO.LOC_0,
          STO.LOCTYP_0 
