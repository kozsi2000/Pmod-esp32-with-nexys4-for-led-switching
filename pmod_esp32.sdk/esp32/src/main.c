/*
 * main.c - ESP32 Web Server Client Mode
 * Connects to Wi-Fi and hosts a simple web server.
 */

#include "xparameters.h"
#include "xil_printf.h"
#include "sleep.h"
#include "PmodESP32.h"
#include "stdio.h"
#include "xgpio.h"

#ifdef __MICROBLAZE__
#define HOST_UART_DEVICE_ID XPAR_AXI_UARTLITE_0_BASEADDR
#define HostUart XUartLite
#define HostUart_Config XUartLite_Config
#define HostUart_CfgInitialize XUartLite_CfgInitialize
#define HostUart_LookupConfig XUartLite_LookupConfig
#define HostUart_Recv XUartLite_Recv
#define HostUartConfig_GetBaseAddr(CfgPtr) (CfgPtr->RegBaseAddr)
#include "xuartlite.h"
#include "xil_cache.h"
#else
#define HOST_UART_DEVICE_ID XPAR_PS7_UART_1_DEVICE_ID
#define HostUart XUartPs
#define HostUart_Config XUartPs_Config
#define HostUart_CfgInitialize XUartPs_CfgInitialize
#define HostUart_LookupConfig XUartPs_LookupConfig
#define HostUart_Recv XUartPs_Recv
#define HostUartConfig_GetBaseAddr(CfgPtr) (CfgPtr->BaseAddress)
#include "xuartps.h"
#endif

#define PMODESP32_UART_BASEADDR XPAR_PMODESP32_0_AXI_LITE_UART_BASEADDR
#define PMODESP32_GPIO_BASEADDR XPAR_PMODESP32_0_AXI_LITE_GPIO_BASEADDR

void EnableCaches();
void DisableCaches();
void DemoInitialize();
void DemoRun();
void DemoCleanup();

PmodESP32 myESP32;
HostUart myHostUart;

XGpio led_gpio;

uint16_t led_mask = 0x0;

void driverInit() {
    int Status;
    Status = XGpio_Initialize(&led_gpio, XPAR_AXI_GPIO_0_DEVICE_ID);
    if (Status != XST_SUCCESS) {
        return XST_FAILURE;
    } else {
        XGpio_SetDataDirection(&led_gpio, 1, 0);
    }
}

void DemoInitialize() {
    HostUart_Config *CfgPtr;
    EnableCaches();
    ESP32_Initialize(&myESP32, PMODESP32_UART_BASEADDR, PMODESP32_GPIO_BASEADDR);
    CfgPtr = HostUart_LookupConfig(HOST_UART_DEVICE_ID);
    HostUart_CfgInitialize(&myHostUart, CfgPtr, HostUartConfig_GetBaseAddr(CfgPtr));
}

void LedOn(int led) {
    led_mask |= (1 << led);
    XGpio_DiscreteWrite(&led_gpio, 1, led_mask);
}

void LedOff(int led) {
    led_mask &= ~(1 << led);
    XGpio_DiscreteWrite(&led_gpio, 1, led_mask);
}

void sendCommandAndWait(PmodESP32 *esp32, const char *cmd, int cmd_len, int wait_time_ms) {
    ESP32_SendBuffer(esp32, (u8 *)cmd, cmd_len);
    usleep(wait_time_ms * 1000); // wait_time_ms -> microseconds
}

void processCommand(const char *command) {
    if (strncmp(command, "all_led_on", 10) == 0) {
        xil_printf("Turning all LEDs ON\n");
        for (int i = 0; i < 16; i++) {
            LedOn(i);
        }
    } else if (strncmp(command, "all_led_off", 11) == 0) {
        xil_printf("Turning all LEDs OFF\n");
        for (int i = 0; i < 16; i++) {
            LedOff(i);
        }
    } else if (strncmp(command, "led_", 4) == 0) {
        char *ptr;
        int led_num = strtol(&command[4], &ptr, 10); // Parse LED number
        if (led_num >= 0 && led_num < 16) {
            if (strncmp(ptr, "_on", 3) == 0) {
                xil_printf("Turning LED %d ON\n", led_num);
                LedOn(led_num);
            } else if (strncmp(ptr, "_off", 4) == 0) {
                xil_printf("Turning LED %d OFF\n", led_num);
                LedOff(led_num);
            } else {
                xil_printf("Unknown LED command: %s\n", command);
            }
        } else {
            xil_printf("Invalid LED number: %s\n", command);
        }
    } else {
        xil_printf("Unknown command: %s\n", command);
    }
}

void DemoRun() {
    u8 recv_buffer;
    u32 num_received;
    char command_buffer[128];
    int command_index = 0;
    int client_connected = 0;

    xil_printf("Initializing ESP32 ...\r\n");

    // Reset ESP32
    //xil_printf("Resetting ESP32 (AT+RST)...\r\n");
    //sendCommandAndWait(&myESP32, "AT+RST\r\n", 8, 5000);

    // Set ESP32 to Station Mode
    xil_printf("Setting ESP32 to Station Mode (AT+CWMODE=1)...\r\n");
    sendCommandAndWait(&myESP32, "AT+CWMODE=1\r\n", 13, 5000);

    // Connect to Wi-Fi
    xil_printf("Connecting to Wi-Fi Network (AT+CWJAP)...\r\n");
    sendCommandAndWait(&myESP32, "AT+CWJAP=\"Kozsi\",\"123456789\"\r\n", 34, 10000);

    // Enable multiple connections
    xil_printf("Enabling multiple connections (AT+CIPMUX=1)...\r\n");
    sendCommandAndWait(&myESP32, "AT+CIPMUX=1\r\n", 13, 5000);

    // Start TCP server
    xil_printf("Starting TCP on port 80 (AT+CIPSERVER)...\r\n");
    sendCommandAndWait(&myESP32, "AT+CIPSERVER=1,80\r\n", 19, 5000);

    xil_printf("ESP32 is now running...\r\n");

    driverInit();

    while (1) {
        // Handle terminal input for AT commands if no client is connected
        if (!client_connected) {
            num_received = HostUart_Recv(&myHostUart, &recv_buffer, 1);
            if (num_received > 0) {
                // Send received data to ESP32 but do not echo it back to the terminal
                ESP32_Send(&myESP32, &recv_buffer, 1);
            }
        }

        // Check for data from ESP32
        num_received = ESP32_Recv(&myESP32, &recv_buffer, 1);
        if (num_received > 0) {
            xil_printf("%c", recv_buffer);

            // Check for client connection or disconnection
            if (strstr((char *)&recv_buffer, "0,CONNECT")) {
                xil_printf("Client connected.\n");
                client_connected = 1;
            } else if (strstr((char *)&recv_buffer, "0,CLOSED")) {
                xil_printf("Client disconnected.\n");
                client_connected = 0;
            }

            // Process received data
            if (recv_buffer == '\n' || recv_buffer == '\r') {
                command_buffer[command_index] = '\0'; // Null-terminate the string

                if (strncmp(command_buffer, "+IPD,", 5) == 0) {
                    char *data_start = strchr(command_buffer, ':');
                    if (data_start != NULL) {
                        processCommand(data_start + 1);
                    }
                }

                command_index = 0;
            } else if (command_index < sizeof(command_buffer) - 1) {
                command_buffer[command_index++] = recv_buffer;
            } else {
                xil_printf("Command buffer overflow, resetting...\n");
                command_index = 0;
            }
        }
    }
}


void DemoCleanup() {
    DisableCaches();
}

int main() {
    DemoInitialize();
    DemoRun();
    DemoCleanup();
    return 0;
}

void EnableCaches() {
#ifdef __MICROBLAZE__
#ifdef XPAR_MICROBLAZE_USE_DCACHE
    Xil_DCacheEnable();
#endif
#ifdef XPAR_MICROBLAZE_USE_ICACHE
    Xil_ICacheEnable();
#endif
#endif
}

void DisableCaches() {
#ifdef __MICROBLAZE__
#ifdef XPAR_MICROBLAZE_USE_DCACHE
    Xil_DCacheDisable();
#endif
#ifdef XPAR_MICROBLAZE_USE_ICACHE
    Xil_ICacheDisable();
#endif
#endif
}
