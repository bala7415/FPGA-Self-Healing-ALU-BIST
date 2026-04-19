# FPGA Self-Healing ALU with BIST
### Hardware-verified fault-tolerant computing on Xilinx Nexys4 FPGA
> Project developed in association with **Bharat Electronics Limited (BEL)**

---

## 🔍 Overview
A 4-bit Arithmetic Logic Unit (ALU) with integrated fault detection
and Built-In Self-Test (BIST) mechanism, implemented on a Xilinx
Nexys4 FPGA board. The system detects faulty operations in real-time
and automatically switches to a redundant ALU module — achieving
self-healing without interrupting system operation.

---

## ⚙️ How It Works
- **ALU4bit** — Primary ALU with fault injection input
- **ALU4bitextra** — Redundant backup ALU (always correct)
- **BIST Controller** — XOR-based comparator detects output mismatch
- **MUX (mux8x2x1)** — Switches to backup ALU when fault detected
- **7-Segment Display** — Shows operands and result in real-time
- **Clock Divider + Refresh Counter** — Drives multiplexed display

---

## 🛠️ Tools & Hardware
| Item | Details |
|------|---------|
| HDL Language | Verilog |
| EDA Tool | Xilinx Vivado 2023 |
| FPGA Board | Nexys4 DDR (Artix-7) |
| Display | 7-Segment (BCD output) |
| Verification | Simulation + On-board hardware testing |

---

## 📁 Files
| File | Description |
|------|-------------|
| `ALU4bit.v` | Main top module with all submodules |
| `Self_Cons.xdc` | FPGA pin constraint file |
| `Synaptra-Annexure.docx` | BEL internship project document |

---

## 📸 RTL Schematic — Top Level Block Diagram
![RTL Schematic](RTL_Schematic_Main.jpeg)

---

## 🔧 BIST Controller — XOR Based Fault Detection
![BIST Controller](BIST_Controller_Schematic.jpeg)

---

## 📊 Simulation Waveform
Functional verification showing correct sequential output:

![Simulation Waveform](Simulation_Waveform.jpeg)

---

## 🔴 Hardware Demo — Nexys4 Board
Real-time operation verified on hardware:

**Result: 402**

![Hardware Demo 402](Hardware_Demo_402.jpeg)

**Result: 006**

![Hardware Demo 006](Hardware_Demo_006.jpeg)

---

## ✅ Key Results
- Fault successfully detected via XOR-based BIST comparator
- Automatic switchover to redundant ALU on fault injection
- Correct arithmetic results verified on hardware (ADD, SUB, MUL, AND)
- Real-time BCD output on 7-segment display
- Timing closure achieved in Xilinx Vivado synthesis

---

## 👤 Author
**Balajothi K**
ECE Pre-Final Year — Lovely Professional University
📧 kbalajothikathirvel@gmail.com
🔗 [LinkedIn](https://www.linkedin.com/in/balajothi-kathirvel/)
🐙 [GitHub](https://github.com/bala7415)
