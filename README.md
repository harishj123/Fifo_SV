
---

# 📦 FIFO Verification Using SystemVerilog

**SystemVerilog | Functional Verification | EDA Playground**

---

## 📌 Project Overview

This repository contains a **SystemVerilog-based verification environment** developed to verify a **parameterized FIFO (First-In First-Out)** design.

The verification environment validates:

* Correct **data ordering**
* Proper **full and empty flag behavior**
* Handling of **overflow and underflow conditions**
* Correct operation during **simultaneous read and write**

This project demonstrates **real-world FIFO verification scenarios** and is suitable for **interview and learning purposes**.

---

## 🧠 Design Under Test (DUT)

* **Module:** FIFO
* **Features:**

  * Parameterized `DATA_WIDTH`, `DEPTH`, and `ADDR_WIDTH`
  * Synchronous active-low reset
  * Independent read and write enable signals
  * Status flags:

    * `full`
    * `empty`
    * `almost_full`
    * `almost_empty`
    * `overflow`
    * `underflow`

---

## 🗂️ Project Structure

```
├── design.sv                          # FIFO DUT
├── testbench.sv                      # Top-level testbench
├── clock_gen.sv                      # Clock generation
├── reset_gen.sv                      # Reset generation
├── basic_write_read_test.sv          # Basic FIFO write/read test
├── underflow_test.sv                 # Underflow condition test
├── overflow_test.sv                  # Overflow condition test
├── simultaneous_read_write_empty_test.sv  # Simultaneous R/W when empty
├── simultaneous_read_write_full_test.sv   # Simultaneous R/W when full
├── reset_test.sv                     # Reset behavior verification
```

---

## ⚙️ Verification Components

* **Clock Generator** – Generates system clock
* **Reset Generator** – Applies synchronous active-low reset
* **Test Classes** – Individual test scenarios for FIFO behavior
* **Testbench** – Instantiates DUT and connects all components

---

## ✅ Verification Strategy

* Apply reset to initialize FIFO
* Perform controlled **write and read operations**
* Validate FIFO behavior under:

  * Normal conditions
  * Boundary conditions (full & empty)
  * Error conditions (overflow & underflow)
* Check correctness of:

  * Output data
  * Status flags
  * Pointer movement and count logic

---

## 🧪 Test Scenarios Covered

* ✅ Reset functionality
* ✅ Basic write and read operation
* ✅ FIFO full condition
* ✅ FIFO empty condition
* ✅ Overflow detection
* ✅ Underflow detection
* ✅ Simultaneous read/write when FIFO is empty
* ✅ Simultaneous read/write when FIFO is full

---

## 🎯 Key Concepts Demonstrated

* SystemVerilog testbench design
* Modular test-case based verification
* Boundary condition testing
* Error handling (overflow & underflow)
* Reusable and scalable verification structure

---

## ▶️ Simulation

This project is simulated using **EDA Playground**.

Example command (tool-dependent):

```bash
vsim -c testbench -do "run -all"
```

---
