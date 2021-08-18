
# Create a new target.
#
# ```
# add_target( <target_name>
#   TYPE executable|library
#   [SOURCES_INTERFACE [items ...]]
#   [SOURCES_PUBLIC [items...]]
#   [SOURCES_PRIVATE [items...]]
#   [INCLUDE_DIRECTORIES_INTERFACE [items...]]
#   [INCLUDE_DIRECTORIES_PUBLIC [items...]]
#   [INCLUDE_DIRECTORIES_PRIVATE [items...]]
#   [LINK_DIRECTORIES_INTERFACE [items...]]
#   [LINK_DIRECTORIES_PUBLIC [items...]]
#   [LINK_DIRECTORIES_PRIVATE [items...]]
#   [LINK_LIBRARIES_INTERFACE [items...]]
#   [LINK_LIBRARIES_PUBLIC [items...]]
#   [LINK_LIBRARIES_PRIVATE [items...]]
#   [LINK_OTIONS_INTERFACE [items...]]
#   [LINK_OTIONS_PUBLIC [items...]]
#   [LINK_OTIONS_PRIVATE [items...]]
#   [COMPILE_DEFINITIONS_INTERFACE [items...]] )
#   [COMPILE_DEFINITIONS_PUBLIC [items...]]
#   [COMPILE_DEFINITIONS_PRIVATE [items...]]
#   [COMPILE_OPTIONS_INTERFACE [items...]] )
#   [COMPILE_OPTIONS_PUBLIC [items...]]
#   [COMPILE_OPTIONS_PRIVATE [items...]]
# ```
#
# This functions is a wrapper for these functions:
#   -   `add_executable()` / `add_library()`
#   -   `target_sources()`
#   -   `target_include_directories()`
#   -   `target_link_directories()`
#   -   `target_link_libraries()`
#   -   `target_link_options()`
#   -   `target_compile_definitions()`
#   -   `target_compile_options()`
#
# The options are:
#
#   `TYPE`
#     This option is required. The given value must be one of the following:
#
#     -   `executable`: The target will be created using the CMake built-in
#         function `add_executable()`.
#
#     -   `library`: The target will be created using the CMake built-in
#         function `add_library()`.
#
#   `SOURCES_INTERFACE`
#   `SOURCES_PUBLIC`,
#   `SOURCES_PRIVATE`,
#     Wrappers for `target_sources()`.
#
#   `INCLUDE_DIRECTORIES_INTERFACE`
#   `INCLUDE_DIRECTORIES_PUBLIC`,
#   `INCLUDE_DIRECTORIES_PRIVATE`,
#     Wrappers for `target_include_directories()`.
#
#   `LINK_DIRECTORIES_INTERFACE`
#   `LINK_DIRECTORIES_PUBLIC`,
#   `LINK_DIRECTORIES_PRIVATE`,
#     Wrappers for `target_link_directories()`.
#
#   `LINK_LIBRARIES_INTERFACE`
#   `LINK_LIBRARIES_PUBLIC`,
#   `LINK_LIBRARIES_PRIVATE`,
#     Wrappers for `target_link_libraries()`.
#
#   `LINK_OPTIONS_INTERFACE`
#   `LINK_OPTIONS_PUBLIC`,
#   `LINK_OPTIONS_PRIVATE`,
#     Wrappers for `target_link_options()`.
#
#   `COMPILE_DEFINITIONS_INTERFACE`
#   `COMPILE_DEFINITIONS_PUBLIC`,
#   `COMPILE_DEFINITIONS_PRIVATE`,
#     Wrappers for `target_compile_definitions()`.
#
#   `COMPILE_OPTIONS_INTERFACE`
#   `COMPILE_OPTIONS_PUBLIC`,
#   `COMPILE_OPTIONS_PRIVATE`,
#     Wrappers for `target_compile_options()`.
#
function(add_target target_name)
  # Parse ${ARGN} (unnamed arguments)
  set( parse_Options
    )
  set( parse_OneValue
    TYPE )
  set( parse_MultiValue
    SOURCES_INTERFACE
    SOURCES_PUBLIC
    SOURCES_PRIVATE
    INCLUDE_DIRECTORIES_INTERFACE
    INCLUDE_DIRECTORIES_PUBLIC
    INCLUDE_DIRECTORIES_PRIVATE
    LINK_DIRECTORIES_INTERFACE
    LINK_DIRECTORIES_PUBLIC
    LINK_DIRECTORIES_PRIVATE
    LINK_LIBRARIES_INTERFACE
    LINK_LIBRARIES_PUBLIC
    LINK_LIBRARIES_PRIVATE
    LINK_OTIONS_INTERFACE
    LINK_OTIONS_PUBLIC
    LINK_OTIONS_PRIVATE
    COMPILE_DEFINITIONS_INTERFACE
    COMPILE_DEFINITIONS_PUBLIC
    COMPILE_DEFINITIONS_PRIVATE
    COMPILE_OPTIONS_INTERFACE
    COMPILE_OPTIONS_PUBLIC
    COMPILE_OPTIONS_PRIVATE )
  message("add_target(${target_name} ${ARGN})")
  cmake_parse_arguments( args
    "${parse_Options}"
    "${parse_OneValue}"
    "${parse_MultiValue}"
    ${ARGN} )
  message("||${args_TYPE}||\n||${args_SOURCES_PRIVATE}||")

  # Create target:
  if( NOT DEFINED args_TYPE )
    message(FATAL_ERROR "Required TYPE argument missing.")
  elseif( "${args_TYPE}" STREQUAL "executable" )
    add_executable( ${target_name} )
  elseif( "${args_TYPE}" STREQUAL "library" )
    add_library( ${target_name} )
  else()
    message(FATAL_ERROR "TYPE=${args_TYPE} is not an allowed value." )
  endif()

  # Set CMake built-in properties:
  target_sources( ${target_name}
    INTERFACE ${args_SOURCES_INTERFACE}
    PUBLIC    ${args_SOURCES_PUBLIC}
    PRIVATE   ${args_SOURCES_PRIVATE} )
  target_include_directories( ${target_name}
    INTERFACE ${args_INCLUDE_DIRECTORIES_INTERFACE}
    PUBLIC    ${args_INCLUDE_DIRECTORIES_PUBLIC}
    PRIVATE   ${args_INCLUDE_DIRECTORIES_PRIVATE} )
  target_link_directories( ${target_name}
    INTERFACE ${args_LINK_DIRECTORIES_INTERFACE}
    PUBLIC    ${args_LINK_DIRECTORIES_PUBLIC}
    PRIVATE   ${args_LINK_DIRECTORIES_PRIVATE} )
  target_link_libraries( ${target_name}
    INTERFACE ${args_LINK_LIBRARIES_INTERFACE}
    PUBLIC    ${args_LINK_LIBRARIES_PUBLIC}
    PRIVATE   ${args_LINK_LIBRARIES_PRIVATE} )
  target_link_options( ${target_name}
    INTERFACE ${args_LINK_OPTIONS_INTERFACE}
    PUBLIC    ${args_LINK_OPTIONS_PUBLIC}
    PRIVATE   ${args_LINK_OPTIONS_PRIVATE} )
  target_compile_definitions( ${target_name}
    INTERFACE ${args_COMPILE_DEFINITIONS_INTERFACE}
    PUBLIC    ${args_COMPILE_DEFINITIONS_PUBLIC}
    PRIVATE   ${args_COMPILE_DEFINITIONS_PRIVATE} )
  target_compile_options( ${target_name}
    INTERFACE ${args_COMPILE_OPTIONS_INTERFACE}
    PUBLIC    ${args_COMPILE_OPTIONS_PUBLIC}
    PRIVATE   ${args_COMPILE_OPTINONS_PRIVATE} )
endfunction()
