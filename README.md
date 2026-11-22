
# APB-Based SPI Master IP Core – RTL Design

<p align="center">
  <strong>RTL Design | Verilog HDL | Digital Design | SPI Protocol | APB Interface</strong>
</p>

> 🚧 **Project Status: Work in Progress (WIP)**
>
> This project is currently under development. Individual RTL modules are being designed, simulated, and debugged before complete top-level integration and verification.

## 📌 Project Overview

This project focuses on the RTL design and development of an **APB-Based SPI Master IP Core** using Verilog HDL.

The objective is to develop a modular and reusable SPI Master IP that allows a processor or APB Master to configure and control SPI communication with external peripheral devices through an APB Slave Interface.

The design follows a modular architecture, separating APB communication, SPI clock generation, slave selection, and serial data transmission/reception into individual functional blocks.

The project also aims to understand the complete front-end VLSI design process, including RTL development, functional simulation, debugging, and synthesis.

## 🎯 Project Objectives

- Design an APB Slave Interface for communication with an APB Master.
- Develop a programmable SPI baud rate generator.
- Implement SPI clock generation with configurable CPOL and CPHA.
- Design slave selection and SPI transaction control logic.
- Implement serial data transmission and reception using shift registers.
- Integrate individual modules into a complete SPI Master IP Core.
- Verify functionality through simulation and waveform analysis.

## 🏗️ Architecture

The IP Core is being developed using a modular architecture.

### Major Functional Blocks

| Module | Description |
|---|---|
| APB Slave Interface | Handles APB read/write transactions and register access. |
| Baud Rate Generator | Generates the SPI clock (SCLK) using programmable baud rate settings. |
| Slave Select Controller | Controls SPI slave selection and transaction timing. |
| Shift Register | Handles serial data transmission (MOSI) and reception (MISO). |
| Top-Level Integration | Connects individual modules to develop the complete SPI Master IP. |

### Design Flow

```text
          APB Master
               |
       APB Slave Interface
               |
       Configuration Registers
               |
       +-------+--------+
       |                |
       v                v
 Baud Rate          SPI Control
 Generator           Logic
       |                |
       v                v
      SCLK        Slave Select
       |                |
       +-------+--------+
               |
          Shift Register
               |
          +----+----+
          |         |
         MOSI      MISO
          |         |
          +----+----+
               |
         SPI Peripheral
```

*Note: The architecture represents the intended overall design. Module integration and verification are ongoing.*

## ⚙️ SPI Features

The design targets the following SPI functionalities:

- Configurable Clock Polarity (CPOL).
- Configurable Clock Phase (CPHA).
- MSB-first and LSB-first data transmission.
- Programmable SPI baud rate.
- Serial data transmission through MOSI.
- Serial data reception through MISO.
- Active-low Slave Select (SS).
- Run, Wait, and Stop operating modes.

## 🔧 Baud Rate Generator

The Baud Rate Generator is responsible for generating the SPI serial clock from the system clock (PCLK).

It uses programmable prescaler values:

- SPPR – SPI Baud Rate Prescale.
- SPR – SPI Baud Rate Rate Selection.

The baud rate divisor is calculated as:

\[
BD=(SPPR+1)\times 2^{(SPR+1)}
\]

The generated SPI clock is controlled using the baud rate counter and the selected CPOL configuration.

The module also generates positive-edge and negative-edge timing flags for MOSI transmission and MISO reception.

## 🔄 Shift Register

The Shift Register module handles the serial transmission and reception of SPI data.

### MOSI – Master Out Slave In

- Loads parallel data into the transmit shift register.
- Transmits data serially according to the selected SPI clock edge.
- Supports MSB-first and LSB-first transmission.

### MISO – Master In Slave Out

- Samples incoming serial data from the MISO line.
- Stores received bits into the receive register.
- Supports configurable data ordering and SPI clock phases.

## 🛠️ Tools & Technologies

| Category | Technology |
|---|---|
| HDL | Verilog HDL |
| Design Methodology | RTL Design |
| Simulation | ModelSim |
| Waveform Analysis | ModelSim Wave |
| Version Control | Git & GitHub |

## 🧪 Verification Approach

Each functional block is being developed and tested independently before top-level integration.

The verification process includes:

1. Developing individual RTL modules.
2. Writing dedicated Verilog testbenches.
3. Applying different input configurations and test scenarios.
4. Simulating the RTL design using ModelSim.
5. Analyzing waveforms to identify timing and functional issues.
6. Debugging and refining RTL logic.
7. Performing integrated verification after module completion.

## 📈 Development Progress

The project is currently under development.

| Functional Block | Status |
|---|---|
| Baud Rate Generator | 🔄 Under Development |
| SPI Clock Generation | 🔄 Under Development |
| MOSI Transmission Logic | 🔄 Under Development |
| MISO Reception Logic | 🔄 Under Development |
| Shift Register | 🔄 Under Development |
| Slave Select Controller | ⏳ Pending Integration |
| APB Slave Interface | ⏳ Pending Integration |
| Top-Level Integration | ⏳ Pending |
| Complete Functional Verification | ⏳ Pending |
| RTL Synthesis | ⏳ Planned |

*Progress will be updated as individual modules are completed and verified.*

## 🚀 Future Work

The following activities are planned for subsequent development stages:

- Complete and verify all individual RTL modules.
- Implement APB register read/write functionality.
- Integrate the APB interface with the SPI Master controller.
- Perform complete end-to-end SPI communication verification.
- Verify different combinations of CPOL and CPHA.
- Test different baud rate configurations.
- Perform RTL synthesis and analyze the synthesized design.
- Optimize the design for improved hardware efficiency.

## 📚 Learning Outcomes

Through this project, the focus is on gaining practical experience in:

- Modular RTL architecture and design.
- Verilog HDL coding practices.
- Synchronous sequential circuit design.
- Finite State Machine (FSM) implementation.
- Serial communication protocols.
- Clock generation and edge detection.
- Functional verification and waveform debugging.
- Front-end VLSI design methodology.

## 👨‍💻 Author

**Sidhant Borkar**

B.Tech – Electronics & Telecommunication Engineering

Interested in RTL Design, Digital Design, FPGA and VLSI Design.

- GitHub: [@sidhantborkar16](https://github.com/sidhantborkar16)
- Portfolio: [sidhantborkar.vercel.app](https://sidhantborkar.vercel.app/)

---

⭐ If you find this project interesting, feel free to explore the repository.

**Note:** This repository is actively being developed. Design updates, simulation results, and verification details will be added progressively.
