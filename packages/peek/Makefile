CXXFLAGS=-shared -fPIC --no-gnu-unique -Wall -Wextra -DWLR_USE_UNSTABLE -std=c++2b -O2
INCLUDES=`pkg-config --cflags pixman-1 libdrm hyprland pangocairo libinput libudev wayland-server xkbcommon lua`
SRC=$(wildcard src/*.cpp)
TARGET=peek.so

all: $(TARGET)

$(TARGET): $(SRC)
	$(CXX) $(CXXFLAGS) $(INCLUDES) $(SRC) -o $(TARGET)

clean:
	rm -f $(TARGET)

.PHONY: all clean
