# SIRS-MRI

## Background theory

Stimulus-Induced Rotary Saturation (SIRS) is a potential method to directly measure neuronal current using  7T Bruker MRI.

## Pulse program

Notes:

* x = 0 = $0^\circ$
* y = 1 = $90^\circ$ 
* -x = 2 = $180^\circ$ 
* -y = 3 = $270^\circ$ 

Figure 1 shows a pulse sequence for the Spin-Lock block in the pulse sequence for the spin-lattice relaxation time in the rotation frame $T_{1\rho}$. Figure 2 shows the representation of the magnetization vector when the pulse program is applied. 

1. The sample is allowed to come to an equillibium with a delay (d1: 1-5*T1).
1. A $90^\circ$ hard pulse is applied in x direction, which will nutate the resulting magnetization in -y (xy-plane) (note: Charagundla's paper position the magnetization in y direction, but I think this is an error).
1. A phase-shifted spin-lock pulse is applied in -y direction (Note: need to verify this part). TSL corresponds to the duration time for the SL pulse. TSL depends on the T2 value for the tissue of interest.
1. A second $90^\circ$ hard pulse is applied in -x direction, which nutate the magnetization in a complex position.


![SIRS-PulseSequence](https://github.com/yanitzatrosel/SIRS-MRI/assets/141436347/ab3124a7-fe83-427c-8636-1f99ccc9256b)
**Figure 1. Initial block pulse sequence for Spin-Lock**. The experiment is composed of an initial $90^\circ$ hard pulse, followed by a phase-shifted spin-lock pulse, and then a second $90^\circ$ hard pulse. Note: I think the SL should be applied in -y direction.


![MagnetizationVector](https://github.com/yanitzatrosel/SIRS-MRI/assets/141436347/649cc293-d46f-4fe1-8719-77a4c960fbd9)
**Figure 2. Representation of the magnetization vector for the Spin-Lock sequence**.

Note for myself: Charagundla and coworkers suggested a phase-shifted SL pulse, with the purpose of removing artifacts. However, I will start with the basic pulse program and then increase complexity. 

## TSL values

Test with the values: 50 to 400 ms.

## $B_{SL}$

Try values between 10-100 Hz.


## Magnetization vector equations for $\vec{B}_{ext}=B_0\hat{z}$

First, let's write the magnetization equation for the case when $\vec{B}_{ext}=B_0\hat{z}$, which is in a static field. Block equation:

$`\frac{d\vec{M}}{dt} = \gamma \vec{M} \times \vec{B}_{ext} + \frac{1}{T_1}(M_0 - M_z)\hat{z} - \frac{1}{T_2} \vec{M}_{\perp}`$,

where $`\vec{M}_{\perp} = M_x\hat{x} + M_y\hat{y} `$. Assuming $\vec{B}_{ext}=B_0\hat{z}$ then Block equation can be rewritten as,

$` \frac{d\vec{M}}{dt} = \omega_0 M_y \hat{x} - \omega_0 M_x \hat{x} + \frac{1}{T_1}(M_0 - M_z)\hat{z} - \frac{1}{T_2} (M_x\hat{x} + M_y\hat{y}) `$, 

where $\omega_0 = \gamma B_0$. Rewritting the differential equations for each component, and changing variable to $M_x = m_x e^{-t/T_2}$ and $M_y = m_y e^{-t/T_2}$, the solution for Block equations in a static field orientated in z direction are:

1. $` M_x(t) = e^{-t/T_2} [M_x(0)\cos(\omega_0 t) + M_y(0)\sin(\omega_0 t)] `$
1. $` M_y(t) = e^{-t/T_2} [M_y(0)\cos(\omega_0 t) - M_x(0)\sin(\omega_0 t)] `$
1. $` M_z(t) = M_z(0) e^{-t/T_1} + M_0 (1 - e^{-t/T_1}) `$

At the equilibrium limit $M_x(\infty) = M_y(\infty) = 0$ and $M_z(\infty) = M_0$. 

Note: $T_1$ is the longitudinal relaxation also known as the spin-lattice relaxation time. $T_2$ iis the transversal relaxation or spin-spin relaxation time. Some known values for $T_1$ and $T_2$ measured at $37^\circ$ and in 1.5 $T$. 

Gray Matter: $T_1 = 950 ms$ and $T_2 = 100 ms$

White matter: $T_1 = 600 ms$ and $T_2 = 80 ms$

## Magnetization vector equations for SIRS

The normalized intial magnetization under thermal equilibrium is $M_x=0$, $M_y=0$, and $M_z=1$, as shown in previous section. 

As the SL pulse is applied, the magnetization will end in a complex orientation, such as 

1. $` M_x=0 `$
2. $` M_y=0 `$
3. $` M_z=\sin^2(\theta) \exp(-TSL/T_{1\rho}) + \cos^2(\theta) \cos(\alpha) \exp(-TSL/T_{2\rho}) `$

Where $\theta = \gamma B_1 \tau$ and $\alpha = \omega_{1y} TSL = P\gamma B_1 TSL$. $B_1$ is the maximun rf amplitude, $\tau$ is the duration of the $90^\circ$ pulse, and P is the fraction parameter of the maximun rf amplitude $B_1$. Calculation can be found in Charagundla and coworkers' paper [1]. If $\theta$ is calibrated to be a $\pi/2$ pulse, the longitudinal magnetization is

$` M_z = exp(-TSL/T_{1\rho}) `$

However, this last expression is hardly true since it would requiere an homogeneous $B_1$ throughout the whole sample.

![CharagundlaMagPLOT](https://github.com/yanitzatrosel/SIRS-MRI/assets/141436347/cbc7095f-b292-4e5b-9850-ebe72cf52d19)
**Figure 3. Longitudinal magnetization for equation 3 in this section**. The parameters and Matlab code are [here](https://github.com/yanitzatrosel/SIRS-MRI/blob/main/CharagundlaMagPLOT.m).


## Magnetization vector for steady-state sequence

We start with the Block equation:

$`\frac{d\vec{M}}{dt} = \gamma \vec{M} \times \vec{B}_{ext} + \frac{1}{T_1}(M_0 - M_z)\hat{z} - \frac{1}{T_2} \vec{M}_{\perp}`$

and we want to solve for $\vec{V}_{ext} = B_0 \hat{z} + B_1 \hat{x}'$, which it is for the case when rf field is applied in addition to the static external field to tip the magnetization $\vec{M}$. The effective magnetic field will be the external magnetic field minus the 'reduced magnetic field' ($\omega/\gamma$), meaning

$` \vec{B}_{eff} = \left(B_0 - \frac{\omega}{\gamma} \right)\hat{z} + B_1 \hat{x}' `$. 

Then for the term $`\vec{M} \times \vec{B}_{ext} = \vec{M} \times \vec{B}_{eff}`$, which is

$` \vec{M} \times \vec{B}_{eff} = M_{y'}(B_0 - \frac{\omega}{\gamma})\hat{x} - [M_{x'}(B_0 - \frac{\omega}{\gamma}) - M_zB_{1x'}]\hat{y} - M_{y'}B_{1x'}\hat{z} `$,

Replacing in Bloch equation and separating by component,

1. $` \left( \frac{dM_x}{dt} \right)' = \Delta \omega M_{y'} - \frac{M_{x'}}{T_2} = 0 `$
2. $` \left( \frac{dM_y}{dt} \right)' = M_z \omega_1 - \Delta \omega M_{x'} - \frac{M_{y'}}{T_2} = 0 `$
3. $` \left( \frac{dM_z}{dt} \right)' = - M_y \omega_1 + \frac{M_0 - M_z}{T_1} = 0 `$

with $` \omega_1 \def \gamma B_{1x'} `$ and $` \Delta \omega \def \gamma B_0 - \omega \def \omega_0 - \omega `$.

## How EPI works

## References

1. Charagundla, S. R., Borthakur, A., Leigh, J. S., & Reddy, R. (2003). Artifacts in T1ρ-weighted imaging: correction with a self-compensating spin-locking pulse. Journal of Magnetic Resonance, 162(1), 113-121.
2. Borthakur, A., Hulvershorn, J., Gualtieri, E., Wheaton, A. J., Charagundla, S., Elliott, M. A., & Reddy, R. (2006). A pulse sequence for rapid in vivo spin‐locked MRI. Journal of Magnetic Resonance Imaging: An Official Journal of the International Society for Magnetic Resonance in Medicine, 23(4), 591-596.
3. Witzel, T., Lin, F. H., Rosen, B. R., & Wald, L. L. (2008). Stimulus-induced Rotary Saturation (SIRS): a potential method for the detection of neuronal currents with MRI. Neuroimage, 42(4), 1357-1365.
4. Brown, R. W., Cheng, Y. C. N., Haacke, E. M., Thompson, M. R., & Venkatesan, R. (2014). Magnetic resonance imaging: physical principles and sequence design. John Wiley & Sons.


