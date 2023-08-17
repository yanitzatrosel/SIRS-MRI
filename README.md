# SIRS-MRI

## Background theory

Stimulus-Induced Rotary Saturation (SIRS) is a potential method to directly measure neuronal current using Bruker MRI (Note: report power of magnet)

## Pulse program

The in

Notes:


x = 0 = $0^\circ$ 

y = 1 = $90^\circ$ 

-x = 2 = $180^\circ$ 

-y = 3 = $270^\circ$ 

Figure 1 shows a pulse sequence for the Spin-Lock block in the pulse sequence for the spin-lattice relaxation time in the rotation frame $T_{1\rho}$. Figure 2 shows the representation of the magnetization vector when the pulse program is applied. 

1. The sample is allowed to come to an equillibium with a delay (d1: 1-5*T1).
1. A $90^\circ$ hard pulse is applied in x direction, which will nutate the resulting magnetization in -y (xy-plane) (note: Charagundla's paper position the magnetization in y direction, but I think this is an error).
1. A phase-shifted spin-lock pulse is applied in -y direction (Note: need to verify this part). TSL corresponds to the duration time for the SL pulse. TSL depends on the T2 value for the tissue of interest (NOTE for myself: check value for brain tissue).
1. A second $90^\circ$ hard pulse is applied in -x direction, which nutate the magnetization in a complex position.



![SIRS-PulseSequence](https://github.com/yanitzatrosel/SIRS-MRI/assets/141436347/46910822-e9e2-44ca-9707-4f773706ab3e)
**Figure 1. Initial block pulse sequence for Spin-Lock**. The experiment is composed of an initial $90^\circ$ hard pulse, followed by a phase-shifted spin-lock pulse, and then a second $90^\circ$ hard pulse.


![MagnetizationVector](https://github.com/yanitzatrosel/SIRS-MRI/assets/141436347/d8964344-f8da-4f78-885f-75c7f13acf05)
**Figure 2. Representation of the magnetization vector for the Spin-Lock sequence**.


## Magentization vector equations for SIRS

First, let's write the magnetization equation for the case when $\vec{B}_{ext}=B_0\hat{z}$, which is in a static field. Block equation:

$$ \frac{d\vec{M}}{dt} = \gamma \vec{M}_x \times \vec{B}_{ext} + \frac{1}{T_1}(M_0 - M_z)\hat{z} - \frac{1}{T_2} \vec{M}_{\perp} $$




