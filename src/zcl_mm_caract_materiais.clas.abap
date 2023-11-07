CLASS ZCL_MM_CARACT_MATERIAIS DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

    PUBLIC SECTION.

        interfaces:

            IF_AMDP_MARKER_HDB.

        TYPES:
            BEGIN OF ty_s_CARACTERISTICAS_MATERIAIS,
                mandt TYPE mara-mandt,
                matnr TYPE mara-matnr,
                ATNAM TYPE CABN-ATNAM,
                atwrt TYPE ausp-atwrt,
                atwtb TYPE cawnt-atwtb,
            END OF ty_s_CARACTERISTICAS_MATERIAIS,

            ty_t_CARACTERISTICAS_MATERIAIS TYPE STANDARD TABLE OF ty_s_CARACTERISTICAS_MATERIAIS WITH DEFAULT KEY.

        CLASS-METHODS:

            AMDP_CARACTERISTICAS_MATERIAIS
                RETURNING
                    VALUE(rt_result) TYPE ty_t_CARACTERISTICAS_MATERIAIS.

    PROTECTED SECTION.
    PRIVATE SECTION.
ENDCLASS.



CLASS zcl_mm_caract_materiais IMPLEMENTATION.

    method AMDP_CARACTERISTICAS_MATERIAIS by database FUNCTION
        for hdb
        language sqlscript
        options read-only
        using
            inob
            CABN
            ausp
            cawn
            cawnt
        .

        DECLARE lv_spras char( 1 ) := SESSION_CONTEXT('LOCALE_SAP');

        result =
            SELECT
                inob.mandt,
                inob.OBJEK as matnr,
                CABN.ATNAM,
                ausp.atwrt,
                cawnt.atwtb
            from ausp INNER JOIN inob
            on
                ausp.mandt = inob.mandt AND
                ausp.klart = inob.klart and
                ausp.objek = inob.cuobj
            INNER JOIN cabn
            on
                ausp.mandt = cabn.mandt AND
                ausp.ATINN = cabn.ATINN
            left join cawn
            on
                cawn.mandt = cabn.mandt AND
                cawn.atinn = cabn.atinn AND
                cawn.atwrt = ausp.atwrt
            left join cawnt
            on
                cawnt.mandt = cawn.mandt and
                cawnt.atinn = cawn.atinn and
                cawnt.atzhl = cawn.atzhl and
                cawnt.spras = :lv_spras and
                cawnt.adzhl = cawn.adzhl
            WHERE
                inob.klart = '001' AND
                inob.OBTAB = 'MARA'
            ;

        RETURN
            SELECT
                *
            from
                :result
            ;

    endmethod.

ENDCLASS.
