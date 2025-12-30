cmake_minimum_required(VERSION 3.16)

project(SingleInstance VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC on)
set(CMAKE_AUTORCC on)
set(CMAKE_INCLUDE_CURRENT_DIR on)

set(APP_URI "com.saif.${PROJECT_NAME}")
set(AppIcon "${CMAKE_CURRENT_SOURCE_DIR}/icon.rc")

###### preprocessor macro's ######
add_definitions(-DPROJECT_NAME="${PROJECT_NAME}")
add_definitions(-DPROJECT_VERSION="${PROJECT_VERSION}")
add_definitions(-DORGANIZATION_NAME="SaifDev")
add_definitions(-DORGANIZATION_DOMAIN="${APP_URI}")
####################################

find_package(Qt6 REQUIRED COMPONENTS Quick Core Gui QuickControls2)

qt_standard_project_setup()

qt_add_executable(${PROJECT_NAME}
    main.cpp
    ${AppIcon}
    # cpp
    "cpp/run_guard.h"
    "cpp/run_guard.cpp"


    # Res
    res.qrc
)

qt_policy(SET QTP0001 NEW)

qt_add_qml_module(${PROJECT_NAME} URI ${APP_URI} VERSION 1.0
    QML_FILES
    "Main.qml"

    # qml
    "qml/RunGuardWindow.qml"
    "qml/CDialog.qml"


    #Java Script


    # cpp
    SOURCES


)

set_target_properties(${PROJECT_NAME} PROPERTIES
    #    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.${PROJECT_NAME}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
    # QT_ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android"
)

target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt6::Quick
    Qt6::Core
    Qt6::Gui
    Qt6::QuickControls2

)

include(GNUInstallDirs)
install(TARGETS ${PROJECT_NAME}
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
