{{ config(materialized='view', schema='staging') }}

{%- set yaml_metadata -%}
source_model:
  staging: "raw_supplies"

derived_columns:
  supply_id: "id"
  product_id: "sku"
  source: "!tap-jaffle-shop"
  load_date: "_sdc_extracted_at"
  effective_from: "_sdc_extracted_at"
  start_dage: "_sdc_extracted_at"
  end_date: "DATE('9999-12-31')"

hashed_columns:
  supply_hk:
    - "supply_id"
    - "source"
  product_hk:
    - "product_id"
    - "source"
  product_supply_hk:
    - "product_id"
    - "supply_id"
    - "source"
  supply_hashdiff:
    is_hashdiff: true
    columns:
      - "supply_id"
      - "product_id"
      - "name"
      - "cost"
      - "perishable"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
