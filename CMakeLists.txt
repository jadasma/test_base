cmake_minimum_required(VERSION 3.16)

project(projet_quickget VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Sql)


qt_add_executable(appprojet_quickget
    main.cpp
    Images.qrc
)

qt_add_qml_module(appprojet_quickget
    URI projet_quickget
    VERSION 1.0
    QML_FILES
        Main.qml
        SOURCES Databasehandler.cpp
        SOURCES DatabaseHandler.h
        RESOURCES Images.qrc
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appprojet_quickget PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appprojet_quickget
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appprojet_quickget
    PRIVATE Qt6::Quick
    PRIVATE Qt6::Sql
    PRIVATE Qt6::Core
)

include(GNUInstallDirs)
install(TARGETS appprojet_quickget
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
