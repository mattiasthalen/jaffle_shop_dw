{{ config(materialized='incremental') }}

{%- set yaml_metadata -%}
source_model: 'v_stg_items'
src_pk: 'item_hk'
src_fk: 
    - 'order_hk'
    - 'product_hk'
src_payload:
    - 'item_id'
src_eff: 'effective_from'
src_ldts: 'load_date'
src_source: 'source'
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.t_link(src_pk=metadata_dict["src_pk"],
                      src_fk=metadata_dict["src_fk"],
                      src_payload=metadata_dict["src_payload"],
                      src_eff=metadata_dict["src_eff"],
                      src_ldts=metadata_dict["src_ldts"],
                      src_source=metadata_dict["src_source"],
                      source_model=metadata_dict["source_model"]) }}
