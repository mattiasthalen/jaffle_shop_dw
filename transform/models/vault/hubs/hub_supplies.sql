{{ config(materialized='incremental') }}

{%- set source_model = "v_stg_supplies" -%}
{%- set src_pk = "supply_hk" -%}
{%- set src_nk = "supply_id" -%}
{%- set src_ldts = "load_date" -%}
{%- set src_source = "source" -%}

{{ automate_dv.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                   src_source=src_source, source_model=source_model) }}
