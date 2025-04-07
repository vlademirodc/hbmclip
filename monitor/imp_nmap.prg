#!/usr/local/bin/hbmclip

**********************************************
* Name  : imp_nmap
* Date  : 2025-04-07 - 12:10:32
* Notes : 
/*
   1. 
   2. 
*/
***********************************************
#include 'hbmediator.ch' // virtual include file
PROCEDURE imp_nmap( ... )
    MODULE SHELL

    LOCAL hParams , aData, cPrintParams, cSucesso, cFalha , nErrorLevel

    SHELL ADD PARAM "-json" TITLE "Return in json format" BOOLEAN

    /* Insert your params here */
    **************************************Templates***************************************
    * SHELL ADD PARAM "-first" TITLE "First" BOOLEAN // Logical parameter
    * SHELL ADD PARAM "-second" TITLE "Second" STRING DEFAULT "Default Value" // Default value
    * SHELL ADD PARAM "-third" TITLE "Third" STRING MANDATORY // Must be value
    ************************************************************************************
    SHELL PRINT HELP TO cPrintParams
    IF hb_AScan( hb_Acmdline() , "--help" ) <> 0
        Hbm_Help( cPrintParams )
        RETURN
    ENDIF

    SHELL GET PARAMS TO hParams 
    SHELL GET DATA TO aData
    IF IS_PIPE_CONTENT()
        AAdd(aData,m->__PIPE)
        //PIPE TO <aArray> AS ARRAY
        //PIPE TO <cStr> AS STRING
    ENDIF

    IF hParams["-json"]
        SHELL JSON ON // Enable Json format in return message
    ELSE
        SHELL JSON OFF // Disable Json format in return message
    ENDIF

    //SHELL DEBUG hParams // Debug
    //SHELL DEBUG aData // Debug

    /* Insert your code here */
    cResultado := "" 
    cComando := "nmap -e enp0s25 -p- "
    if file("planilha.dbf")
        use planilha shared
    else
        SHELL RETURN ERROR "Arquivo planilha.dbf não existe" 
    endif
    
    do while .not. eof()
        IF EMPTY( field->descricao )
            skip
            LOOP
        ENDIF
        //"ping -c 4 -I enp0s25 "
        cExec := cComando + " " + alltrim(field->prefixoip) + "." + alltrim(field->octeto4)

        EXEC cExec TO cSucesso ERROR cFalha ERRORLEVEL nErrorLevel
        ? aLine[x] 
        cResultado += Replicate("*", 20) + hb_eol()
        cResultado += cExec  + hb_eol()
        
        IF nErrorLevel == 0
            ?? " - (OK)"
            cResultado += cSucesso + hb_eol() 
        ELSE
            ?? " - (FAILLED)"
            cResultado += cFalha + hb_eol()
        ENDIF
        skip
    enddo
    MemoWrit( "nmap.log" , cResultado )
    ? 
    SHELL RETURN "[DONE]"

    **************************************Return Message Templates*****************************
    * SHELL RETURN ERROR <cReturn> [ERRORCODE <nCode>] // error
    * SHELL RETURN <cReturn> [AS ARRAY>] // success
    ************************************************************************************

RETURN

STATIC PROCEDURE Hbm_Help( cPrintParams )

    hb_Default( @cPrintParams , "")
    ? "Objective : "
    ?
    ? "Parameters standard"
    ? "--help    This help (script) "
    ? "--?       Help " + ExeName() + " (executable) "
    ? "--virtual-include : embedded ch files "
    IF .NOT. EMPTY( cPrintParams )
        ? cPrintParams
    ENDIF


RETURN
