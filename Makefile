CC := gcc
CFLAGS := -Wall `pkg-config --cflags gtk+-3.0`
LIBS := `pkg-config --libs gtk+-3.0`

APP_NAME := app_switcher
SRC_FILES := app_switcher.c

all: $(APP_NAME)

$(APP_NAME): $(SRC_FILES)
	$(CC) $(CFLAGS) -o $(APP_NAME) $(SRC_FILES) $(LIBS)

clean:
	rm -f $(APP_NAME)
