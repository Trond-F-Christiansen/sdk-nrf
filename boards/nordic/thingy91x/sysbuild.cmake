#
# Copyright (c) 2024 Nordic Semiconductor ASA
#
# SPDX-License-Identifier: LicenseRef-Nordic-5-Clause
#

# Use static partition layout to ensure the partition layout remains
# unchanged after DFU. This needs to be made globally available
# because it is used in other CMake files.

# Helper function to apply partition overlays to all relevant images
function(thingy91x_apply_partitions_to_all_images)
  set(IMAGES_NEEDING_PARTITIONS "mcuboot" "b0" "${DEFAULT_IMAGE}")

  foreach(image IN LISTS IMAGES_NEEDING_PARTITIONS)
    foreach(overlay_file IN LISTS ARGN)
      add_overlay_dts(${image} "${overlay_file}")
    endforeach()
  endforeach()
endfunction()

# nRF91 with TF-M (default)
if(SB_CONFIG_BOARD_THINGY91X_NRF9151_NS)
  if(SB_CONFIG_THINGY91X_STATIC_PARTITIONS_FACTORY)
    # most common configuration, nRF91 uses external flash
    thingy91x_apply_partitions_to_all_images(
      "${CMAKE_CURRENT_LIST_DIR}/partitions/thingy91x_nrf9151_ns_sram_partitions.dtsi"
      "${CMAKE_CURRENT_LIST_DIR}/partitions/thingy91x_nrf9151_ns_partitions.dtsi"
    )
    message(WARNING "Using TF-M + external flash")
  elseif(SB_CONFIG_THINGY91X_STATIC_PARTITIONS_NRF53_EXTERNAL_FLASH)
    # special config where nRF91 is not using external flash
    thingy91x_apply_partitions_to_all_images(
      "${CMAKE_CURRENT_LIST_DIR}/partitions/thingy91x_nrf9151_ns_sram_partitions.dtsi"
      "${CMAKE_CURRENT_LIST_DIR}/partitions/thingy91x_nrf9151_ns_noext_partitions.dtsi"
    )
    message(WARNING "Using TF-M + no external flash")
  endif()
endif()

# nRF91 without TF-M (special use)
if(SB_CONFIG_BOARD_THINGY91X_NRF9151)
  if(SB_CONFIG_THINGY91X_STATIC_PARTITIONS_FACTORY)
    # most common configuration, nRF91 uses external flash
    thingy91x_apply_partitions_to_all_images(
      "${CMAKE_CURRENT_LIST_DIR}/partitions/thingy91x_nrf9151_sram_partitions.dtsi"
      "${CMAKE_CURRENT_LIST_DIR}/partitions/thingy91x_nrf9151_partitions.dtsi"
    )
    message(WARNING "Not using TF-M + external flash")
  elseif(SB_CONFIG_THINGY91X_STATIC_PARTITIONS_NRF53_EXTERNAL_FLASH)
    # special config where nRF91 is not using external flash
    thingy91x_apply_partitions_to_all_images(
      "${CMAKE_CURRENT_LIST_DIR}/partitions/thingy91x_nrf9151_sram_partitions.dtsi"
      "${CMAKE_CURRENT_LIST_DIR}/partitions/thingy91x_nrf9151_noext_partitions.dtsi"
    )
        message(WARNING "Not using TF-M + no external flash")
  endif()
endif()

# nRF53 without TF-M (default)
if(SB_CONFIG_BOARD_THINGY91X_NRF5340_CPUAPP)
  if(SB_CONFIG_THINGY91X_STATIC_PARTITIONS_FACTORY)
    # most common configuration, nRF53 is not using external flash
    thingy91x_apply_partitions_to_all_images(
      "${CMAKE_CURRENT_LIST_DIR}/partitions/thingy91x_nrf5340_sram_partitions.dtsi"
      "${CMAKE_CURRENT_LIST_DIR}/partitions/thingy91x_nrf5340_partitions.dtsi"
    )
    message(WARNING "Not using TF-M + no external flash")
  elseif(SB_CONFIG_THINGY91X_STATIC_PARTITIONS_NRF53_EXTERNAL_FLASH)
    # special config where nRF53 is using external flash
    thingy91x_apply_partitions_to_all_images(
      "${CMAKE_CURRENT_LIST_DIR}/partitions/thingy91x_nrf5340_sram_partitions.dtsi"
      "${CMAKE_CURRENT_LIST_DIR}/partitions/thingy91x_nrf5340_ext_partitions.dtsi"
    )
    message(WARNING "Not using TF-M + external flash")
  endif()
endif()

# nRF53 with TF-M (special use)
if(SB_CONFIG_BOARD_THINGY91X_NRF5340_CPUAPP_NS)
  if(SB_CONFIG_THINGY91X_STATIC_PARTITIONS_FACTORY)
    # most common configuration, nRF53 is not using external flash
    thingy91x_apply_partitions_to_all_images(
      "${CMAKE_CURRENT_LIST_DIR}/partitions/thingy91x_nrf5340_sram_partitions.dtsi"
      "${CMAKE_CURRENT_LIST_DIR}/partitions/thingy91x_nrf5340_ns_partitions.dtsi"
    )
    message(WARNING "Using TF-M + no external flash")
  elseif(SB_CONFIG_THINGY91X_STATIC_PARTITIONS_NRF53_EXTERNAL_FLASH)
    # special config where nRF53 is using external flash
    thingy91x_apply_partitions_to_all_images(
      "${CMAKE_CURRENT_LIST_DIR}/partitions/thingy91x_nrf5340_sram_partitions.dtsi"
      "${CMAKE_CURRENT_LIST_DIR}/partitions/thingy91x_nrf5340_ns_ext_partitions.dtsi"
    )
    message(WARNING "Using TF-M + external flash")
  endif()
endif()
