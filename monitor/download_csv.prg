#!c:\temp\hbmclip.exe

**********************************************
* Name  : download_csv
* Date  : 2025-04-10 - 14:03:32
* Notes : Baixar o (.csv)
/*
  
*/
***********************************************
#include 'hbmediator.ch' // virtual include file
PROCEDURE download_csv( ... )
    MODULE SHELL

    LOCAL hParams , aData, cPrintParams 

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
    IF .not. file( "local.json" ) 
        SHELL RETURN ERROR "File local.json not found" ERRORCODE 210
    ENDIF      
    cRemoteFile := VLJ_ConfigJson2Value( "local.json" , "remotefile" , "" )
    IF EMPTY( cRemoteFile )
        SHELL RETURN ERROR "Invalid remote file" ERRORCODE 220
    ENDIF      

    lOverwrite := .t.
    cFilename := "planilha.csv"
    cMessage := NIL 
    IF VLJ_Download( cRemoteFile , lOverwrite , cFileName , cMessage )
    ELSE
        SHELL RETURN ERROR cMessage ERRORCODE 230     
    ENDIF
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
