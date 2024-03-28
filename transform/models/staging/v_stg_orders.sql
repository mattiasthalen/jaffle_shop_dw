{{ config(materialized='view', schema='staging') }}

{%- set yaml_metadata -%}
source_model:
  staging: "raw_orders"

derived_columns:
  order_id: "id"
  customer_id: "customer"
  source: "!tap-jaffle-shop"
  load_date: "_sdc_extracted_at"
  effective_from: "ordered_at"
  start_dage: "ordered_at"
  end_date: "DATE('9999-12-31')"

hashed_columns:
  order_hk:
    - "order_id"
    - "source"
  store_hk:
    - "store_id"
    - "source"
  store_order_hk:
    - "store_id"
    - "order_id"
    - "source"
  customer_hk:
    - "customer_id"
    - "source"
  customer_order_hk:
    - "customer_id"
    - "order_id"
    - "source"
  order_hashdiff:
    is_hashdiff: true
    columns:
      - "order_id"
      - "ordered_at"
      - "subtotal"
      - "tax_paid"
      - "order_total"
{%- endset -%}

{% set metadata_dict = fromyaml(yaml_metadata) %}

{{ automate_dv.stage(include_source_columns=true,
                     source_model=metadata_dict['source_model'],
                     derived_columns=metadata_dict['derived_columns'],
                     null_columns=none,
                     hashed_columns=metadata_dict['hashed_columns'],
                     ranked_columns=none) }}
