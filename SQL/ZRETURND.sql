SELECT DISTINCT SRD.SRHNUM_0,
                SRD.STOFCY_0,
                SRD.UPDDAT_0,
                SRD.ITMREF_0,
                SRD.ITMDES_0,
                SRD.EXTQTY_0,
                SRD.QTY_0,
                SRD.STU_0,
                SRD.RTNREN_0,
                (SELECT TEXTE_0
                 FROM   ATEXTRA
                 WHERE  CODFIC_0 = 'ATABDIV'
                        AND ZONE_0 = 'LNGDES'
                        AND IDENT1_0 = '7'
                        AND IDENT2_0 = SRD.RTNREN_0
                        AND LANGUE_0 = 'ENG'),
                SRH.BPCORD_0,
                SRH.BPDNAM_0,
                SIV.NUM_0,
                SIV.REP_0,
                REP.REPNAM_0,
                SID.AMTNOTLIN_0,
                SID.NETPRI_0,
                SRD.UPDUSR_0
FROM   SRETURND SRD
       LEFT OUTER JOIN SRETURN SRH
                    ON SRD.SRHNUM_0 = SRH.SRHNUM_0
       LEFT OUTER JOIN SINVOICEV SIV
                    ON SRH.SRHNUM_0 = SIV.SIHORINUM_0
       LEFT OUTER JOIN SINVOICED SID
                    ON SIV.NUM_0 = SID.NUM_0
                       AND SRD.ITMREF_0 = SID.ITMREF_0
       LEFT OUTER JOIN SALESREP REP
                    ON SIV.REP_0 = REP.REPNUM_0
WHERE  SRD.UPDDAT_0 BETWEEN %3% AND %4%
       AND SRD.STOFCY_0 BETWEEN %1% AND %2% 
