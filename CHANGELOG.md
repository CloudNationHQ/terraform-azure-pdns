# Changelog

## [4.1.0](https://github.com/CloudNationHQ/terraform-azure-pdns/compare/v4.0.0...v4.1.0) (2025-11-04)


### Features

* add missing tags property existing private dns zone ([#74](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/74)) ([58ba453](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/58ba453ca05c5bb4892b6ede3669b81a88926078))

## [4.0.0](https://github.com/CloudNationHQ/terraform-azure-pdns/compare/v3.6.0...v4.0.0) (2025-09-24)


### ⚠ BREAKING CHANGES

* this change causes recreates

### Features

* add type definitions and changed data structure ([#71](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/71)) ([b24c540](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/b24c540927c8bf92888ad65c162915548b1dd5f2))

### Upgrade from v3.6.0 to v4.0.0:

- Update module reference to: `version = "~> 4.0"`
- The property and variable resource_group is renamed to resource_group_name

## [3.6.0](https://github.com/CloudNationHQ/terraform-azure-pdns/compare/v3.5.0...v3.6.0) (2025-07-14)

### Features

* add property 'resolution_policy' ([#64](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/64)) ([ad5d968](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/ad5d968f39e1625e4da28c8ed820b92593c6680e))
* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#61](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/61)) ([6849534](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/6849534f67f2ca81f4eba04d31f73f0fae93c660))
* **deps:** bump golang.org/x/net in /tests in the go_modules group ([#60](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/60)) ([22aa2b9](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/22aa2b9ea9b5e6f387ea8d9d82938910cd5d8453))

## [3.5.0](https://github.com/CloudNationHQ/terraform-azure-pdns/compare/v3.4.0...v3.5.0) (2025-06-16)


### Features

* add mx record support public dns ([#58](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/58)) ([a0003f2](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/a0003f25384c8269a3d6d206f6ec2bac81584123))
* **deps:** bump golang.org/x/net in /tests in the go_modules group ([#54](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/54)) ([8acc037](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/8acc03799b235ef580099fa208d88156678a4b98))

## [3.4.0](https://github.com/CloudNationHQ/terraform-azure-pdns/compare/v3.3.0...v3.4.0) (2025-02-21)


### Features

* add support for SOA records in private DNS zone configuration ([#52](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/52)) ([1cbcc60](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/1cbcc60b4b111146ce6783e73d0f08e962926992))
* **deps:** bump the go_modules group in /tests with 2 updates ([#50](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/50)) ([23b15eb](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/23b15eb580aab424b7e258c6ef274949c4ca32cb))

## [3.3.0](https://github.com/CloudNationHQ/terraform-azure-pdns/compare/v3.2.1...v3.3.0) (2025-01-20)


### Features

* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#46](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/46)) ([02182c5](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/02182c55ba11afe007d5c5e864be3baee7b1b669))
* remove temporary files when deployment tests fails ([#47](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/47)) ([333707c](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/333707c4aab988a997e12a525e65ca7fdb924a2a))

## [3.2.1](https://github.com/CloudNationHQ/terraform-azure-pdns/compare/v3.2.0...v3.2.1) (2024-11-11)


### Bug Fixes

* fix wrong module references all usages ([#42](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/42)) ([c01f03f](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/c01f03f8d68f850eceb9ea0c9fd18d03178658de))

## [3.2.0](https://github.com/CloudNationHQ/terraform-azure-pdns/compare/v3.1.0...v3.2.0) (2024-11-11)


### Features

* enhance testing with sequential, parallel modes and flags for exceptions and skip-destroy ([#40](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/40)) ([34042e4](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/34042e440d54939b6c5f1376fc9d7ac5f83d050a))

## [3.1.0](https://github.com/CloudNationHQ/terraform-azure-pdns/compare/v3.0.0...v3.1.0) (2024-10-31)


### Features

* add predefined zone support ([#38](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/38)) ([4f15f8c](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/4f15f8c7d5af1d2efef257d82a4216bac0555931))

## [3.0.0](https://github.com/CloudNationHQ/terraform-azure-pdns/compare/v2.1.0...v3.0.0) (2024-10-30)


### ⚠ BREAKING CHANGES

* the data structure has been enhanced to accommodate both public and private dns zones

### Features

* add support for public dns zones and record types ([#36](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/36)) ([2e11725](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/2e117251a16c237f3e925aa4508e71cd455e7887))

### Upgrade from v2.1.0 to v3.0.0:

- Update module reference to: `version = "~> 3.0"`
- Restructure the zones object:
  - within zones either private or public is required now to categorize the zone types
- Added output variables:
  - private_zones and public_zones

## [2.1.0](https://github.com/CloudNationHQ/terraform-azure-pdns/compare/v2.0.0...v2.1.0) (2024-10-11)


### Features

* auto generated docs and refine makefile ([#34](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/34)) ([8769398](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/87693980931fe0cca9a97cb2b783f7f6760dc172))
* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#33](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/33)) ([3120375](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/3120375bd7a6227efbcc925a567c2d1336b1a0f8))

## [2.0.0](https://github.com/CloudNationHQ/terraform-azure-pdns/compare/v1.0.0...v2.0.0) (2024-09-24)


### ⚠ BREAKING CHANGES

* Version 4 of the azurerm provider includes breaking changes.

### Features

* upgrade azurerm provider to v4 ([#31](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/31)) ([27718d7](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/27718d75b0f5b1c46d26367fee542ccfb124d6be))

### Upgrade from v1.0.0 to v2.0.0:

- Update module reference to: `version = "~> 2.0"`

## [1.0.0](https://github.com/CloudNationHQ/terraform-azure-pdns/compare/v0.6.0...v1.0.0) (2024-09-23)


### ⚠ BREAKING CHANGES

* data structure has changed due to renaming of properties.

### Features

* aligned several properties and simplified tests ([#29](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/29)) ([e5d6c13](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/e5d6c13ad03791fc9e90b1e349a8ca89c8ecbece))

### Upgrade from v0.6.0 to v1.0.0:

- Update module reference to: `version = "~> 1.0"`
- Rename properties in zones object:
  - resourcegroup -> resource_group
- Rename variable (optional):
  - resourcegroup -> resource_group

## [0.6.0](https://github.com/CloudNationHQ/terraform-azure-pdns/compare/v0.5.0...v0.6.0) (2024-08-29)


### Features

* update documentation ([#25](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/25)) ([ecd773d](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/ecd773def4c508ad375f545e882a274e646c106d))

## [0.5.0](https://github.com/CloudNationHQ/terraform-azure-pdns/compare/v0.4.0...v0.5.0) (2024-07-31)


### Features

* add type definitions and contribution guidelines ([#22](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/22)) ([4458727](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/4458727ec7e3b4db19d4f179cdef680a8364b250))
* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#20](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/20)) ([f82ed83](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/f82ed839adebb30eabbc752a928fb3bc53b59318))

## [0.4.0](https://github.com/CloudNationHQ/terraform-azure-pdns/compare/v0.3.0...v0.4.0) (2024-07-02)


### Features

* add issue template ([#17](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/17)) ([0154f38](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/0154f386b9a7c7d799addaa0e8f78e281d1446d7))
* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#18](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/18)) ([df0d2e5](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/df0d2e57d67c946cd985dbf272e0ced46fb2eb12))
* **deps:** bump github.com/hashicorp/go-getter ([#16](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/16)) ([72a964b](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/72a964be99804ad7b2ca14c9640d6c85a1261675))

## [0.3.0](https://github.com/CloudNationHQ/terraform-azure-pdns/compare/v0.2.0...v0.3.0) (2024-06-07)


### Features

* add pull request template ([#14](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/14)) ([c65160b](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/c65160bd69973a6daa21f547ede41b9e794111c7))
* **deps:** bump github.com/gruntwork-io/terratest in /tests ([#13](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/13)) ([f84c467](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/f84c46760f1e32504b527eea6b5bd8d37ebb4019))
* **deps:** bump the go_modules group in /tests with 2 updates ([#11](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/11)) ([109311e](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/109311e1a82b44ab32f06168fecf41e917563d6b))

## [0.2.0](https://github.com/CloudNationHQ/terraform-azure-pdns/compare/v0.1.0...v0.2.0) (2024-04-08)


### Features

* **deps:** Bump github.com/gruntwork-io/terratest from 0.46.11 to 0.46.13 in /tests ([4aee87c](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/4aee87c4399abb0b5603295760b2412c64f8ccc7))
* include existing private dns zone in outputs ([#8](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/8)) ([4b5038e](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/4b5038e21b8abfdc0710dc10f07d3299c22b8d44))

## 0.1.0 (2024-03-13)


### Features

* add initial resources ([#2](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/2)) ([b4371ff](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/b4371fffdd107c6ff1d27320c2301c315c0c577d))
* **deps:** bump golang.org/x/crypto from 0.14.0 to 0.17.0 in /tests ([#4](https://github.com/CloudNationHQ/terraform-azure-pdns/issues/4)) ([841069f](https://github.com/CloudNationHQ/terraform-azure-pdns/commit/841069f8e644ab0c163da84ce9c391f1d6aa4703))
