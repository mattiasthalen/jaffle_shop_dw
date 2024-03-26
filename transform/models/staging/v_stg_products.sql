{{ config(materialized='view', schema='staging') }}

{%- set yaml_metadata -%}
source_model:
  staging: "raw_products"

derived_columns:
  product_id: "sku"
  source: "!tap-jaffle-shop"
  load_date: "_sdc_extracted_at"
  effective_from: "_sdc_extracted_at"
  start_dage: "_sdc_extracted_at"
  end_date: "DATE('9999-12-31')"

hashed_columns:
  product_hk:
    - "product_id"
    - "source"
  product_hashdiff:
    is_hashdiff: true
    columns:
      - "product_id"
      - "name"
      - "type"
      - "price"
      - "description"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
