cmake_minimum_required(VERSION 3.18)

if(POLICY CMP0177)
    # Policy CMP0177: install() DESTINATION paths are normalized
    # Introduced in CMake 3.31
    cmake_policy(SET CMP0177 NEW)
endif()

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
include(identity)

project(${PROJECT_NAME} VERSION ${PROJECT_VERSION} LANGUAGES C)

option(FORCE_32BIT "Build the mod in x86 mode" OFF)
option(BUILD_GOLD "Build 1fxmod for Gold (1.03)" OFF)
option(BUILD_DEMO "Build 1fxmod for Demo (1.02t)" OFF)
option(BUILD_DEV "Include _DEV preprocessor" OFF)
option(BUILD_PRE "Include _PRE preprocessor" OFF)
option(BUILD_3DSERVER "Include _3DServer preprocessor" OFF)
option(BUILD_NIGHTLY "Include _NIGHTLY preprocessor" OFF)

# Release build by default, set externally if you want something else
if(NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_SHARED_LIBRARY_PREFIX "")

set(CMAKE_USE_RELATIVE_PATHS TRUE)

if(NOT PRODUCT_VERSION)
    set(PRODUCT_VERSION "${CMAKE_PROJECT_VERSION}")

    if(EXISTS "${CMAKE_SOURCE_DIR}/.git")
        execute_process(
            COMMAND git show -s --pretty=format:%h
            WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
            OUTPUT_VARIABLE GIT_REV
            OUTPUT_STRIP_TRAILING_WHITESPACE
            ERROR_QUIET)

        if(GIT_REV)
            set(PRODUCT_VERSION "${PRODUCT_VERSION}_g${GIT_REV}")
        endif()
    endif()
endif()

add_compile_definitions(PRODUCT_VERSION="${PRODUCT_VERSION}")
add_compile_definitions(
        $<$<CONFIG:Debug>:_DEBUG>
        $<$<CONFIG:Debug>:DEBUG>
        $<$<CONFIG:Release>:NDEBUG>
        QAGAME
        _SOF2
)

if(BUILD_GOLD AND BUILD_DEMO)
  message( FATAL_ERROR "You cannot build Gold and Demo mod at the same time." )
endif()

if(BUILD_GOLD)
  add_compile_definitions(_GOLD)
endif()

if (BUILD_DEMO)
  add_compile_definitions(_DEMO)
endif()

if(BUILD_DEV)
  add_compile_definitions(_DEV)
endif()

if(BUILD_PRE)
  add_compile_definitions(_PRE)
endif()

if(BUILD_3DSERVER)
  add_compile_definitions(_3DServer)
endif()

if(BUILD_NIGHTLY)
  add_compile_definitions(_NIGHTLY)
endif()

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG   ${CMAKE_BINARY_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG   ${CMAKE_BINARY_DIR})
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR})

# For CI to read from
file(GENERATE OUTPUT ${CMAKE_BINARY_DIR}/version.txt CONTENT ${PRODUCT_VERSION})

if(DEFINED ENV{SOURCE_DATE_EPOCH})
    string(TIMESTAMP PRODUCT_DATE "%b %d %Y" UTC)
    add_compile_definitions(PRODUCT_DATE="${PRODUCT_DATE}")
endif()

set(SOURCE_DIR ${CMAKE_SOURCE_DIR}/trunk)

if(FORCE_32BIT)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -m32")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m32")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -m32")
    set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -m32")
    set(ARCH "x86")
endif()

include(utils/arch)
include(compilers/all)
include(platforms/all)

include(game)

include(post_configure)
