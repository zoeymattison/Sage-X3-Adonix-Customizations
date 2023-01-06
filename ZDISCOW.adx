# Author: Zoey Mattison
# Consultant: Svenir Anjan
# Version: 1.3
# Creation Date: November 8, 2022
# Revision Date: November 12, 2022

###################################################################################
# These programs work together to notify users and to update safety stock when    #
# products have been discontonued. There are three identical workflow rules which #
# coinside with these programs. Pelase see the readme for more information about  #
# how to set this up if needed.                                                   #
###################################################################################

# ZDISCOW is a program that triggers two workflows. One to notify the mod user, and one
# to notify any stock sites that have a safety stock greator than 0 for that item. This
# program triggers via action from a separate workflow when an item discontiuation is
# detected.

Subprog ZDISCOW
	If !Clalev([F:ZITF]) : Local File ITMFACILIT[F:ZITF] : Endif					
	Global Char GZITM										
	Global Char GZFCY										
	Global Decimal GZSFS	
	Local Integer TYPEVT : TYPEVT = 1				
	Local Char CODEVT : CODEVT = 'ZDM'				
	Local Char OPERAT : OPERAT = ''					
	Local Char CLEOBJ : CLEOBJ = [F:ZITF]ITMREF			
	Call WORKFLOW(TYPEVT,CODEVT,OPERAT,CLEOBJ) From AWRK	
		Filter[F:ZITF] Where [F:ZITF]ITMREF = [F:ITM]ITMREF & [F:ZITF]SAFSTO > 0		
			For[F:ZITF]									
				GZITM = [F:ZITF]ITMREF
				GZFCY = [F:ZITF]STOFCY
				GZSFS = [F:ZITF]SAFSTO
					Local Integer TYPEVT : TYPEVT = 1				
					Local Char CODEVT : CODEVT = 'ZDS'				
					Local Char OPERAT : OPERAT = ''					
					Local Char CLEOBJ : CLEOBJ = [F:ZITF]ITMREF			
					Call WORKFLOW(TYPEVT,CODEVT,OPERAT,CLEOBJ) From AWRK		
				Raz GZITM, GZFCY, GZSFS							
			Next										
End

# This function is called in the context of the menual ZDM workflow shown above.
# It informs the modification user of any sites with a safety stock, so that they
# can check for errors in the automation if necessary.

Funprog GetSFsite
    Local Clbfile RETVAL (6)
    RETVAL=''
    If !Clalev([F:ZITFR]) : Local File ITMFACILIT[F:ZITFR] : Endif
        Filter[F:ZITFR] Where [F:ZITFR]ITMREF = [F:ITM]ITMREF & [F:ZITFR]SAFSTO > 0
        read [F:ZITFR] first
            if fstat = 0
                For [F:ZITFR]
                    RETVAL+= num$([F:ZITFR]STOFCY)+': '+num$([F:ZITFR]SAFSTO)+chr$(13)+chr$(10)
                next
            else
                RETVAL += 'There are no sites with safety stock.'
            Endif
    RETVAL += ''
    End RETVAL

# ZDISCOU is a program that will change all safety stocks for the given item to 0.
# It is called in the context of the ZDS manual workflow shown above via an action,
# and is the final program that runs in this script.

Subprog ZDISCOU
    If !Clalev([F:ZITFU]) : Local File ITMFACILIT[F:ZITFU] : Endif
    Read[F:ZITFU]ITF0 = [F:ITM]ITMREF;[F:ZITF]STOFCY
        If fstat=0
            If adxlog<>1 : Trbegin[F:ZITFU] : Endif
            [F:ZITFU]SAFSTO=0
            Rewrite[F:ZITFU]
                If fstat=0
                    Commit
                Else
                    Rollback
                Endif 
            Endif
    End

