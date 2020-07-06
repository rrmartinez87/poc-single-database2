Sku names allowed values
--------------

BASIC -> Basic
STANDARD -> S0, S1, S2, S3, S4, S6, S7, S9, S12
PREMIUM -> P1, P2, P4, P6, P11, P15
GENERAL PURPOSE - PROVISIONED -> GP_GEN5_{vCores}
GENERAL PURPOSE - SERVERLESS -> GP_S_GEN5_{vCores}
HYPERSCALE -> HS_GEN5_{vCores}
BUSINESS CRITICAL -> BC_GEN5_{vCores}
ELASTIC -> ElasticPool (use this value when setting elatic_pool_id)

Basic
-----
5 DTU, 100 MB - 2 GB

Standard
--------
10 (S0), 20 (S1), 50 (S2), 100 (S3), 200 (S4), 400 (S6), 800 (S7), 1600 (S9), 3000 (S12).
S0, S1, S2 -> 100 MB - 250 GB.
S3 - S12 -> 100 MB - 1 TB.

Premium
-------
125 DTU (P1), 250 DTU (P2), 500 DTU (P4), 1000 DTU (P6), 1750 DTU (P11), 4000 DTU (P15).
P1 - P6 -> 100 MB - 1 TB.
P11 - P15 -> 100 MB - 4 TB.
Read scale-out -> enabled/disabled (default enabled)
Zone redundant -> false by default

General Purpose
---------------
  Provisioned ->  2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 24, 32, 40, 80 vCores.
    2 - 4 cores -> 1 GB - 1 TB.
    6 - 10 cores -> 1 GB - 1.5 TB.
    12 - 20 cores -> 1 GB - 3 TB.
    24 - 80 cores -> 1 GB - 4 TB.
  Serverless -> 1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 24, 32, 40 Max vCores.
    Min vCores between 0.5 - 40 depending on max vcores selected.
    enable auto-pause -> days, hours, mins (disabled by default)
    data max size ->
      1 -> 512 GB
      2 - 4 cores -> 1 GB - 1 TB.
      6 - 10 cores -> 1 GB - 1.5 TB.
      12 - 20 cores -> 1 GB - 3 TB.
      24 - 40 cores -> 1 GB - 4 TB.

Hyperscale
----------
scaling from Hyperscale to another service tier is not possible
  2, 4, 6, 8 10, 12, 14, 16, 18, 20, 24, 32, 40, 80 vCores.
  secondary replicas 0 - 4
  Autogrowth storage up to 100 TB

Business Critical
-----------------
2, 4, 6, 8 10, 12, 14, 16, 18, 20, 24, 32, 40, 80 vCores.
2 - 4 cores -> 1 GB - 1 TB.
6 - 10 cores -> 1 GB - 1.5 TB.
12 - 20 cores -> 1 GB - 3 TB.
24 - 80 cores -> 1 GB - 4 TB.
Read scale-out -> enabled/disabled (default enabled)
Zone redundant -> false by default