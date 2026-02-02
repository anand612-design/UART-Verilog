# UART Implementation in Verilog HDL

## 📌 Overview
This project implements a complete UART (Universal Asynchronous Receiver Transmitter)
using Verilog HDL. The design includes a baud rate generator, UART transmitter,
UART receiver, and a top module integrating all components.

The functionality is verified through simulation using self-written testbenches.

---

## ⚙️ Features
- 8-bit data
- No parity (8N1 format)
- 1 start bit, 1 stop bit
- Parameterized baud rate generator
- Fully synthesizable RTL
- Verified using waveform-based simulation

---

## 🧩 Block Diagram
![UART Block Diagram](docs/UART_Block_Diagram.png)

---

## 🧠 Design Description

### Baud Rate Generator
Generates TX and RX enable ticks based on the system clock to ensure correct bit timing.

### UART Transmitter
- FSM-based design
- Transmits start bit, data bits (LSB first), and stop bit
- Output verified using waveform inspection

### UART Receiver
- Oversampling-based reception
- Detects start bit, samples data bits, and validates stop bit

---

## 🧪 Simulation & Verification
Simulation was performed using Verilog testbenches.
Waveforms were analyzed to verify:
- Correct baud timing
- Proper framing (start, data, stop bits)
- Correct data transmission and reception

📸 Sample Waveforms:
- UART TX waveform
- UART RX waveform
- Baud rate tick generation

(See `waveforms/` folder)

---

## ▶️ How to Run Simulation
1. Compile RTL and testbench files
2. Run simulation
3. Open waveform dump using GTKWave or ModelSim
4. Observe TX/RX timing and data correctness

---

## 📂 Repository Structure
- `rtl/` : UART RTL modules
- `tb/`  : Testbenches
- `waveforms/` : Simulation proof
- `docs/` : Block diagrams and FSMs

---

## 📌 Key Learnings
- UART protocol and timing constraints
- FSM-based digital design
- Inertial delay and simulation concepts
- Verification using waveform analysis

---

## 👤 Author
**Anand Ambadkar**  
Electronics & Telecommunication Engineering  
