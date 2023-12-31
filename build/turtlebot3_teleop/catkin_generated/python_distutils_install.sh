#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/ingeolko/turtlebot3-master/turtlebot3_teleop"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/ingeolko/turtlebot3-master/install/turtlebot3_teleop/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/ingeolko/turtlebot3-master/install/turtlebot3_teleop/lib/python2.7/dist-packages:/home/ingeolko/turtlebot3-master/build/turtlebot3_teleop/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/ingeolko/turtlebot3-master/build/turtlebot3_teleop" \
    "/usr/bin/python2" \
    "/home/ingeolko/turtlebot3-master/turtlebot3_teleop/setup.py" \
     \
    build --build-base "/home/ingeolko/turtlebot3-master/build/turtlebot3_teleop" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/ingeolko/turtlebot3-master/install/turtlebot3_teleop" --install-scripts="/home/ingeolko/turtlebot3-master/install/turtlebot3_teleop/bin"
