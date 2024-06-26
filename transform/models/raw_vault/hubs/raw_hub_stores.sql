{{ config(materialized='incremental') }}

{%- set source_model = "v_stg_stores" -%}
{%- set src_pk = "store_hk" -%}
{%- set src_nk = "store_id" -%}
{%- set src_ldts = "load_date" -%}
{%- set src_source = "source" -%}

{{ automate_dv.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                   src_source=src_source, source_model=source_model) }}
