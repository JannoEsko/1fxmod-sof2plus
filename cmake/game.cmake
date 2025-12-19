
set(GAME_LIB "sof2mp_game")

set(GAME_SOURCES 
    ${SOURCE_DIR}/game/g_main.c
    ${SOURCE_DIR}/game/1fx_gt.c
    ${SOURCE_DIR}/game/ai_main.c
    ${SOURCE_DIR}/game/ai_util.c
    ${SOURCE_DIR}/game/ai_wpnav.c
    ${SOURCE_DIR}/game/bg_gametype.c
    ${SOURCE_DIR}/game/bg_misc.c
    ${SOURCE_DIR}/game/bg_player.c
    ${SOURCE_DIR}/game/bg_pmove.c
    ${SOURCE_DIR}/game/bg_slidemove.c
    ${SOURCE_DIR}/game/bg_weapons.c
    ${SOURCE_DIR}/game/boe_admcmds.c
    ${SOURCE_DIR}/game/boe_utils.c
    ${SOURCE_DIR}/game/g_active.c
    ${SOURCE_DIR}/game/g_admcmds.c
    ${SOURCE_DIR}/game/g_antilag.c
    ${SOURCE_DIR}/game/g_bot.c
    ${SOURCE_DIR}/game/g_client.c
    ${SOURCE_DIR}/game/g_cmds.c
    ${SOURCE_DIR}/game/g_combat.c
    ${SOURCE_DIR}/game/g_gametype.c
    ${SOURCE_DIR}/game/g_items.c
    ${SOURCE_DIR}/game/g_mem.c
    ${SOURCE_DIR}/game/g_misc.c
    ${SOURCE_DIR}/game/g_missile.c
    ${SOURCE_DIR}/game/g_mover.c
    ${SOURCE_DIR}/game/g_mvchat.c
    ${SOURCE_DIR}/game/g_refcmds.c
    ${SOURCE_DIR}/game/g_session.c
    ${SOURCE_DIR}/game/g_spawn.c
    ${SOURCE_DIR}/game/g_svcmds.c
    ${SOURCE_DIR}/game/g_syscalls.c
    ${SOURCE_DIR}/game/g_target.c
    ${SOURCE_DIR}/game/g_tcmds.c
    ${SOURCE_DIR}/game/g_team.c
    ${SOURCE_DIR}/game/g_trigger.c
    ${SOURCE_DIR}/game/g_utils.c
    ${SOURCE_DIR}/game/g_vote.c
    ${SOURCE_DIR}/game/g_weapon.c
    ${SOURCE_DIR}/game/henkENT.c
    ${SOURCE_DIR}/game/henk_functions.c
    ${SOURCE_DIR}/game/henk_hs.c
    ${SOURCE_DIR}/game/q_math.c
    ${SOURCE_DIR}/game/q_shared.c
    ${SOURCE_DIR}/game/rocmod_functions.c
    ${SOURCE_DIR}/game/rpm_functions.c

    
    ${SOURCE_DIR}/game/sqlite/sqlite3.c
    
)

add_library(${GAME_LIB} SHARED ${GAME_SOURCES})

target_link_libraries(${GAME_LIB} PRIVATE ${COMMON_LIBRARIES})

file(MAKE_DIRECTORY "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")

set_target_properties(${GAME_LIB} PROPERTIES
    OUTPUT_NAME "${GAME_LIB}${ARCH}"
    PREFIX ""
    ARCHIVE_OUTPUT_NAME ""
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}"
    LIBRARY_OUTPUT_DIRECTORY_RELEASE "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}"
    LIBRARY_OUTPUT_DIRECTORY_DEBUG "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}"

    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}"
    RUNTIME_OUTPUT_DIRECTORY_RELEASE "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}"
    RUNTIME_OUTPUT_DIRECTORY_DEBUG "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}"
)


