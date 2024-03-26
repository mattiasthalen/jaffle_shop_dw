{{ config(materialized='incremental', schema='hubs') }}

{%- set source_model = "v_stg_products" -%}
{%- set src_pk = "product_hk" -%}
{%- set src_nk = "product_id" -%}
{%- set src_ldts = "load_date" -%}
{%- set src_source = "source" -%}

{{ automate_dv.hub(src_pk=src_pk, src_nk=src_nk, src_ldts=src_ldts,
                   src_source=src_source, source_model=source_model) }}
