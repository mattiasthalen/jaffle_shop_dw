{{ config(materialized='incremental') }}

{%- set source_model = ["v_stg_orders"] -%}

{%- set src_pk = "customer_order_hk"         -%}
{%- set src_fk = ["customer_hk", "order_hk"] -%}
{%- set src_ldts = "load_date"               -%}
{%- set src_source = "source"                -%}

{{ automate_dv.link(src_pk=src_pk, src_fk=src_fk, src_ldts=src_ldts,
                    src_source=src_source, source_model=source_model) }}