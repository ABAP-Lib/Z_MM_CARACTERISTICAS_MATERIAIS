@AbapCatalog.sqlViewName: 'ZV_MM_CARACTMAT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Caracteristicas materiais'
define view ZI_MM_CARACT_MATERIAIS2
as select from ZTF_MM_CARACT_MATERIAIS
{
    matnr,
    atnam,
    atwrt,
    atwtb
}
