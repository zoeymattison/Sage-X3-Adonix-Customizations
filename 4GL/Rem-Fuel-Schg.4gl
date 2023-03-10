# Remove the fuel surcharge if the route is set to PU (pick-up), or if source is set to SS (Short Ship), or PE (Picking Error).

Subprog ZREMFSCHG
	if [M]SOHTYP = "SON"
		If [M]DRN = 23
			[M:SOH3]INVDTAAMT(3) = 0
			Affzo [M:SOH3]INVDTAAMT(3)
			Call ERREURT("The fuel surcharge has been removed\as this order is a pick-up.", 0) From GESECRAN
		Endif
		If [M]YORDSRC = 4 OR [M]YORDSRC = 5 OR [M]YORDSRC = 6
			[M:SOH3]INVDTAAMT(3) = 0
			Affzo [M:SOH3]INVDTAAMT(3)
			Call ERREURT("The fuel surcharge has been removed as the\order source has been set to short ship or\picking error.", 0) From GESECRAN
		Endif
	Endif
End
