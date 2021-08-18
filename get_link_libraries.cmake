
# Get the `LINK_LIBRARIES` property (if possible).
#
# ```
# get_link_libraries( <VAR> <TargetName> )
# ```
#
# Calls `get_target_property(... LINK_LIBRARIES)` if `<TargetName>` is a valid
# target (i.e. `<TargetName>` is a target with the `LINK_LIBRARIES` property).
#
# Returns `<TargetName>-NOTFOUND` if `<TargetName> is not a target or the
# `LINK_LIBRARIES` property doesn't exist. Outputs the result to variable
# `<VAR>`.
#
function(get_link_libraries OutVar TargetName)
  set(_result ${TargetName}-NOTFOUND)

  if(TARGET ${TargetName})
    get_target_property(Type ${TargetName} TYPE)
    if(NOT ${Type} STREQUAL "INTERFACE_LIBRARY")
      get_target_property( _result ${TargetName} LINK_LIBRARIES )
    endif()
  endif()

  set( ${OutVar} ${_result} PARENT_SCOPE )
endfunction()



# Recursively get all LINK_LIBRARIES
#
# ```
# get_link_libraries_recursive( <VAR> <TargetName> )
# ```
#
# Recursively calls `get_target_property(... LINK_LIBRARIES)`, starting with
# the `LINK_LIBRARIES` of `<TargetName>`. Outputs result to variable `<VAR>`.
#
function(get_link_libraries_recursive Var TargetName)
  set( result )
  get_target_property( Unseen ${TargetName} LINK_LIBRARIES )

  while( Unseen )
    list( APPEND result ${Unseen} )

    # Recurse: enumerate LINK_LIBRARIES for all ${Unseen}
    set(MoreUnseen)
    foreach( Lib ${Unseen} )

      # Visit Lib's LINK_LIBRARIES in the next iteration.
      get_link_libraries( LibLibs ${Lib} )

      # Check that LibLibs is a TRUE value (can be LibLibs-NOTFOUND which
      # breaks the loop early if appended to a non-empty list)
      if(LibLibs)
        list(APPEND MoreUnseen ${LibLibs})
      endif()

    endforeach()

    # Iterate
    set( Unseen ${MoreUnseen} )
  endwhile()

  list( REMOVE_DUPLICATES result )
  set( ${Var} ${result} PARENT_SCOPE )
endfunction()
