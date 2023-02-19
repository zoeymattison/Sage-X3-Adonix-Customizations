SELECT DISTINCT POH.BPSNUM_0,
                FCY.FCYNAM_0,
                PTD.PRHFCY_0,
                POH.POHNUM_0,
                POQ.PTHNUM_0,
                PTD.SDHNUM_0,
                ITF.STOFCY_0,
                PTD.RCPDAT_0,
                ITF.ITMREF_0,
                POP.ITMDES_0,
                CAST(POQ.QTYSTU_0 AS INT),
                POQ.STU_0,
                PPL.PRI_0,
                ( PPL.PRI_0 * POQ.QTYSTU_0 * 1.12 ),
                PTD.CREUSR_0,
                ITM.TCLCOD_0
FROM   PORDER POH
       LEFT OUTER JOIN PORDERQ POQ
                    ON POH.POHNUM_0 = POQ.POHNUM_0
       LEFT OUTER JOIN PORDERP POP
                    ON POH.POHNUM_0 = POP.POHNUM_0
                       AND POQ.ITMREF_0 = POP.ITMREF_0
                       AND POQ.POQSEQ_0 = POP.POPSEQ_0
                       AND POQ.POPLIN_0 = POP.POPLIN_0
       LEFT OUTER JOIN PRECEIPTD PTD
                    ON POQ.PTHNUM_0 = PTD.PTHNUM_0
                       AND POQ.POPLIN_0 = PTD.PTDLIN_0
       LEFT OUTER JOIN ITMMASTER ITM
                    ON POQ.ITMREF_0 = ITM.ITMREF_0
       LEFT OUTER JOIN PPRICLIST PPL
                    ON POQ.ITMREF_0 = PPL.PLICRD_0
                       AND PPL.PLI_0 = 'T20'
                       AND PPL.PLILIN_0 = 1000
       LEFT OUTER JOIN FACILITY FCY
                    ON POH.BPSNUM_0 = FCY.FCY_0
       LEFT OUTER JOIN ITMFACILIT ITF
                    ON POQ.ITMREF_0 = ITF.ITMREF_0
WHERE  POH.BPSNUM_0 BETWEEN '1200' AND '2600'
       AND PTD.PRHFCY_0 = %1%
       AND ITF.STOFCY_0 = %2% 