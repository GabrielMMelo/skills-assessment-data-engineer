SELECT
    witness,
    city,
    date_witness AS date,
    has_weapon,
    has_hat,
    has_jacket,
    behavior
FROM
  {{ ref('vw_tmp_all_regions') }}
    