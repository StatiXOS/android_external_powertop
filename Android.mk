LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := powertop

LOCAL_MODULE_TAGS := debug
LOCAL_SHARED_LIBRARIES := libnl libncurses

CSSTOH_SOURCE := $(LOCAL_PATH)/src/csstoh.c
POWERTOP_CSS_SOURCE := $(LOCAL_PATH)/src/powertop.css
GEN_CSSTOH := $(LOCAL_PATH)/src/csstoh.sh
GEN_CSS_H := $(LOCAL_PATH)/src/css.h
$(GEN_CSS_H):
	./$(GEN_CSSTOH) $(POWERTOP_CSS_SOURCE) $@

LOCAL_GENERATED_SOURCES += $(GEN_CSS_H)

#LOCAL_CFLAGS += -Wall -O2 -g -fno-omit-frame-pointer -fstack-protector -Wshadow -Wformat -D_FORTIFY_SOURCE=2
#LOCAL_CPPFLAGS += -Wall -O2 -g -fno-omit-frame-pointer

LOCAL_CFLAGS += -DHAVE_LIBNL20
LOCAL_CPPFLAGS += -DPACKAGE_VERSION=\"2.8\" -DPACKAGE=powertop -DHAVE_LIBNL20 -DDISABLE_TRYCATCH -DHAVE_NO_PCI

LOCAL_C_INCLUDES += bionic \
	external/libnl/include/ \
	external/ncurses/include \
	$(LOCAL_PATH)/src \
	$(LOCAL_PATH)/traceevent

LOCAL_SRC_FILES += \
	src/parameters/parameters.cpp \
	src/parameters/persistent.cpp \
	src/parameters/learn.cpp \
	src/process/powerconsumer.cpp \
	src/process/work.cpp \
	src/process/process.cpp \
	src/process/timer.cpp \
	src/process/processdevice.cpp \
	src/process/interrupt.cpp \
	src/process/do_process.cpp \
	src/cpu/intel_cpus.cpp \
	src/cpu/intel_gpu.cpp \
	src/cpu/cpu.cpp \
	src/cpu/cpu_linux.cpp \
	src/cpu/cpudevice.cpp \
	src/cpu/cpu_core.cpp \
	src/cpu/cpu_package.cpp \
	src/cpu/abstract_cpu.cpp \
	src/cpu/cpu_rapl_device.cpp \
	src/cpu/dram_rapl_device.cpp \
	src/cpu/rapl/rapl_interface.cpp \
	src/measurement/measurement.cpp \
	src/measurement/acpi.cpp \
	src/measurement/extech.cpp \
	src/measurement/sysfs.cpp \
        src/measurement/opal-sensors.cpp \
	src/display.cpp \
	src/report/report.cpp \
	src/report/report-maker.cpp \
	src/report/report-formatter-base.cpp \
	src/report/report-formatter-csv.cpp \
	src/report/report-formatter-html.cpp \
	src/report/report-data-html.cpp \
	src/main.cpp \
	src/tuning/tuning.cpp \
	src/tuning/tuningi2c.cpp \
	src/tuning/tuningusb.cpp \
	src/tuning/bluetooth.cpp \
	src/tuning/ethernet.cpp \
	src/tuning/runtime.cpp \
	src/tuning/iw.c \
	src/tuning/tunable.cpp \
	src/tuning/tuningsysfs.cpp \
	src/tuning/wifi.cpp \
	src/perf/perf_bundle.cpp \
	src/perf/perf.cpp \
	src/devices/thinkpad-fan.cpp \
	src/devices/alsa.cpp \
	src/devices/runtime_pm.cpp \
	src/devices/usb.cpp \
	src/devices/ahci.cpp \
	src/devices/rfkill.cpp \
	src/devices/thinkpad-light.cpp \
	src/devices/i915-gpu.cpp \
	src/devices/backlight.cpp \
	src/devices/network.cpp \
	src/devices/device.cpp \
	src/devices/gpu_rapl_device.cpp \
	src/devices/devfreq.cpp \
	src/devlist.cpp \
	src/calibrate/calibrate.cpp \
	src/lib.cpp \
	traceevent/event-parse.c \
	traceevent/parse-filter.c \
	traceevent/parse-utils.c \
	traceevent/trace-seq.c

LOCAL_SRC_FILES += \
	glob/glob.c
LOCAL_C_INCLUDES += $(LOCAL_PATH)/glob

systemimage: powertop
include $(BUILD_EXECUTABLE)
