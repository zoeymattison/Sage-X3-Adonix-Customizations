# This function will return the lines of a specified PO upon its creation, with pattern matching.
# In this context, we want to be notified when items with a BASICS SKU (BAS*) are ordered from the
# SPR vendor (vendor code V6501). The expression returned will give the internal sku, vendor sku,
# description, quantity ordered and gross line price plus tax.

Funprog GetSPRLig(ZNUM)
	Value Char ZNUM
	Local Clbfile RETVAL (6)
	Retval=''
		If !Clalev([F:ZPOP]) : Local File PORDERP[ZPOP] : Endif
		If !Clalev([F:ZPOQ]) : Local File PORDERQ[ZPOQ] : Endif
		LINK [ZPOP] WITH [ZPOQ]POQ0=[F:ZPOP]POHNUM;[F:ZPOP]POPLIN;[F:ZPOP]POPSEQ AS [ZPO]
		Filter [ZPO] Where POHNUM = ZNUM
		read [ZPO] first
		if fstat = 0
			For [ZPO]
				if pat([F:ZPO]ITMREF, 'BAS*')<>0
					RETVAL += num$([F:ZPO]POPLIN/1000)+'. '-[F:ZPO]ITMREF-mess(1,16807,1)-[F:ZPOQ]ITMREFBPS-mess(1,16807,1)-[F:ZPO]ITMDES-mess(1,16807,1)-num$([F:ZPOQ]QTYSTU)-[F:ZPOQ]STU-mess(1,16807,1)-chr$(36)+format$("N3vF<:13.2",[F:ZPO]GROPRI*1.12*[F:ZPOQ]QTYSTU)+chr$(13)+chr$(13)+chr$(13)+chr$(13)+chr$(10)+chr$(10)
				Endif
			next
		Endif
	RETVAL+=''
	End RETVAL
	
# This function will return the lines of a specified Sales ORder upon its creation, with pattern matching.
# In this context, we want to be notified when items with a MOS SKU has been ordered. The expression returned 
# will give the internal sku, description, quantity ordered and gross line price plus tax.

Funprog GetMOSLig(ZNUM)
	Value Char ZNUM
	Local Clbfile RETVAL (6)
	Retval=''
		If !Clalev([F:ZSOP]) : Local File SORDERP[ZSOP] : Endif
		If !Clalev([F:ZSOQ]) : Local File SORDERQ[ZSOQ] : Endif
		LINK [ZSOP] WITH [ZSOQ]SOQ0=[F:ZSOP]SOHNUM;[F:ZSOP]SOPLIN;[F:ZSOP]SOPSEQ AS [ZSO]
		Filter [ZSO] Where SOHNUM = ZNUM
		read [ZSO] first
		if fstat = 0
			For [ZSO]
				if pat([F:ZSO]ITMREF, 'MOS*')<>0
					RETVAL += num$([F:ZSO]SOPLIN/1000)+'. '-[F:ZSO]ITMREF-mess(1,16807,1)-[F:ZSO]ITMDES-mess(1,16807,1)-num$([F:ZSOQ]QTY)-[F:ZSO]SAU-mess(1,16807,1)-chr$(36)+format$("N3vF<:13.2",[F:ZSO]GROPRI*1.12*[F:ZSOQ]QTY)+chr$(13)+chr$(13)+chr$(13)+chr$(13)+chr$(10)+chr$(10)
				Endif
			next
		Endif
	RETVAL+=''
	End RETVAL

# Returns the sales order source in a workflow message.

Funprog GetOrdSrc(ZNUM2)
	Global Decimal ZNUM2
	Local Clbfile RETVAL (6)
	RETVAL=''
		If ZNUM2 = 1
			RETVAL+= "Phone"
		Endif
		If ZNUM2 = 2
			RETVAL+= "Email"
		Endif
		If ZNUM2 = 3
			RETVAL+= "Fax"
		Endif
		If ZNUM2 = 4
			RETVAL+= "Picking Error"
		Endif
		If ZNUM2 = 5
			RETVAL+= "Short Ship"
		Endif
	RETVAL += ''
	End RETVAL
	
# Returns a detailed list of PO lines in a workflow message.
	
Funprog GetPOHLig(ZNUM)
	Value Char ZNUM
	Local Clbfile RETVAL (6)
	Retval=''
		If !Clalev([F:ZZPOP]) : Local File PORDERP[ZZPOP] : Endif
		If !Clalev([F:ZZPOQ]) : Local File PORDERQ[ZZPOQ] : Endif
		LINK [ZZPOP] WITH [ZZPOQ]POQ0=[F:ZZPOP]POHNUM;[F:ZZPOP]POPLIN;[F:ZZPOP]POPSEQ AS [ZPO]
		Filter [ZPO] Where POHNUM = ZNUM
		read [ZPO] first
		if fstat = 0
			For [ZPO]
				RETVAL += num$([F:ZPO]POPLIN/1000)+'. '-[F:ZPO]ITMREF-mess(1,16807,1)-[F:ZZPOQ]ITMREFBPS-mess(1,16807,1)-[F:ZPO]ITMDES-mess(1,16807,1)-num$([F:ZZPOQ]QTYSTU)-[F:ZZPOQ]STU-mess(1,16807,1)-chr$(36)+format$("N3vF<:13.2",[F:ZPO]GROPRI)-mess(1,16807,1)-chr$(36)+format$("N3vF<:13.2",[F:ZPO]GROPRI*[F:ZZPOQ]QTYSTU)+chr$(13)+chr$(13)+chr$(13)+chr$(13)+chr$(10)+chr$(10)
			next
		Endif
	RETVAL+=''
	End RETVAL
