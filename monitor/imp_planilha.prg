#!/usr/local/bin/hbmclip
#include "inkey.ch"
**********************************************
* Name  : imp_planilha.prg
* Date  : 2025-04-07 - 14:42:10
* Notes : 
/*
   O objetivo desse programa é importar um arquivo (.csv) 
que foi gerado previamente a partir do google planilhas.
   A sequência geral do trabalho é:
   1. Fazer o download da planilha no formato (.csv)
   2. Executar esse programa

   Esse arquivo contém a lista de máquinas ativas de uma 
determinada rede. O arquivo possui várias colunas, mas 
usaremos apenas as três primeiras colunas:
   (a) Descrição do endpoint (computador ou dispositivo de rede)
   (b) Os 3 primeiros octetos de um endereço IPv4
   (c) O último octeto de um endereço IPv4
*/
***********************************************
#include 'hbmediator.ch' // virtual include file
PROCEDURE imp_planilha( ... )
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
    IF FILE( "planilha.csv" )
        aFields := { ;
            { "DESCRICAO" , "C" , 210 , 0 } , ;
            { "PREFIXOIP" , "C" , 20 , 0 } , ;
            { "OCTETO4" , "C" , 3 , 0 }  }
        dbCreate( "planilha" , aFields )
        use planilha
        append from planilha.csv FIELDS DESCRICAO, PREFIXOIP, OCTETO4 DELIMITED WITH ","
        
        
    ELSE
        SHELL RETURN ERROR "File not found" ERRORCODE 100
    ENDIF


    **************************************Return Message Templates*****************************
    * SHELL RETURN ERROR <cReturn> [ERRORCODE <nCode>] // error
    * SHELL RETURN <cReturn> [AS ARRAY>] // success
    ************************************************************************************

RETURN

STATIC PROCEDURE Hbm_Help( cPrintParams )

    hb_Default( @cPrintParams , "")
    ? "Objective : Importar um arquivo (.csv) para posterior processamento"
    ?
    ? "Parameters standard"
    ? "--help    This help (script) "
    ? "--?       Help " + ExeName() + " (executable) "
    IF .NOT. EMPTY( cPrintParams )
        ? cPrintParams
    ENDIF


RETURN
