@EndUserText.label: 'Caracteristicas materiais'
define table function ZTF_MM_CARACT_MATERIAIS
returns {
    mandt: abap.clnt;
    matnr: matnr;
    atnam: atnam;
    atwrt: atwrt;
    atwtb: atwtb;
}
implemented by method ZCL_MM_CARACT_MATERIAIS=>AMDP_CARACTERISTICAS_MATERIAIS;
