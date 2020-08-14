# Nintendo Switch I2S to S/PDIF

<img alt="Overview" src="/img/overview.jpg">

(Orange LED on the Chord Mojo indicates that it's receiving 48kHz digital sound.)

I2S to S/PDIF conversion on **SiPeed Tang Nano** (GOWIN GW1N-LV1), mainly aims to convert Nintendo Switch's internal sound signal.


## Motivation

According to Nintendo, Switch supports USB DACs. However, it doesn't seem to support UAC 2 and 3 which are somewhat high-end. I've tried to connect all DACs I have but only cheap DACs worked nicely while high-ends didn't. I wonder if Nintendo knows why USB DACs are needed and how Switch's headphone output sounds like.

Full-digital sound output is easily achieved in TV mode. S/PDIF splitter from HDMI signal does it well. But how about non-TV (portable) mode? Only things Switch has are the terrible headphone output and incomplete UAC support.

Now it's the time to steal the digital sound signal directly from Switch.


## Overview

The spec of I2S signal:

 - Sampling rate: 48000 [Hz]
 - Bit depth: 16 [bit]
 - Channels: 2 [ch]
 - Bit clock: 48000 * 16 * 2 * 4 = 6.144 [MHz]

<img alt="Oscilloscope visualized the I2S signal" src="/img/osc.png" width="400px">

 - There is a Realtek ALC5639 (smart amp with I2C controls) in Switch.
 - The SoC (≒ NVIDIA Tegra X1) transmits the sound signal to it in I2S format.

(Off-topic: [NVIDIA Jetson TK1](https://github.com/torvalds/linux/blob/d4db4e553249eda9016fab2e363c26e52c47926f/arch/arm/boot/dts/tegra124-jetson-tk1.dts) has ALC5640 (RT5640) in it. It is close to ALC5639 and has identical footprint. Perhaps Nintendo imitated the design of a evaluation board of NVIDIA.)

The spec of the FPGA board:

 - Board: SiPeed Tang Nano
 - FPGA: GOWIN GW1N-LV1 (LittleBee series)

The protocol of TOSLINK (optical) and coaxial cable (metal) is same. **The RGB LED on Tang Nano is capable of transmitting S/PDIF signal.** Connect a cable to a DAC and press the another side on the LED. Sound should come out. How interesting is it! :nerd_face:


### Step-by-step

1. Disassembly your Switch. [-> iFixit teardown](https://www.ifixit.com/Teardown/Nintendo+Switch+Teardown/78263)

1. Find the chip.

    - Prepare longer wires for convenience and extra length to guide the wires nearby the battery connector.

    <img alt="ALC5639" src="/img/alc5639.jpg" width="400px">

1. Solder wires for BCLK (bit clock), LRCLK (left-right channel clock), and SDATA (serialized data)

    - Solder them VERY CAREFULLY or Switch lose its voice parmanently.
    - Microscope is strongly suggested.

    <img alt="ALC5639 with soldered wires" src="/img/soldered.jpg" width="400px">

1. Guide the wires and connect with Tang Nano somehow

    - There is a tiny free space around the battery connector. Recommend you to guide wires here.
    - Mind your wires not to interfere with other structures.
    - The default pin assign:

    |Pin             | #|
    |:---------------|-:|
    |BCLK in         |29|
    |LRCLK in        |28|
    |SDATA in        |27|
    |S/PDIF out      |38|
    |S/PDIF out (LED)|18|

1. Build the circuitry

    <img alt="Breadboard" src="/img/breadboard.jpg" width="400px">

    - The schematic is TBA
    - By default, the output signal comes out from the pin 38 (for coaxial) and the red LED (for optical / TOSLINK).
    - You can try the optical transmission with NO EXTERNAL PARTS.
    - [Generic TTL-to-SPDIF level converter](https://sound-au.com/project85.htm) uses logic ICs for driver but we can build without the IC.
       - Remove DC offset with a capacitor (0.1uF = 100nF is recommended)
       - Lower the voltage with a voltage divider
           - I've adjusted it with volumes to achieve 0.5Vpp.
           - I'm not sure about output impedance; it works anyways!
           - No problem with shorter cable out there but perhaps longer cable causes problem.

1. Open this repository with GOWIN EDA

1. Run "Synthesize" in the "Process" tab.

1. Run "Place & Route".

1. Program the board with "Program Device". The bitstream should be in "nintendo-switch-i2s-to-spdif/impl/pnr/i2s2spdif.fs".

1. BOOM!

