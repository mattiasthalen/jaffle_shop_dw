{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: "v_stg_orders"
src_pk: "order_hk"
src_hashdiff: 
  source_column: "order_hashdiff"
  alias: "hashdiff"
src_payload:
    - "ordered_at"
    - "subtotal"
    - "tax_paid"
    - "order_total"
src_eff: "effective_from"
src_ldts: "load_date"
src_source: "source"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.sat(src_pk=metadata_dict["src_pk"],
                   src_hashdiff=metadata_dict["src_hashdiff"],
                   src_payload=metadata_dict["src_payload"],
                   src_eff=metadata_dict["src_eff"],
                   src_ldts=metadata_dict["src_ldts"],
                   src_source=metadata_dict["src_source"],
                   source_model=metadata_dict["source_model"]) }}
