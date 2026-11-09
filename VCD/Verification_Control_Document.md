# Verification Control Document (VCD)

**Document Number:** EWAS-HSB-VCD-01  
**Issue:** 0.1  
**Date:** 09.11.2026  
**Configuration Item:** CI-03 Space Segment (SSEG, WBS 123456.03); programme-level CI number 00  
**Status:** Verification planning baseline - all entries Open

This document is the Markdown companion to the standalone programme-level Verification Control Document. It contains the detailed verification descriptions for all 75 requirements assigned Test (T) or Analysis (A). The full VCD control matrix, applicable/reference documents, GSE catalogue and compliance summary are in the LaTeX/PDF issue.

## 1. Purpose, Scope, and Verification Status

This issue covers Configuration Item CI-03, the EWAS Space Segment (SSEG, WBS 123456.03). It records the verification method assigned to every technical requirement of Section 7 of the Space Segment Technical Requirements Specification (EWAS-HSB-SSEG-TRS-03) and provides detailed verification descriptions for every requirement carrying a Test (T) or Analysis (A) method. All entries are issued with status **Open**; no verification credit is claimed.

## 2. Verification Methods, Conventions, and Evidence Rules

The VCD applies the four formal verification methods of ECSS-E-ST-10-02C (AD-04): Test (T), Analysis (A), Review of Design (R), and Inspection (I). Where a requirement carries more than one method, the detailed entry identifies the primary Test or Analysis activity and records the supporting R or I evidence separately.

## 3. Verification Articles and Ground Support Equipment

The model philosophy comprises the Engineering Model (EM), Structural-Thermal Model (STM), Qualification/Proto-Flight Model (QM/PFM), and Flight Model (FM). Verification phases follow the life profile of TRS Section 5 (Phases 1-6). The ground support equipment catalogue comprises EGSE-01 to EGSE-10, MGSE-01 to MGSE-09, and OGSE-01 to OGSE-08.

## 4. Verification Method Summary

| Method set | Requirements |
|---|---:|
| Test only (T) | 8 |
| Test with supporting R or I | 16 |
| Analysis only (A) | 8 |
| Analysis with supporting R or I | 6 |
| Combined Test and Analysis (T, A) | 37 |
| Review of Design only (R) | 2 |
| Total requirements | 77 |
| Requirements with a detailed T/A entry | 75 |

## 5. Detailed Verification Descriptions

### 5.1 Functional and Mission Scope Requirements (TRS Section 7.1)

### Requirement Verification: SSEG-REQ-FUN-003 - Dual-Tier Detection and Stereoscopic Tracking Chain

* **Requirement Text**: "The SSEG shall execute continuous boost-phase infrared detection via the GEO layer (SATG), route tracking commands via the mandatory ISL network, execute cued dual-satellite stereoscopic tracking via the LEO layer (SATL), compute an onboard preliminary 3D trajectory estimate, and downlink both timestamped LOS observation packages and the preliminary trajectory estimate to the Ground Segment (WBS 123456.02)."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: EM HIL benches and QM/PFM spacecraft, Phase 1; FM constellation, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: Two SATL EM payload/OBDH benches and one SATG EM payload bench are integrated with the Ground Segment emulator. SATG is powered in Mode N1 and the two SATL benches in Mode N2; aperture covers are open, cryocoolers are at 65–95 K, and all four OISL terminals are active. The IR scene projector injects a boost-phase plume that crosses the SATG field of regard, triggers the GEO Event Report, and then follows a representative ballistic trajectory in the two SATL fields of view. The spacecraft bus remains fixed; only the coarse gimbal and FSM move.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-03 (network data interface unit (NDIU)); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-06 (multi-constellation GNSS RF simulator); EGSE-07 (OISL terminal emulator with optical channel attenuator/delay line); EGSE-08 (RF link emulator, channel simulator and spectrum analyser)
  * **MGSE**: MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture); MGSE-09 (optical alignment theodolite and autocollimator set)
  * **OGSE**: OGSE-01 (calibrated blackbody source (280-1,200 K)); OGSE-02 (IR collimator); OGSE-04 (IR target/scene projector); OGSE-05 (star simulator)
* **Environment & Execution Constraints**: Optics in ISO Class 5 with continuous dry-nitrogen purge and the bus in ISO Class 8; FPA temperature 65–95 K; RF-shielded HIL laboratory; continuous un-switched power with the spacecraft in active Mode N1/N2; all pyrotechnic and laser safety inhibits verified before the apertures are opened.
* **Considered Assumptions**: Phase 4 operations, Modes N1 (SATG), N2 (two cued SATL) and N3 (ISL relay). The analysis covers the Baltic theatre and extra-regional launch corridors, maximum equinox eclipse, sunlit cloud-top clutter, EOL sensor and processor performance, and the 99th-percentile latency case.
* **Tools & Models**: AGI STK 12/Orekit 12 visibility and geometry model, MATLAB/Simulink end-to-end warning-chain model, MODTRAN 6/HITRAN-based plume and background radiometric model, and a 10,000-run Monte Carlo latency and coverage campaign.
* **Test Correlation & Validation**: Measured HIL event timestamps are compared with the analytical step budgets; the radiometric scene model is anchored to the measured PLD spectral response and the STK geometry is correlated with the LEOP orbit-determination solution.
* **Supporting R/I Evidence**: R evidence: review of the functional architecture, ICDs and flight-software design.
* **Verification Pass/Fail Criteria**: The chain executes in the correct order: SATG detection and encrypted GEO Event Report within 10.0 s, authenticated LEO Tracking Request delivered within 3.0 s, two-SATL lock-on/stereo tracking/preliminary 3D state within 18.0 s, and dual-product downlink completed such that the total Space Segment execution and transport time is ≤45.0 s at 99% confidence. Both LEO Observation Packages and the Onboard Preliminary Trajectory must be received without loss.

### Requirement Verification: SSEG-REQ-FUN-004 - Baltic Region and Extra-Regional Threat Surveillance

* **Requirement Text**: "The SSEG shall monitor both the primary Baltic Sea operational theatre (53.0°N–66.0°N, 10.0°E–32.0°E) and extra-regional launch corridors across Eurasia, the Arctic, and adjacent maritime theatres capable of launching ballistic threats toward the Baltic region."
* **Verification Method**: Analysis (A)
* **Applicable Model & Phase**: Analysis, Phase 4; correlated with Phase 3 orbit determination and payload calibration

#### Verification Strategy & Execution Plan:
* **Considered Assumptions**: The analysis covers the primary Baltic Sea theatre (53.0–66.0 N, 10.0–32.0 E) and all extra-regional launch corridors across Eurasia, the Arctic and adjacent maritime theatres capable of launching ballistic threats toward the Baltic. It considers every launch azimuth, local elevation ≥5.0 deg, sunlit and eclipse conditions, worst-case cloud cover, and EOL constellation geometry.
* **Tools & Models**: AGI STK 12/Orekit 12 area-coverage and chain-access analysis with a digitised corridor and target model, a 10,000-run Monte Carlo campaign, and an atmospheric/terrain visibility mask.
* **Test Correlation & Validation**: The geometric model is correlated with LEOP orbit determination and with the measured payload LOS and field-of-regard calibration; coverage predictions are re-run with the as-built ephemerides after commissioning.
* **Verification Pass/Fail Criteria**: Every point in the Baltic region (53.0–66.0 N, 10.0–32.0 E) and every designated extra-regional corridor is observed by at least one SATG or by the required SATL pair for 100% of the 24/7 timeline, with zero operational blind windows at local elevation ≥5.0 deg. All analysed threat origins that can reach the Baltic region are included in the corridor set.

### Requirement Verification: SSEG-REQ-FUN-005 - Onboard Event Filtering and Plume Discrimination

* **Requirement Text**: "Both SATG and SATL shall perform real-time onboard pixel despiking, background clutter suppression, and dual-band spectral/kinematic discrimination to distinguish rocket exhaust plumes from solar specular glints, terrestrial fires, aurorae, and radiation-induced detector transients."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: PLD/OBDH EM and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The PLD EM/QM optical bench is operated at 65–95 K with the aperture cover open and the OBDH EM running the flight plume-classification software. The scene projector sequentially injects rocket-plume spectra at 50 kW/sr to 10 MW/sr, solar specular glints, terrestrial fires, auroral arcs, and proton-induced pixel transients. SATG and SATL configurations are tested separately in Modes N1 and N2; the bus is powered and the payload is un-cued except during the N2 tracking cases.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture); MGSE-09 (optical alignment theodolite and autocollimator set)
  * **OGSE**: OGSE-01 (calibrated blackbody source (280-1,200 K)); OGSE-02 (IR collimator); OGSE-03 (integrating sphere); OGSE-04 (IR target/scene projector)
* **Environment & Execution Constraints**: ISO Class 5 optics bay with GN2 purge, FPA at 65–95 K, dark current and radiometric calibration performed before each run; proton-spike sequences are injected both synthetically and, for the FPA, with a calibrated proton source. Continuous power-on is maintained to prevent error accumulation in the classifier.
* **Considered Assumptions**: Analysis covers all specified false-source classes, SAA and polar proton transits, sunlit cloud-top clutter, worst-case solar glint geometry and EOL detector/processor performance. The classifier is assumed to operate on the same dual-band data as the flight unit.
* **Tools & Models**: MATLAB/Simulink classifier and scene model, MODTRAN 6/HITRAN spectral library, a track-before-detect and spatio-temporal filter model, and a 10,000-run Monte Carlo ROC/FAR campaign.
* **Test Correlation & Validation**: The measured receiver-operating-characteristic curve from the HIL campaign is compared with the analytical classifier model; the model is re-anchored to the measured PLD spectral response and noise-equivalent irradiance.
* **Verification Pass/Fail Criteria**: The classifier rejects ≥99% of injected proton spikes and all specified glint, fire, aurora and transient classes while maintaining Pd &gt; 95.0% for plumes ≥50 kW/sr; the false-event rate does not exceed 1 per constellation-day. The per-frame processing latency remains ≤50.0 ms.

### Requirement Verification: SSEG-REQ-FUN-006 - Archival Telemetry and Provenance Formatting

* **Requirement Text**: "All downlinked SSEG event reports, LOS observation packages, preliminary trajectory estimates, and housekeeping records shall include GNSS-synchronized UTC timestamps, spacecraft ephemeris and attitude covariance metadata, and data-quality flags formatted for 5-year sovereign archival in the Ground Segment Data Archiving System (123456.02.01) exclusively for calibration, training, verification, and algorithm refinement."
* **Verification Method**: Test (T), supported by Review of Design (R)
* **Applicable Model & Phase**: EM/QM spacecraft and FM, Phase 1 and Phase 3; archive replay in Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: A spacecraft EM or FM is operated in Mode N1 and then Mode N2 while the Ground Station emulator records all downlinked event reports, LOS packages, preliminary trajectories and housekeeping packets. GNSS time, spacecraft ephemeris, attitude covariance and data-quality flags are injected at source. The packets are ingested by the Ground Segment Data Archiving System emulator and replayed after 5-year ageing.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-03 (network data interface unit (NDIU)); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: None required for this verification.
  * **OGSE**: None required for this verification.
* **Environment & Execution Constraints**: End-to-end secure ground-network test in a RF-shielded laboratory; continuous power-on; CCSDS packet capture with GNSS-disciplined time tagging; archive emulator configured to the 5-year retention and encryption rules.
* **Supporting R/I Evidence**: R evidence: review of the telemetry/data dictionary and archive ICD.
* **Verification Pass/Fail Criteria**: 100% of event reports, LOS packages, preliminary trajectories and housekeeping records contain GNSS-synchronised UTC time (≤50 us), spacecraft ephemeris, attitude covariance and data-quality flags. The archive emulator accepts every packet without schema or checksum error and replays it unchanged after the 5-year ageing test. No mandatory field is absent and no unencrypted archive record is produced.

### 5.2 Constellation Architecture and Astrodynamic Requirements (TRS Section 7.2)

### Requirement Verification: SSEG-REQ-MIS-001 - Hybrid Constellation Composition

* **Requirement Text**: "The SSEG shall consist of six (6) active GEO detection satellites (SATG) operating at a nominal altitude of 35,786 km (a = 42,164.14 km, i = 0.0° ± 0.05°, e ≤ 0.0005) and seventy-two (72) active LEO tracking satellites (SATL) operating at a circular altitude of 1,000 km ± 10 km (a = 7,378.14 km, e ≤ 0.001)."
* **Verification Method**: Analysis (A), supported by Review of Design (R)
* **Applicable Model & Phase**: Analysis and R, Phase 2–4; correlated with LEOP orbit determination

#### Verification Strategy & Execution Plan:
* **Considered Assumptions**: Analysis covers launch injection dispersions, atmospheric drag, solar radiation pressure, lunisolar perturbations, station-keeping deadbands and the 7-year SATL / 15-year SATG life. All 6 SATG and 72 SATL are assumed active after commissioning.
* **Tools & Models**: AGI STK 12/Orekit 12 high-fidelity propagators (J2/J4, drag, SRP, lunisolar), a 5,000-run Monte Carlo injection-dispersion campaign, and a constellation availability model.
* **Test Correlation & Validation**: Predicted orbital elements are compared with the LEOP orbit-determination solution and with GNSS-based onboard ephemerides; the propagator is tuned to the measured drag and SRP area-to-mass ratio.
* **Supporting R/I Evidence**: R evidence: review of the constellation design and launch manifest.
* **Verification Pass/Fail Criteria**: The constellation contains six active SATG at 35,786 km (a = 42,164.14 km), i = 0.0 ± 0.05 deg and e ≤ 0.0005, and 72 active SATL at 1,000 ± 10 km (a = 7,378.14 km) and e ≤ 0.001. All 78 spacecraft are commissioned and in their assigned slots within the LEOP window; no plane or slot is missing.

### Requirement Verification: SSEG-REQ-MIS-002 - GEO Longitudinal Slot Allocation

* **Requirement Text**: "The 6 SATG spacecraft shall be distributed uniformly along the equatorial geostationary belt at 60.0° nominal longitudinal intervals and maintained within a station-keeping deadband box of ± 0.05° in both geographic longitude and latitude."
* **Verification Method**: Analysis (A)
* **Applicable Model & Phase**: Analysis, Phase 3 and Phase 4; correlated with RF ranging

#### Verification Strategy & Execution Plan:
* **Considered Assumptions**: The six SATG are assumed station-kept within a ±0.05 deg box for 15 years under lunisolar, solar-radiation-pressure and thruster-error perturbations. Worst-case east-west and north-south station-keeping cycles and the maximum eclipse season are included.
* **Tools & Models**: AGI STK 12/Orekit 12 GEO station-keeping simulation, a 15-year propagation with lunisolar and SRP models, and a propellant/Delta-v budget model.
* **Test Correlation & Validation**: The station-keeping model is correlated with RF ranging and the measured drift of the first SATG during station acquisition; manoeuvre telemetry is used to update the thruster performance model.
* **Verification Pass/Fail Criteria**: All six SATG are separated by 60.0 deg nominal longitude and remain within ±0.05 deg in both geographic longitude and latitude for the full 15-year mission. No box violation occurs and the station-keeping Delta-v remains within the allocated budget.

### Requirement Verification: SSEG-REQ-MIS-003 - LEO Walker Delta 72/8/1 Topology

* **Requirement Text**: "The 72 SATL spacecraft shall be arranged in a Walker Delta 72/8/1 constellation at an orbital inclination of 80.0° ± 0.2° across 8 orbital planes spaced uniformly by Δ\Omega = 45.0° ± 0.5° in Right Ascension of the Ascending Node (RAAN), with 9 satellites per plane spaced by Δ u = 40.0° ± 0.5° in argument of latitude and an inter-plane phasing factor F = 1 (Δ u_inter = 5.0°)."
* **Verification Method**: Analysis (A)
* **Applicable Model & Phase**: Analysis, Phase 3 and Phase 4; correlated with LEOP orbit determination

#### Verification Strategy & Execution Plan:
* **Considered Assumptions**: The 72 SATL are assumed deployed in eight planes of nine spacecraft with Walker Delta 72/8/1 phasing. Injection errors, differential drag, phasing-burn dispersions and the 7-year station-keeping budget are included.
* **Tools & Models**: AGI STK 12/Orekit 12 Walker Delta constellation builder, a 5,000-run injection and phasing Monte Carlo, and a RAAN/argument-of-latitude covariance analysis.
* **Test Correlation & Validation**: RAAN and argument-of-latitude predictions are compared with LEOP orbit determination and with the phasing-burn telemetry; the drag model is updated from the measured semi-major-axis decay.
* **Verification Pass/Fail Criteria**: All 72 SATL are arranged in eight planes with RAAN spacing 45.0 ± 0.5 deg, nine satellites per plane at 40.0 ± 0.5 deg argument-of-latitude spacing, inter-plane phasing F = 1 (5.0 deg offset), inclination 80.0 ± 0.2 deg, and altitude 1,000 ± 10 km. No plane contains fewer than nine operational satellites after commissioning.

### Requirement Verification: SSEG-REQ-MIS-004 - 24/7 Uninterrupted Temporal and Spatial Coverage

* **Requirement Text**: "The combined SSEG constellation shall provide 100% continuous 24/7 temporal and spatial surveillance of the Baltic Sea monitoring region (53.0°N–66.0°N, 10.0°E–32.0°E) and designated extra-regional launch corridors with zero operational blind windows at local target elevation angles \varepsilon ≥ 5.0°."
* **Verification Method**: Analysis (A)
* **Applicable Model & Phase**: Analysis, Phase 4; correlated with as-built ephemerides after Phase 3

#### Verification Strategy & Execution Plan:
* **Considered Assumptions**: The analysis covers the full Baltic monitoring region and designated extra-regional corridors, all seasons, maximum eclipse, sunlit cloud clutter and EOL geometry. One SATL at a time may be in Mode N4; the remaining constellation must preserve coverage. Local target elevation is ≥5.0 deg.
* **Tools & Models**: AGI STK 12/Orekit 12 area-coverage and chain-access analysis on a 1 s time grid, a 1-year propagation, and a 10,000-run Monte Carlo with launch-point and time randomisation.
* **Test Correlation & Validation**: Coverage predictions are re-run with the as-built LEOP ephemerides and the measured payload FOR/LOS calibration; any coverage difference is fed back into the constellation phasing plan.
* **Verification Pass/Fail Criteria**: The combined constellation provides 100% continuous 24/7 temporal and spatial coverage of the Baltic region (53.0–66.0 N, 10.0–32.0 E) and all designated extra-regional corridors at local target elevation ≥5.0 deg, with zero operational blind windows. No coverage gap occurs during nominal station-keeping or a single-spacecraft Mode N4 manoeuvre.

### Requirement Verification: SSEG-REQ-MIS-005 - Multi-Satellite Stereoscopic Viewing Geometry

* **Requirement Text**: "Over the northern latitude band from 50.0°N to 80.0°N, the 1,000 km LEO constellation shall maintain at least 5 SATL spacecraft simultaneously above \varepsilon_\min = 5.0° local elevation at all times, ensuring that at least one pair of SATL spacecraft achieves a stereoscopic baseline convergence angle within 30.0° ≤ β ≤ 120.0° for any boost- or post-boost-phase target."
* **Verification Method**: Analysis (A)
* **Applicable Model & Phase**: Analysis, Phase 4; correlated with HIL stereo-tracking geometry

#### Verification Strategy & Execution Plan:
* **Considered Assumptions**: The analysis covers the 50.0–80.0 N latitude band at all local times, all seasons, boost- and post-boost-phase target altitudes, EOL constellation geometry and one SATL in Mode N4. A valid stereo pair requires a convergence angle 30.0 ≤ beta ≤ 120.0 deg.
* **Tools & Models**: AGI STK 12/Orekit 12 chain-access and stereo-pair geometry analysis, a 1-year 1 s time grid, and a Monte Carlo target-altitude campaign; the triangulation covariance is computed with a linearised least-squares model.
* **Test Correlation & Validation**: The predicted stereo geometry and covariance are compared with the HIL dual-bench tracking results and with the measured star-tracker/AKE performance.
* **Verification Pass/Fail Criteria**: At every instant over 50.0–80.0 N, at least five SATL of the 1,000 km LEO constellation are above 5.0 deg local elevation and at least one pair has 30.0 ≤ beta ≤ 120.0 deg for any boost- or post-boost-phase target. The condition is met 100% of the time, including during one SATL Mode N4 manoeuvre.

### Requirement Verification: SSEG-REQ-MIS-006 - Dual-GEO Overlapping Mid-Latitude Coverage

* **Requirement Text**: "The 6-satellite GEO ring shall provide simultaneous dual-satellite observation (≥ 2 SATG nodes at local elevation \varepsilon ≥ 5.0°) across all geographic longitudes between latitudes 55.0°S and 55.0°N."
* **Verification Method**: Analysis (A)
* **Applicable Model & Phase**: Analysis, Phase 4; correlated with GEO RF ranging and dual-satellite observation tests

#### Verification Strategy & Execution Plan:
* **Considered Assumptions**: The six-satellite GEO ring is assumed station-kept within its deadband for 15 years. The analysis covers all geographic longitudes between 55.0 S and 55.0 N, all local times, minimum elevation 5.0 deg, and worst-case station-keeping offsets.
* **Tools & Models**: AGI STK 12/Orekit 12 coverage analysis with a 0.1 deg geographic grid, a 1-year propagation and a dual-visibility access model.
* **Test Correlation & Validation**: The GEO geometry is correlated with RF ranging and with the measured dual-SATG observation geometry during commissioning.
* **Verification Pass/Fail Criteria**: At every point between 55.0 S and 55.0 N and at every longitude, at least two SATG are simultaneously above 5.0 deg local elevation for 100% of the time. No longitude or latitude gap exists over the 15-year station-keeping envelope.

### Requirement Verification: SSEG-REQ-MIS-007 - Constellation Phasing Maintenance Coordination

* **Requirement Text**: "Orbit maintenance and station-keeping manoeuvres across the 78 spacecraft shall be scheduled such that no more than one (1) SATL spacecraft within any mutual visibility zone is off-pointing or thrusting simultaneously, preserving 100% stereoscopic tracking availability."
* **Verification Method**: Analysis (A), supported by Review of Design (R)
* **Applicable Model & Phase**: Analysis and R, Phase 4; correlated with manoeuvre telemetry

#### Verification Strategy & Execution Plan:
* **Considered Assumptions**: The analysis covers the 78-spacecraft constellation, all station-keeping and collision-avoidance manoeuvres, the 7/15-year life, and the requirement that no more than one SATL in any mutual-visibility zone is off-pointing or thrusting at a time.
* **Tools & Models**: AGI STK 12/Orekit 12 constellation scheduler, a Monte Carlo manoeuvre-conflict analysis, and a coverage-reassessment model that removes the manoeuvring node from the stereo pair list.
* **Test Correlation & Validation**: Scheduled manoeuvres are compared with actual manoeuvre telemetry and the resulting coverage is re-evaluated with the as-flown ephemerides.
* **Supporting R/I Evidence**: R evidence: review of the constellation operations plan and manoeuvre scheduling rules.
* **Verification Pass/Fail Criteria**: The scheduling analysis covers all 78 spacecraft and demonstrates that, for every mutual-visibility zone and every manoeuvre, at most one SATL is off-pointing or thrusting, and 100% stereoscopic tracking availability is preserved. No conflict occurs over the 7-year SATL and 15-year SATG lives.

### 5.3 Mission Performance and Latency Budget Requirements (TRS Section 7.3)

### Requirement Verification: SSEG-REQ-PERF-001 - Space Segment Total Latency Allocation

* **Requirement Text**: "Within the ≤ 60.0 s system end-to-end warning latency budget (measured from initial GEO detection epoch T_0 to external national authority warning delivery), the combined Space Segment execution and transport time (encompassing Step 1 GEO detection/reporting, Step 2 ISL command routing, and Step 3 LEO lock-on, stereoscopic tracking, onboard preliminary 3D trajectory estimation, and downlink to the Ground Station Network) shall not exceed 45.0 seconds (99% confidence)."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: EM HIL chain and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The end-to-end HIL chain comprises a SATG EM payload/OBDH, two SATL EM payload/OBDH benches, the OISL terminal emulators, the Ground Segment emulator and the mission-control emulator. SATG is in Mode N1; on cue the two SATL benches enter Mode N2. A GNSS-disciplined time-tagging unit records T0 at the SATG detector, each command/data packet at the ISL and ground interfaces, and the final warning-product delivery. The bus is powered continuously and the payloads are at flight operating temperature.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-03 (network data interface unit (NDIU)); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-06 (multi-constellation GNSS RF simulator); EGSE-07 (OISL terminal emulator with optical channel attenuator/delay line); EGSE-08 (RF link emulator, channel simulator and spectrum analyser)
  * **MGSE**: MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture)
  * **OGSE**: OGSE-02 (IR collimator); OGSE-04 (IR target/scene projector); OGSE-05 (star simulator)
* **Environment & Execution Constraints**: ISO Class 5 optics and ISO Class 8 bus; FPA 65–95 K; RF-shielded HIL laboratory; GNSS-disciplined time tagging with ≤1 us resolution; network emulator configured to the worst-case ISL and ground-link delays. At least 100 repeated runs are performed at the 99th-percentile processor load.
* **Considered Assumptions**: Phase 4 operations, Modes N1–N3, worst-case Baltic and extra-regional geometry, maximum eclipse, sunlit cloud clutter, EOL processor and link performance, and the 99th-percentile statistical case. The 60 s system budget allocates ≤45 s to SSEG.
* **Tools & Models**: MATLAB/Simulink discrete-event warning-chain model, AGI STK 12/Orekit 12 geometry and link model, and a 10,000-run Monte Carlo latency campaign.
* **Test Correlation & Validation**: The measured HIL timestamps are compared with the analytical step budgets; the processor-in-the-loop execution times and the emulated link delays are used to update the model. The final model is re-validated during the Phase 3 end-to-end trial.
* **Verification Pass/Fail Criteria**: The combined Space Segment execution and transport time from T0 to Ground Station Network reception is ≤45.0 s at 99% confidence within the 60.0 s system end-to-end budget. All constituent step budgets are met, no packet is lost, and the warning product is delivered without operator intervention.

### Requirement Verification: SSEG-REQ-PERF-002 - Step 1 GEO Detection and Reporting Latency

* **Requirement Text**: "Upon a missile plume reaching the boost-phase radiometric detection threshold above cloud tops (T_0), the detecting SATG spacecraft shall complete onboard proton despiking, clutter filtering, preliminary classification, and transmission of the encrypted GEO Event Report to the Ground Station Network within ≤ 10.0 seconds."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: SATG PLD/OBDH EM and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: A SATG EM payload and OBDH are operated in Mode N1 with the aperture cover open and the FPA at 65–95 K. The scene projector injects a plume just above the radiometric detection threshold against a sunlit cloud-top background. The time-tagging unit records T0 at the detector and the arrival of the encrypted GEO Event Report at the Ground Station emulator. The spacecraft is powered and the payload is in its normal staring configuration.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-03 (network data interface unit (NDIU)); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-07 (OISL terminal emulator with optical channel attenuator/delay line); EGSE-08 (RF link emulator, channel simulator and spectrum analyser)
  * **MGSE**: MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture)
  * **OGSE**: OGSE-01 (calibrated blackbody source (280-1,200 K)); OGSE-02 (IR collimator); OGSE-03 (integrating sphere); OGSE-04 (IR target/scene projector)
* **Environment & Execution Constraints**: ISO Class 5 optics with GN2 purge; FPA 65–95 K; RF-shielded laboratory; continuous power-on; SAA/polar proton spike sequences and worst-case background clutter are played in; at least 100 runs at hot and cold FPA plateaus.
* **Considered Assumptions**: Analysis covers Mode N1, worst-case proton-despiking load during SAA transits, sunlit cloud clutter, EOL processor performance and the 99th-percentile detection case.
* **Tools & Models**: MATLAB/Simulink timing model of the SATG detection-to-downlink chain, a processor emulator with flight-software execution-time measurements, and a Monte Carlo campaign.
* **Test Correlation & Validation**: Measured detection, despiking, classification and downlink timestamps are compared with the model; the processor execution-time model is calibrated with the EM flight software.
* **Verification Pass/Fail Criteria**: The elapsed time from T0 to transmission of the encrypted GEO Event Report is ≤10.0 s at the 99th percentile. The report contains a valid time, location and classification, and no false report is generated during the run.

### Requirement Verification: SSEG-REQ-PERF-003 - Step 2 Mandatory ISL Command Routing Latency

* **Requirement Text**: "Following Ground Segment transmission of a LEO Tracking Request, the SSEG communication and mandatory ISL network shall deliver the authenticated tracking command to the two selected SATL spacecraft within ≤ 3.0 seconds anywhere in orbit (within the ≤ 5.0 s combined Step 2 ground selection and cueing allocation)."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: ISL network EM and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The ISL network test-bed comprises at least three SATL OISL terminal emulators, one SATG cross-layer relay emulator and the Ground Station emulator. A LEO Tracking Request is injected at the ground gateway and routed to two selected SATL nodes over the emulated GEO–LEO and LEO–LEO paths. The spacecraft buses are powered; the ISL terminals are in Mode N3 and the cued SATL nodes are in Mode N2.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-03 (network data interface unit (NDIU)); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-07 (OISL terminal emulator with optical channel attenuator/delay line); EGSE-08 (RF link emulator, channel simulator and spectrum analyser)
  * **MGSE**: None required for this verification.
  * **OGSE**: OGSE-06 (laser power meter and optical spectrum analyser)
* **Environment & Execution Constraints**: RF-shielded HIL laboratory; optical delay lines and variable attenuators emulate 5,500 km LEO–LEO and 34,800–40,000 km GEO–LEO ranges; continuous power; network emulator configured for worst-case queueing and one failed node.
* **Considered Assumptions**: Analysis covers the worst-case routing path, one failed node or degraded link, the 34,800–40,000 km cross-layer range, EOL terminal performance and the 99th-percentile traffic case.
* **Tools & Models**: NS-3/OPNET network simulation with the constellation topology, AGI STK 12 visibility model, and a MATLAB/Simulink command-latency model.
* **Test Correlation & Validation**: Measured command delivery times are compared with the network simulation; emulated link delays and terminal acquisition times are updated from the hardware measurements.
* **Verification Pass/Fail Criteria**: The authenticated LEO Tracking Request is delivered to both selected SATL within ≤3.0 s of ground transmission anywhere in orbit, within the ≤5.0 s combined Step 2 allocation. No packet loss and no unauthenticated command acceptance occurs.

### Requirement Verification: SSEG-REQ-PERF-004 - Step 3 LEO Lock-On, Stereo Tracking, and Downlink Latency

* **Requirement Text**: "From receipt of the LEO Tracking Request at the two cued SATL spacecraft to reception of both their encrypted timestamped LEO Observation Packages and the Onboard Preliminary Trajectory at the Ground Station Network, the elapsed time shall not exceed 30.0 seconds (comprising &lt; 5.0 s optical LOS lock-on, 18.0–20.0 s stereoscopic tracking and onboard 3D trajectory convergence, and ≤ 5.0 s ISL/ground downlink)."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: Two SATL EM HIL benches and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: Two SATL EM payload/OBDH benches are mounted on zero-gravity optical fixtures. Both are in Mode N2 after receipt of the tracking request, with aperture covers open, cryocoolers at 65–95 K and OISL terminals exchanging LOS vectors at ≥10 Hz. The scene projector moves a representative boost-phase target across both fields of view; the ground emulator records lock-on, stereo convergence, preliminary trajectory and downlink times.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-03 (network data interface unit (NDIU)); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-06 (multi-constellation GNSS RF simulator); EGSE-07 (OISL terminal emulator with optical channel attenuator/delay line); EGSE-08 (RF link emulator, channel simulator and spectrum analyser)
  * **MGSE**: MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture); MGSE-09 (optical alignment theodolite and autocollimator set)
  * **OGSE**: OGSE-01 (calibrated blackbody source (280-1,200 K)); OGSE-02 (IR collimator); OGSE-04 (IR target/scene projector); OGSE-05 (star simulator)
* **Environment & Execution Constraints**: ISO Class 5 optics; FPA 65–95 K; RF-shielded HIL laboratory; target angular rates and radiometric levels representative of the worst-case boost/post-boost trajectory; continuous power-on; 100 repeated runs including low-SNR and sun-glint cases.
* **Considered Assumptions**: Analysis covers Mode N2, worst-case target angular rate, low SNR, sun glint, EOL processor performance and the 99th-percentile stereo-triangulation case.
* **Tools & Models**: MATLAB/Simulink stereo-tracking and triangulation model, AGI STK 12 target geometry, and a Monte Carlo covariance campaign.
* **Test Correlation & Validation**: Measured lock-on, convergence and downlink timestamps are compared with the model; the stereo covariance is checked against the truth trajectory and the measured AKE.
* **Verification Pass/Fail Criteria**: From receipt of the tracking request: optical lock-on &lt; 5.0 s, stereoscopic tracking and onboard 3D trajectory convergence within 18.0–20.0 s, and both LEO Observation Packages plus the Onboard Preliminary Trajectory received at the Ground Station Network within a total ≤30.0 s. No loss of either product.

### Requirement Verification: SSEG-REQ-PERF-005 - Boost-Phase Launch Detection Probability

* **Requirement Text**: "The SSEG shall achieve a boost-phase missile launch probability of detection of P_d &gt; 95.0% (≥ 98.0% design target) for all theatre and strategic ballistic missile classes (SRBM, MRBM, IRBM, and ICBM) exhibiting a plume radiant intensity ≥ 50.0 kW/sr in the SWIR/MWIR bands above cloud tops."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: PLD/OBDH EM and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The PLD EM/QM and OBDH EM are operated in Modes N1 and N2 with the aperture open and the FPA at 65–95 K. The scene projector plays at least 1,000 representative boost-phase trajectories for SRBM, MRBM, IRBM and ICBM classes at plume intensities from 50 kW/sr to 10 MW/sr, over sunlit cloud tops, night clouds, land, sea and auroral backgrounds. The detection decision and time are recorded for each injection.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture)
  * **OGSE**: OGSE-01 (calibrated blackbody source (280-1,200 K)); OGSE-02 (IR collimator); OGSE-03 (integrating sphere); OGSE-04 (IR target/scene projector)
* **Environment & Execution Constraints**: ISO Class 5 optics; FPA 65–95 K; dark-current and radiometric calibration before the run; continuous power-on; SAA/polar proton-spike sequences included; at least 1,000 statistically independent target injections.
* **Considered Assumptions**: Analysis covers all missile classes, all background types, worst-case sun glint and cloud clutter, SAA/polar transits, EOL detector performance and the 95% confidence case.
* **Tools & Models**: MODTRAN 6/HITRAN radiometric scene model, MATLAB/Simulink detector and classifier model, and a Monte Carlo campaign with ≥10,000 target/background realisations.
* **Test Correlation & Validation**: The analytical Pd curve is anchored to the measured NEI/NETD and spectral response; the HIL measured Pd is compared with the model at each intensity and background class.
* **Verification Pass/Fail Criteria**: The measured boost-phase launch probability of detection is &gt; 95.0% overall and for each missile class (design target ≥98.0%), with the 95% confidence lower bound ≥95.0%, for plumes ≥50 kW/sr. No class falls below 95.0%.

### Requirement Verification: SSEG-REQ-PERF-006 - Space Segment False-Alarm Rate Rejection

* **Requirement Text**: "Onboard proton despiking and dual-band spatio-temporal clutter filtering shall limit false candidate event reports transmitted to the Ground Segment to ≤ 1 false event per constellation-day across all 78 spacecraft while maintaining P_d &gt; 95.0%."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: PLD/OBDH EM and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: A 30-day equivalent background stream is played through the SATG and SATL EM/QM payload and OBDH in Modes N1 and N2. The stream contains sunlit and night clouds, solar specular glints, terrestrial fires, aurorae, SAA/polar proton spikes and radiation transients across all 78 node geometries. Every candidate event reported to the ground emulator is counted.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture)
  * **OGSE**: OGSE-01 (calibrated blackbody source (280-1,200 K)); OGSE-02 (IR collimator); OGSE-03 (integrating sphere); OGSE-04 (IR target/scene projector)
* **Environment & Execution Constraints**: ISO Class 5 optics; FPA 65–95 K; accelerated 30-day playback with continuous power-on; proton-spike injection synchronised with the SAA/polar orbital timeline; worst-case sun geometry.
* **Considered Assumptions**: Analysis covers the worst-case sunlit cloud-top clutter, all false-source classes, SAA/polar transits, EOL detector performance and a 95% confidence false-alarm estimate.
* **Tools & Models**: MATLAB/Simulink scene and classifier model, MODTRAN 6 background radiance model, and a Poisson/negative-binomial false-alarm statistical model.
* **Test Correlation & Validation**: Measured false-event counts are compared with the model prediction; archived flight data from Phase 4 are replayed to update the background statistics.
* **Verification Pass/Fail Criteria**: The false candidate event reports transmitted to the Ground Segment do not exceed one false event per constellation-day across all 78 spacecraft, while Pd remains &gt; 95.0%. The 30-day equivalent run yields ≤30 false events in total.

### Requirement Verification: SSEG-REQ-PERF-007 - Space Segment Operational Availability

* **Requirement Text**: "The integrated SSEG constellation shall achieve an operational availability of A_SSEG ≥ 99.95% over its operational lifetime to support the overall EWAS system availability requirement of &gt; 99.9%."
* **Verification Method**: Analysis (A)
* **Applicable Model & Phase**: Analysis, Phase 4; correlated with FM acceptance, FDIR HIL and on-orbit telemetry

#### Verification Strategy & Execution Plan:
* **Considered Assumptions**: The analysis covers the 7-year SATL and 15-year SATG lives, all nominal modes, single-failure cases, radiation-induced upsets, station-keeping and collision-avoidance manoeuvres, the 72 h autonomous operation capability and the constellation-level redundancy. EOL performance and the spare strategy are included.
* **Tools & Models**: Reliability block diagram and Markov availability model, a 100,000-run Monte Carlo outage simulation, AGI STK 12 coverage with node outages, and a spare/replenishment model.
* **Test Correlation & Validation**: Failure rates are updated from FM acceptance and qualification test data; FDIR failover times are measured in the HIL test and used in the availability model; on-orbit telemetry updates the model during Phase 4.
* **Verification Pass/Fail Criteria**: The integrated constellation operational availability is ≥99.95% over the operational lifetime, supporting the overall EWAS availability &gt; 99.9%. No single failure reduces constellation detection or stereoscopic tracking below the required performance.

### 5.4 Infrared Sensor Payload Requirements (TRS Section 7.4)

### Requirement Verification: SSEG-REQ-PLD-001 - Dual-Band SWIR/MWIR Spectral Coverage

* **Requirement Text**: "Each SATG and SATL infrared payload (WBS .04) shall simultaneously image in two co-registered spectral bands using cooled 2D Mercury Cadmium Telluride (HgCdTe) Focal Plane Arrays (FPAs): a Short-Wave Infrared (SWIR) band covering 2.65–2.85 µm (H_2O/CO_2 boost emission) and a Medium-Wave Infrared (MWIR) band covering 4.15–4.45 µm (CO_2 plume spike)."
* **Verification Method**: Test (T), supported by Review of Design (R)
* **Applicable Model & Phase**: PLD EM and QM/PFM, Phase 1; FM, Phase 3

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The PLD EM/QM is mounted on the optical bench in ISO Class 5 with the aperture cover open, the FPA at 65–95 K and the dichroic beam-splitter installed. A calibrated blackbody and monochromator scan the 2.50–4.60 um range at the collimator focus. The SWIR and MWIR focal-plane outputs are recorded simultaneously and the spectral response, band edges, co-registration and out-of-band rejection are measured. The spacecraft bus is powered in Mode N1.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-09 (optical alignment theodolite and autocollimator set)
  * **OGSE**: OGSE-01 (calibrated blackbody source (280-1,200 K)); OGSE-02 (IR collimator); OGSE-03 (integrating sphere); OGSE-08 (wavefront sensor, autocollimator and optical alignment targets)
* **Environment & Execution Constraints**: ISO Class 5 cleanroom with continuous GN2 purge; FPA 65–95 K; blackbody and monochromator calibrated before the run; ambient optical bench and a TVAC repeat at hot/cold plateaus; continuous power-on to stabilise the FPA.
* **Supporting R/I Evidence**: R evidence: design review of the dichroic/FPA spectral design.
* **Verification Pass/Fail Criteria**: The SWIR band covers 2.65–2.85 um and the MWIR band covers 4.15–4.45 um simultaneously, with band edges within ±0.02 um of the specified limits. The two bands are co-registered to ≤0.2 pixel over the full FPA and the out-of-band response is at least one order of magnitude below the in-band response.

### Requirement Verification: SSEG-REQ-PLD-002 - SATG Wide-Field Detection Optics Performance

* **Requirement Text**: "The SATG Wide-Field-of-View (WFOV) payload (123456.03.02.04) shall provide a full-Earth-disk or regional step-stare Field of Regard of ≥ 17.4° × 17.4°, a nadir Ground Sampling Distance (GSD) of ≤ 1.5 km (≤ 2.0 km at 60.0° off-nadir), a frame rate of ≥ 10.0 Hz, and a Noise Equivalent Irradiance (NEI) ≤ 1.5 × 10^-13 W/cm^2 (NETD ≤ 35.0 mK)."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: SATG PLD EM and QM/PFM, Phase 1; FM, Phase 3

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The SATG PLD EM/QM is mounted on the optical bench in ISO Class 5 and operated at 65–95 K. A collimated IR target is scanned across the full field of regard and at 60 deg off-nadir; the spot size, PSF, GSD, frame rate and NEI/NETD are measured. The target radiance is calibrated with the blackbody and integrating sphere. The spacecraft is powered in Mode N1 and the aperture cover is open.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture); MGSE-09 (optical alignment theodolite and autocollimator set)
  * **OGSE**: OGSE-01 (calibrated blackbody source (280-1,200 K)); OGSE-02 (IR collimator); OGSE-03 (integrating sphere); OGSE-04 (IR target/scene projector); OGSE-08 (wavefront sensor, autocollimator and optical alignment targets)
* **Environment & Execution Constraints**: ISO Class 5 cleanroom with GN2 purge; FPA 65–95 K; TVAC hot/cold plateaus for the performance repeat; target at infinity; background controlled to &lt; 10 K equivalent; continuous power-on.
* **Considered Assumptions**: Analysis covers the full-Earth-disk and regional step-stare FOR, nadir and 60 deg off-nadir GSD, worst-case sunlit cloud background, EOL optics and detector performance.
* **Tools & Models**: Zemax OpticStudio/FRED optical model, MATLAB/Simulink radiometric model with MODTRAN 6 atmospheric transmission, and a detector NEI/NETD model.
* **Test Correlation & Validation**: Measured PSF/MTF, GSD and NEI/NETD are compared with the optical and radiometric models; the model is updated with the as-built optical prescription and FPA characterisation.
* **Verification Pass/Fail Criteria**: Field of regard ≥17.4 deg x 17.4 deg, nadir GSD ≤1.5 km (≤2.0 km at 60 deg off-nadir), frame rate ≥10.0 Hz, NEI ≤1.5e-13 W/cm2 and NETD ≤35.0 mK. All values are met at both hot and cold plateaus.

### Requirement Verification: SSEG-REQ-PLD-003 - SATL Narrow-Field Tracking Optics Performance

* **Requirement Text**: "The SATL Narrow-Field-of-View (NFOV) tracking payload (123456.03.01.04) shall provide an instantaneous Field of View (FOV) of ≥ 1.5° × 1.5° steerable across a ± 55.0° Field of Regard (FOR), a nadir GSD of ≤ 35.0 m at 1,000 km altitude, a frame rate of ≥ 30.0 Hz (20.0–50.0 Hz programmable), and a Noise Equivalent Temperature Difference NETD ≤ 25.0 mK."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: SATL PLD EM and QM/PFM, Phase 1; FM, Phase 3

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The SATL PLD EM/QM is mounted on the zero-gravity optical fixture in ISO Class 5 and operated at 65–95 K. The two-axis gimbal and FSM are commanded over the full ±55 deg FOR; a collimated moving IR target measures the instantaneous FOV, GSD at 1,000 km, frame rate and NETD. The spacecraft bus is powered in Mode N2.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture); MGSE-09 (optical alignment theodolite and autocollimator set)
  * **OGSE**: OGSE-01 (calibrated blackbody source (280-1,200 K)); OGSE-02 (IR collimator); OGSE-03 (integrating sphere); OGSE-04 (IR target/scene projector); OGSE-08 (wavefront sensor, autocollimator and optical alignment targets)
* **Environment & Execution Constraints**: ISO Class 5 cleanroom; FPA 65–95 K; TVAC hot/cold repeat; target angular motion representative of boost/post-boost tracking; continuous power-on; stray-light baffle installed.
* **Considered Assumptions**: Analysis covers the full ±55 deg FOR, nadir and slant-range GSD, frame rates 20–50 Hz, worst-case background, EOL optics/detector performance.
* **Tools & Models**: Zemax OpticStudio/FRED model, MATLAB/Simulink radiometric and GSD model, and a detector NETD model.
* **Test Correlation & Validation**: Measured FOV, GSD, frame rate and NETD are compared with the optical/radiometric models; the as-built prescription and FPA data update the model.
* **Verification Pass/Fail Criteria**: Instantaneous FOV ≥1.5 deg x 1.5 deg, steerable across ≥±55.0 deg FOR, nadir GSD ≤35.0 m at 1,000 km, frame rate ≥30.0 Hz (20.0–50.0 Hz programmable) and NETD ≤25.0 mK.

### Requirement Verification: SSEG-REQ-PLD-004 - Dual-Stage Agile Optical LOS Steering Mechanism

* **Requirement Text**: "Each SATL payload shall integrate a two-axis coarse gimballing mechanism (slew rate ≥ 15.0°/s, angular acceleration ≥ 10.0°/s^2) and a closed-loop piezo-actuated Fast Steering Mirror (FSM, control bandwidth ≥ 200.0 Hz, angular resolution ≤ 0.5 µrad) capable of acquiring and locking onto any cued target within the ± 55.0° FOR in &lt; 5.0 seconds without slewing the spacecraft bus."
* **Verification Method**: Test (T)
* **Applicable Model & Phase**: SATL PLD EM and QM/PFM, Phase 1; FM, Phase 3

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The SATL PLD EM/QM with its two-axis coarse gimbal and piezo FSM is mounted on the zero-gravity optical fixture in ISO Class 5. The bus is powered in Mode N2 but is held fixed; the gimbal and FSM are commanded to acquire targets at the edge and centre of the ±55 deg FOR. Slew rate, angular acceleration, FSM bandwidth, angular resolution and lock-on time are measured with the target projector and autocollimator. Reaction-wheel and cryocooler simulators are running.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture); MGSE-09 (optical alignment theodolite and autocollimator set)
  * **OGSE**: OGSE-02 (IR collimator); OGSE-04 (IR target/scene projector); OGSE-05 (star simulator); OGSE-08 (wavefront sensor, autocollimator and optical alignment targets)
* **Environment & Execution Constraints**: ISO Class 5 cleanroom; FPA 65–95 K; micro-vibration disturbance source active; ambient and TVAC hot/cold repeats; continuous power-on; spacecraft bus attitude monitored to confirm no bus slew.
* **Verification Pass/Fail Criteria**: Coarse gimbal slew rate ≥15.0 deg/s and angular acceleration ≥10.0 deg/s2; FSM control bandwidth ≥200.0 Hz and angular resolution ≤0.5 urad; any target in the ±55 deg FOR is acquired and locked in &lt; 5.0 s without slewing the spacecraft bus. Bus attitude excursion remains &lt; 0.05 deg.

### Requirement Verification: SSEG-REQ-PLD-005 - Stray-Light Attenuation and Exclusion Angles

* **Requirement Text**: "Both SATG and SATL optical assemblies shall incorporate blackened multi-vane stray-light baffles (WBS .08/.04) achieving a Point Source Transmittance (PST) ≤ 10^-10 for solar angles ≥ 15.0° off the optical axis and ≤ 10^-8 for sunlit Earth-limb angles ≥ 3.0° off-axis."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: PLD EM and QM/PFM, Phase 1; FM, Phase 3

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The PLD EM/QM with its flight stray-light baffle is installed in the PST measurement facility. A collimated laser/blackbody source is scanned from 0 to 180 deg off-axis, including the 15 deg solar exclusion and 3 deg sunlit Earth-limb exclusion angles. The PST is measured at each angle with a high-dynamic-range detector; the aperture cover and baffle vanes are in their flight configuration.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-09 (optical alignment theodolite and autocollimator set)
  * **OGSE**: OGSE-01 (calibrated blackbody source (280-1,200 K)); OGSE-02 (IR collimator); OGSE-07 (point-source-transmittance (PST) measurement facility); OGSE-08 (wavefront sensor, autocollimator and optical alignment targets)
* **Environment & Execution Constraints**: ISO Class 5 cleanroom; FPA 65–95 K; high-dynamic-range PST facility with stray-light-absorbing enclosure; TVAC repeat for thermo-elastic baffle alignment; continuous power-on.
* **Considered Assumptions**: Analysis covers the complete 3D baffle geometry, worst-case solar and Earth-limb angles, contamination/degradation at EOL and all operational modes.
* **Tools & Models**: FRED/ASAP non-sequential stray-light model, Zemax OpticStudio optical model, and a PST/ghost analysis at the specified exclusion angles.
* **Test Correlation & Validation**: Measured PST at selected angles is compared with the model; the model is updated with the as-built baffle geometry and surface BRDF data.
* **Verification Pass/Fail Criteria**: PST ≤1e-10 for solar angles ≥15.0 deg off-axis and ≤1e-8 for sunlit Earth-limb angles ≥3.0 deg off-axis, at both hot and cold plateaus. No ghost or stray-light path exceeds the specified limit.

### Requirement Verification: SSEG-REQ-PLD-006 - Focal Plane Cryogenic Operating Temperature

* **Requirement Text**: "Active pulse-tube cryocoolers integrated with the payload cold finger (WBS .01.02/.04) shall maintain the HgCdTe SWIR/MWIR focal plane arrays at an operating temperature between 65.0 K and 95.0 K with a temporal stability within ± 0.10 K across all sunlit and eclipse orbital phases."
* **Verification Method**: Test (T)
* **Applicable Model & Phase**: PLD EM and QM/PFM, Phase 1; FM, Phase 3

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The PLD EM/QM with its flight pulse-tube cryocooler and cold finger is installed in the TVAC chamber. The FPA temperature is measured at multiple points across the array while the chamber cycles through hot and cold plateaus and the payload is operated in Modes N1 and N2. The cryocooler drive is powered from the spacecraft EGSE in its flight configuration.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-05 (thermal-vacuum (TVAC) chamber with solar simulator and shrouds); MGSE-09 (optical alignment theodolite and autocollimator set)
  * **OGSE**: OGSE-01 (calibrated blackbody source (280-1,200 K)); OGSE-02 (IR collimator)
* **Environment & Execution Constraints**: TVAC at ≤1e-5 mbar, shroud -70 to +100 C, at least eight hot/cold cycles with solar simulation; FPA temperature held at 65–95 K; continuous power-on; contamination monitoring with QCM.
* **Verification Pass/Fail Criteria**: The FPA operating temperature remains within 65.0–95.0 K and its temporal stability is within ±0.10 K across all sunlit and eclipse phases. No cryocooler oscillation, over-temperature or contamination-induced degradation occurs over the eight-cycle test.

### Requirement Verification: SSEG-REQ-PLD-007 - Motorized Fail-Safe Aperture Shutter and Calibration Source

* **Requirement Text**: "Each payload shall include a fail-safe motorized aperture cover protecting the optics during launch, outgassing bake-out, and Safe Mode, and an internal blackbody calibration source (280.0–350.0 K, radiometric accuracy ≤ ± 0.25 K) for periodic in-orbit flat-field and radiometric calibration."
* **Verification Method**: Test (T), supported by Inspection (I)
* **Applicable Model & Phase**: PLD EM and QM/PFM, Phase 1; FM, Phase 3

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The PLD EM/QM is installed in ISO Class 5 with the motorized aperture cover and internal blackbody calibration source. The cover is cycled at least 1,000 times, including power-loss and fault-injection cases; the blackbody is commanded to 280, 315 and 350 K and the radiometric response is measured. The spacecraft is powered in Modes N1 and N5.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-05 (thermal-vacuum (TVAC) chamber with solar simulator and shrouds); MGSE-09 (optical alignment theodolite and autocollimator set)
  * **OGSE**: OGSE-01 (calibrated blackbody source (280-1,200 K)); OGSE-02 (IR collimator); OGSE-03 (integrating sphere)
* **Environment & Execution Constraints**: ISO Class 5 cleanroom; TVAC hot/cold and ambient; vibration before and after the cycle test; continuous power-on; fail-safe spring and redundant harness inspected before and after.
* **Supporting R/I Evidence**: I evidence: inspection of the fail-safe mechanism, spring, redundant harness and flight-article build records.
* **Verification Pass/Fail Criteria**: The aperture cover closes automatically on power loss or Safe-Mode command, provides a light-tight seal (no detectable signal above the dark-noise floor) and survives 1,000 cycles without degradation. The internal blackbody operates over 280.0–350.0 K with radiometric accuracy ≤±0.25 K.

### 5.5 Attitude Determination, Control, and LOS Pointing Requirements (TRS Section 7.5)

### Requirement Verification: SSEG-REQ-ADCS-001 - 3-Axis Stabilization and Agile LOS Lock-On

* **Requirement Text**: "The 3-axis stabilized ADCS (WBS .02) coupled with the payload coarse gimbal and Fast Steering Mirror (FSM) control loop shall acquire and lock the optical Line of Sight (LOS) onto any cued target within &lt; 5.0 seconds of tracking command reception."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: AOCS/payload EM and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The AOCS EM and the SATL payload gimbal/FSM are mounted on the air-bearing/zero-gravity fixture. The spacecraft is powered in Mode N2, the star trackers and FOG are active, and the payload aperture is open. A tracking cue is sent to the AOCS/payload chain and the target simulator is acquired; the time from cue reception to LOS lock and the LOS error are measured. The bus is free to rotate on the air bearing.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture); MGSE-09 (optical alignment theodolite and autocollimator set)
  * **OGSE**: OGSE-02 (IR collimator); OGSE-04 (IR target/scene projector); OGSE-05 (star simulator); OGSE-08 (wavefront sensor, autocollimator and optical alignment targets)
* **Environment & Execution Constraints**: ISO Class 5 optics and ISO Class 8 bus; air-bearing cleanroom; FPA 65–95 K; reaction wheels and cryocoolers running; continuous power-on; target angular rates representative of the worst-case boost phase.
* **Considered Assumptions**: Analysis covers Mode N2, worst-case target angular rate, reaction-wheel saturation, FSM/gimbal limits, EOL actuator performance and the 99th-percentile acquisition case.
* **Tools & Models**: MATLAB/Simulink multibody AOCS/payload model, AGI STK 12 target geometry, and a Monte Carlo acquisition campaign.
* **Test Correlation & Validation**: Measured air-bearing lock-on time and LOS error are compared with the Simulink model; the model is updated with the measured inertia, wheel friction and FSM response.
* **Verification Pass/Fail Criteria**: The coupled AOCS/gimbal/FSM chain acquires and locks the optical LOS onto any cued target within &lt; 5.0 s of tracking-command reception, with the bus attitude excursion &lt; 0.05 deg. The target remains within the NFOV and the LOS error is within the FSM authority.

### Requirement Verification: SSEG-REQ-ADCS-002 - Optical Line-of-Sight Pointing Stability and Jitter

* **Requirement Text**: "During active surveillance and stereoscopic tracking, the coupled ADCS, structural micro-vibration isolators, and FSM control loop shall maintain optical LOS pointing stability (Relative Pointing Error drift and jitter rate) strictly below &lt; 2.0 arcsec/s ( &lt; 9.7 µrad/s RMS, 3σ over any 1.0 s integration window)."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: AOCS/structural EM and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The spacecraft QM/PFM (or AOCS/optical-bench EM) is mounted on the seismic isolation and zero-gravity fixture. Reaction wheels and cryocoolers are run at flight speeds, the gimbal performs representative slews, and the optical LOS jitter is measured with an autocollimator/quad-cell on the optical bench over 1.0 s windows. The payload is in Mode N1/N2 and the FSM loop is closed.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-06 (modal-survey fixture and suspension system); MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture); MGSE-09 (optical alignment theodolite and autocollimator set)
  * **OGSE**: OGSE-08 (wavefront sensor, autocollimator and optical alignment targets)
* **Environment & Execution Constraints**: ISO Class 5/8 cleanroom; ambient and TVAC hot/cold; reaction-wheel and cryocooler disturbance sources active; continuous power-on; structural boundary conditions representative of flight.
* **Considered Assumptions**: Analysis covers the worst-case reaction-wheel and cryocooler disturbance spectra, gimbal slew transients, thermal gradients and EOL isolator/FSM performance in Modes N1 and N2.
* **Tools & Models**: MSC Nastran/Abaqus finite-element model, MATLAB/Simulink jitter and FSM control model, and a measured disturbance-spectrum input.
* **Test Correlation & Validation**: The FEA model is correlated with the modal survey; the measured micro-vibration transmissibility and LOS jitter are used to update the jitter model.
* **Verification Pass/Fail Criteria**: Optical LOS pointing stability (relative pointing error drift and jitter rate) is &lt; 2.0 arcsec/s ( &lt; 9.7 urad/s RMS, 3 sigma over any 1.0 s integration window) in Modes N1 and N2, including the worst-case wheel/cooler/gimbal disturbance case.

### Requirement Verification: SSEG-REQ-ADCS-003 - Attitude and Line-of-Sight Knowledge Accuracy

* **Requirement Text**: "Using optical-bench-mounted dual star trackers and fibre-optic gyroscopes (FOG), each SATL spacecraft shall achieve an inertial Attitude and LOS Knowledge Error (AKE) of ≤ 12.0 µrad (≤ 2.5 arcsec, 1σ per axis), and each SATG spacecraft shall achieve an AKE ≤ 20.0 µrad (≤ 4.1 arcsec, 1σ per axis)."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: AOCS/optical-bench EM and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The spacecraft QM/PFM with dual optical-bench star trackers and FOG is installed in the star-simulator facility and TVAC chamber. The star simulator provides multiple reference star fields; the attitude and LOS knowledge are compared with the simulator truth over the full thermal range. The payload optical bench and telescope are at flight alignment.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-05 (thermal-vacuum (TVAC) chamber with solar simulator and shrouds); MGSE-06 (modal-survey fixture and suspension system); MGSE-09 (optical alignment theodolite and autocollimator set)
  * **OGSE**: OGSE-05 (star simulator); OGSE-08 (wavefront sensor, autocollimator and optical alignment targets)
* **Environment & Execution Constraints**: ISO Class 5 optics; TVAC hot/cold plateaus; star simulator with calibrated star positions; continuous power-on; thermo-elastic stability allowed to settle at each plateau.
* **Considered Assumptions**: Analysis covers EOL star-tracker and FOG errors, thermo-elastic distortion of the optical bench, alignment stability and worst-case thermal gradients for SATL and SATG.
* **Tools & Models**: MATLAB/Simulink Kalman-filter and AKE model, MSC Nastran thermo-elastic FEA, and a Monte Carlo error-budget campaign.
* **Test Correlation & Validation**: Measured star-simulator attitude and LOS knowledge are compared with the model at each thermal plateau; the FEA thermo-elastic model is updated with the measured alignment drift.
* **Verification Pass/Fail Criteria**: SATL inertial attitude and LOS knowledge error ≤12.0 urad (≤2.5 arcsec, 1 sigma per axis); SATG ≤20.0 urad (≤4.1 arcsec, 1 sigma per axis), over the full thermal range and at EOL.

### Requirement Verification: SSEG-REQ-ADCS-004 - Onboard Orbit Position and Time Synchronization

* **Requirement Text**: "Each spacecraft shall incorporate multi-constellation GNSS (Galileo/GPS) receivers and ultra-stable oscillators providing real-time onboard position knowledge ≤ 3.0 m (1σ for SATL) and ≤ 15.0 m (1σ for SATG), and UTC epoch timestamp synchronization within ≤ 50.0 µs across all 78 constellation nodes to support stereoscopic triangulation."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: GNSS/USO EM and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The multi-constellation GNSS receiver and ultra-stable oscillator are installed in the RF-shielded GNSS simulator facility. Galileo and GPS signals are simulated with realistic geometry, ionosphere and multipath; the position solution and UTC epoch are compared with truth. A three-node time-synchronisation test verifies the ≤50 us alignment across representative constellation nodes.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-06 (multi-constellation GNSS RF simulator)
  * **MGSE**: MGSE-05 (thermal-vacuum (TVAC) chamber with solar simulator and shrouds)
  * **OGSE**: None required for this verification.
* **Environment & Execution Constraints**: RF-shielded laboratory; TVAC hot/cold repeat; GNSS simulator with dynamic vehicle motion; continuous power-on; UTC reference from a calibrated time standard.
* **Considered Assumptions**: Analysis covers worst-case GDOP, ionospheric and multipath errors, receiver noise, USO drift, EOL performance and the 78-node synchronization chain.
* **Tools & Models**: GNSS constellation simulator, MATLAB/Simulink orbit-determination and time-sync model, and a Monte Carlo position/time error campaign.
* **Test Correlation & Validation**: Measured position and time errors are compared with the model; the Phase 3 precise orbit determination and GNSS data update the error budget.
* **Verification Pass/Fail Criteria**: Real-time onboard position knowledge ≤3.0 m (1 sigma) for SATL and ≤15.0 m (1 sigma) for SATG; UTC epoch synchronization ≤50.0 us across all 78 nodes. No cycle slip or time-tag discontinuity occurs.

### Requirement Verification: SSEG-REQ-ADCS-005 - Momentum Feed-Forward and Autonomous Detumbling

* **Requirement Text**: "The ADCS reaction wheel assembly (4 skewed wheels) shall provide real-time torque feed-forward compensation during payload gimbal slews to maintain spacecraft bus attitude excursions &lt; 0.05°, and shall damp post-separation launch tip-off rates from 10.0°/s to &lt; 0.1°/s within ≤ 30.0 minutes."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: AOCS EM and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The AOCS EM with four skewed reaction wheels is mounted on the air-bearing fixture. The payload gimbal performs representative slews while wheel torque feed-forward is active; the bus attitude excursion is measured. For detumbling, the air-bearing table is spun to 10.0 deg/s and the B-dot/reaction-wheel detumbling law is activated; the rate decay to &lt; 0.1 deg/s is recorded.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture)
  * **OGSE**: OGSE-08 (wavefront sensor, autocollimator and optical alignment targets)
* **Environment & Execution Constraints**: ISO Class 8 bus cleanroom; air-bearing fixture; reaction wheels at flight speed; continuous power-on; initial tip-off rate 10.0 deg/s; representative inertia and magnetic environment.
* **Considered Assumptions**: Analysis covers worst-case inertia, wheel saturation, magnetic torque availability, gimbal slew transients and EOL bearing/wheel performance.
* **Tools & Models**: MATLAB/Simulink multibody AOCS model, B-dot detumbling model, and a Monte Carlo inertia/tip-off campaign.
* **Test Correlation & Validation**: Measured bus excursion and detumbling time are compared with the Simulink model; the model is updated with the measured inertia and wheel friction.
* **Verification Pass/Fail Criteria**: Bus attitude excursion remains &lt; 0.05 deg during payload gimbal slews with torque feed-forward active. Post-separation tip-off is damped from 10.0 deg/s to &lt; 0.1 deg/s within ≤30.0 min without wheel saturation.

### 5.6 On-Board Data Handling and Stereoscopic Processing Requirements (TRS Section 7.6)

### Requirement Verification: SSEG-REQ-OBDH-001 - Real-Time Onboard Proton Despiking and Plume Filtering

* **Requirement Text**: "The OBDH payload processor (WBS .06.01/.06.03) shall execute real-time single-frame spatial/temporal proton despiking (rejecting South Atlantic Anomaly and polar proton spikes) and dual-band (SWIR/MWIR) background clutter rejection with a deterministic per-frame processing latency ≤ 50.0 ms."
* **Verification Method**: Test (T)
* **Applicable Model & Phase**: OBDH/PLD EM and QM/PFM, Phase 1; FM, Phase 3

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The OBDH EM runs the flight despiking and plume-filtering software and receives raw dual-band frames from the PLD EM FPA. Proton spikes are injected synthetically and, for selected runs, with a calibrated proton source; background scenes include clouds, glints, fires and aurorae. The per-frame processing latency and the rejection/detection performance are measured in Mode N1.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture)
  * **OGSE**: OGSE-01 (calibrated blackbody source (280-1,200 K)); OGSE-02 (IR collimator); OGSE-04 (IR target/scene projector)
* **Environment & Execution Constraints**: ISO Class 5 optics and ISO Class 8 avionics; FPA 65–95 K; continuous power-on; processor clock at worst-case flight frequency and temperature; SAA/polar spike timeline.
* **Verification Pass/Fail Criteria**: Deterministic per-frame processing latency ≤50.0 ms; ≥99% of injected proton spikes rejected; plume detection maintained with Pd &gt; 95%; no false track or filter divergence over the 30-day equivalent run.

### Requirement Verification: SSEG-REQ-OBDH-002 - Inter-Satellite Stereoscopic LOS Exchange and Onboard 3D Trajectory

* **Requirement Text**: "During Mode N2, the OBDH subsystems of the two cued SATL spacecraft shall exchange timestamped LOS unit observation vectors and 6 × 6 spacecraft position/attitude covariance matrices over the mandatory ISL network at ≥ 10.0 Hz to compute an onboard preliminary 3D target state vector (position and velocity with covariance) within ≤ 18.0 seconds of target lock-on."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: Two SATL OBDH/ISL EM benches and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: Two SATL OBDH EM benches exchange timestamped LOS unit vectors and 6x6 position/attitude covariance matrices over the OISL emulator at ≥10 Hz. A target projector provides the two LOS observations; the primary node computes the onboard preliminary 3D state vector. The state and covariance are compared with the truth trajectory. Both benches are in Mode N2 and the ISL terminals are in Mode N3.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-06 (multi-constellation GNSS RF simulator); EGSE-07 (OISL terminal emulator with optical channel attenuator/delay line); EGSE-08 (RF link emulator, channel simulator and spectrum analyser)
  * **MGSE**: MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture)
  * **OGSE**: OGSE-02 (IR collimator); OGSE-04 (IR target/scene projector); OGSE-05 (star simulator)
* **Environment & Execution Constraints**: ISO Class 5 optics; FPA 65–95 K; optical delay lines emulating 1,000–5,500 km; GNSS-disciplined time sync ≤50 us; continuous power-on; worst-case stereo geometry (beta = 30 and 120 deg).
* **Considered Assumptions**: Analysis covers the full stereo geometry range, worst-case LOS and covariance errors, GNSS time sync, EOL processor performance and the 18 s convergence requirement.
* **Tools & Models**: MATLAB/Simulink stereo-triangulation and Kalman-filter model, AGI STK 12 geometry, and a Monte Carlo covariance-consistency campaign.
* **Test Correlation & Validation**: The onboard 3D state and covariance are compared with the truth trajectory and with the ground fusion solution; the measurement model is updated with the measured AKE and time-sync performance.
* **Verification Pass/Fail Criteria**: LOS vectors and covariance matrices are exchanged at ≥10.0 Hz; the onboard preliminary 3D target state (position and velocity with covariance) is computed within ≤18.0 s of lock-on; the reported covariance contains the truth state at the 95% confidence level (NEES within chi-square bounds) for all tested geometries.

### Requirement Verification: SSEG-REQ-OBDH-003 - Dual-Product Formatting and Downlink Generation

* **Requirement Text**: "Both cued SATL spacecraft shall format and transmit to the Ground Segment both (1) their timestamped stereoscopic LEO Observation Packages (containing LOS unit vectors, viewing geometry, and attitude/ephemeris covariance metadata) and (2) the Onboard Preliminary Trajectory estimate, enabling the Ground Segment Data Processing System (123456.02.04) to perform authoritative multi-sensor fusion and Instantaneous Impact Point (IIP) estimation."
* **Verification Method**: Test (T)
* **Applicable Model & Phase**: Two SATL OBDH EM benches and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: Two SATL OBDH EM benches in Mode N2 generate the timestamped LEO Observation Packages and the Onboard Preliminary Trajectory. The downlink is captured by the Ground Station emulator over the emulated X/Ka-band and ISL relay paths. Packet content, ordering, timestamps, covariance metadata and data-quality flags are verified against the ICD and the Ground Segment Data Processing System emulator.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-03 (network data interface unit (NDIU)); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-07 (OISL terminal emulator with optical channel attenuator/delay line); EGSE-08 (RF link emulator, channel simulator and spectrum analyser)
  * **MGSE**: None required for this verification.
  * **OGSE**: None required for this verification.
* **Environment & Execution Constraints**: RF-shielded HIL laboratory; CCSDS TM/TC front-end; continuous power-on; nominal and worst-case link delays; simultaneous downlink from both SATL nodes.
* **Verification Pass/Fail Criteria**: Both cued SATL transmit a complete LEO Observation Package (LOS unit vectors, viewing geometry, attitude/ephemeris covariance metadata) and the Onboard Preliminary Trajectory. The Ground Segment Data Processing System emulator accepts both products without schema, checksum or timing error, and all mandatory ICD fields are present.

### Requirement Verification: SSEG-REQ-OBDH-004 - EDAC Memory Protection and TMR Fault Tolerance

* **Requirement Text**: "All OBDH flight computers and non-volatile mass memories (≥ 128.0 GB NAND/MRAM per SATL; ≥ 512.0 GB per SATG) shall implement hardware Error Detection and Correction (EDAC correcting all single-bit upsets and detecting all double-bit upsets with full memory scrubbing every ≤ 10.0 min), FPGA Triple Modular Redundancy (TMR), and independent hardware watchdog timers."
* **Verification Method**: Test (T), supported by Review of Design (R)
* **Applicable Model & Phase**: OBDH EM and QM/PFM, Phase 1; FM, Phase 3

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The OBDH EM/QM with EDAC memory, TMR FPGA logic and watchdog timers is operated in the fault-injection facility. Single-bit and double-bit errors are injected into RAM, NAND and MRAM; TMR flip-flops are upset; watchdog timeouts are forced. The correction/detection response, scrubbing interval and recovery are recorded. A heavy-ion/proton run is performed on representative memory and FPGA samples.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: None required for this verification.
  * **OGSE**: None required for this verification.
* **Environment & Execution Constraints**: ISO Class 8 avionics cleanroom; fault-injection laboratory; TVAC hot/cold repeat; biased devices at worst-case voltage and temperature; continuous power-on.
* **Supporting R/I Evidence**: R evidence: design review of the EDAC/TMR/watchdog architecture and memory budget (≥128 GB SATL, ≥512 GB SATG).
* **Verification Pass/Fail Criteria**: All single-bit upsets are corrected and all double-bit upsets detected in the ≥128.0 GB SATL and ≥512.0 GB SATG memories; full memory scrubbing completes every ≤10.0 min; TMR masks any single FPGA logic fault; independent watchdog timers reset the processor on a hang. No data corruption or loss of the critical telemetry chain occurs.

### Requirement Verification: SSEG-REQ-OBDH-005 - Encrypted Temporary Onboard Event Buffering

* **Requirement Text**: "Each spacecraft shall maintain an encrypted circular non-volatile event buffer retaining at least 72.0 hours of raw and processed event observations, housekeeping telemetry, and security audit logs to guarantee zero data loss prior to Ground Segment downlink and 5-year archival."
* **Verification Method**: Test (T), supported by Review of Design (R)
* **Applicable Model & Phase**: OBDH EM and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The OBDH EM/QM records 72 h of raw and processed event observations, housekeeping telemetry and security audit logs into the encrypted circular non-volatile buffer. The buffer is filled, overwritten, power-cycled and read back; the encryption at rest and the audit-log integrity are verified. The spacecraft is powered in Modes N1 and N2.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-05 (thermal-vacuum (TVAC) chamber with solar simulator and shrouds)
  * **OGSE**: None required for this verification.
* **Environment & Execution Constraints**: ISO Class 8 avionics; TVAC hot/cold; 72 h continuous recording; power-cycle and single-event reset injection; encrypted storage verified with the ground key management emulator.
* **Supporting R/I Evidence**: R evidence: design review of the encrypted buffer, key management and audit-log design.
* **Verification Pass/Fail Criteria**: At least 72.0 h of raw and processed event data, housekeeping telemetry and audit logs are retained without loss; the buffer operates as a circular store without corrupting the active record; all data are encrypted at rest; power-cycle and reset recovery preserve the stored records.

### Requirement Verification: SSEG-REQ-OBDH-006 - In-Orbit Flight Software and Algorithm Reprogrammability

* **Requirement Text**: "The OBDH Flight Software (WBS .06.03) shall support authenticated, encrypted over-the-air (OTA) updating of plume-classification filters, radiometric look-up tables, and tracking algorithms in redundant dual-image non-volatile boot banks with automatic rollback within ≤ 5.0 s upon checksum or watchdog failure."
* **Verification Method**: Test (T)
* **Applicable Model & Phase**: OBDH EM and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The OBDH EM/QM with redundant dual-image non-volatile boot banks is connected to the SVF and the ground key-management emulator. Authenticated and encrypted flight-software images are uploaded over the emulated OTA link; corrupted images, checksum failures and watchdog timeouts are injected. The rollback time and boot-bank integrity are measured. At least 100 upload cycles are performed.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: None required for this verification.
  * **OGSE**: None required for this verification.
* **Environment & Execution Constraints**: RF-shielded HIL laboratory; continuous power-on; OTA link with nominal and worst-case delay; TVAC hot/cold repeat; tamper and invalid-signature cases included.
* **Verification Pass/Fail Criteria**: Authenticated OTA updates of plume-classification filters, radiometric look-up tables and tracking algorithms are accepted; unsigned/tampered images are rejected; automatic rollback to the previous image completes within ≤5.0 s on checksum or watchdog failure. No upload cycle leaves the OBDH unbootable.

### 5.7 Communications and Mandatory ISL Network Requirements (TRS Section 7.7)

### Requirement Verification: SSEG-REQ-ISL-001 - Mandatory LEO Optical Inter-Satellite Link Mesh

* **Requirement Text**: "Each of the 72 SATL spacecraft (WBS .06.02) shall carry four (4) 1,550 nm laser Optical Inter-Satellite Link (OISL) terminals (2 permanent intra-plane fore/aft terminals and 2 agile cross-plane left/right terminals), each providing a full-duplex user data rate of ≥ 1.0 Gbps (2.5 Gbps design target) at a Bit Error Rate (BER) ≤ 10^-9 over inter-satellite ranges up to 5,500 km."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: OISL terminal EM and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: Four flight-representative OISL terminals are integrated on a SATL EM structure. Two intra-plane terminals are aligned fore/aft and two cross-plane terminals left/right. Each terminal is connected to an optical channel emulator with 5,500 km attenuation/delay; full-duplex data at the specified rate is transmitted while the terminals track a dynamic point-ahead and platform-motion stimulus. The spacecraft is powered in Mode N3.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-07 (OISL terminal emulator with optical channel attenuator/delay line); EGSE-08 (RF link emulator, channel simulator and spectrum analyser)
  * **MGSE**: MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture); MGSE-09 (optical alignment theodolite and autocollimator set)
  * **OGSE**: OGSE-06 (laser power meter and optical spectrum analyser)
* **Environment & Execution Constraints**: ISO Class 5 optical cleanroom; optical bench at flight alignment; vibration and TVAC hot/cold repeats; continuous power-on; background optical noise and platform jitter injected.
* **Considered Assumptions**: Analysis covers the 5,500 km worst-case range, four-terminal simultaneous operation, point-ahead and platform jitter, background/background-noise, EOL terminal performance and the 2.5 Gbps design target.
* **Tools & Models**: MATLAB/Simulink optical link-budget model, Zemax/FRED terminal optical model, AGI STK 12 inter-satellite geometry, and a Monte Carlo pointing/link campaign.
* **Test Correlation & Validation**: Measured BER versus received optical power is compared with the link-budget model; terminal PAT and optical antenna patterns are updated from the measured data.
* **Verification Pass/Fail Criteria**: On each of the 72 SATL, all four 1,550 nm terminals provide full-duplex ≥1.0 Gbps (2.5 Gbps design target) at BER ≤1e-9 over 5,500 km. All four links operate simultaneously, acquire and maintain lock under the specified platform jitter, and no terminal causes interference with another.

### Requirement Verification: SSEG-REQ-ISL-002 - Mandatory Cross-Layer GEO-LEO Relay Links

* **Requirement Text**: "The 6 SATG and 72 SATL spacecraft shall incorporate cross-layer GEO–LEO inter-satellite transceivers (Ka-band RF trunks at ≥ 50.0 Mbps and optical laser relay trunks at ≥ 1.0 Gbps over link ranges of 34,800 km to 40,000 km) providing continuous bidirectional command and observation trunking between the LEO tracking layer and European ground gateways."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: Cross-layer terminal EM and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: A SATG Ka-band/optical cross-layer terminal and a SATL optical terminal are integrated in the RF-shielded and optical test facility. The link is emulated over 34,800–40,000 km with variable delay and atmospheric-free space loss. Bidirectional command and observation trunking is exercised while the terminals track the dynamic LEO–GEO geometry. Both spacecraft are powered in Mode N3.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-07 (OISL terminal emulator with optical channel attenuator/delay line); EGSE-08 (RF link emulator, channel simulator and spectrum analyser)
  * **MGSE**: MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture); MGSE-09 (optical alignment theodolite and autocollimator set)
  * **OGSE**: OGSE-06 (laser power meter and optical spectrum analyser)
* **Environment & Execution Constraints**: RF-shielded anechoic chamber and ISO Class 5 optical bench; TVAC hot/cold; continuous power-on; worst-case range and pointing error; Ka-band and optical links tested separately and simultaneously.
* **Considered Assumptions**: Analysis covers the 34,800–40,000 km range, worst-case pointing and atmospheric-free space loss, solar conjunction, EOL terminal performance and continuous trunking availability.
* **Tools & Models**: TICRA GRASP/CST Studio Suite antenna models, MATLAB/Simulink RF and optical link-budget model, AGI STK 12 GEO–LEO geometry, and a Monte Carlo link-availability campaign.
* **Test Correlation & Validation**: Measured Ka-band and optical BER/throughput are compared with the link-budget model; antenna patterns and terminal PAT are updated from the measured data.
* **Verification Pass/Fail Criteria**: On all 6 SATG and 72 SATL, the Ka-band trunk provides ≥50.0 Mbps and the optical trunk ≥1.0 Gbps over 34,800–40,000 km, with continuous bidirectional command and observation trunking. BER remains within the specified limits and no link outage occurs over the tested geometry.

### Requirement Verification: SSEG-REQ-ISL-003 - Space-to-Ground TT&C and High-Rate Mission Links

* **Requirement Text**: "Each spacecraft shall provide redundant S-band/X-band TT&C links (uplink ≥ 256.0 kbps, downlink ≥ 2.0 Mbps, BER ≤ 10^-7) and high-rate X-band/Ka-band mission data downlinks (≥ 150.0 Mbps for SATL; ≥ 300.0 Mbps for SATG, BER ≤ 10^-9) compliant with CCSDS 131.0-B (RD-02, IF-EXT-01)."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: TT&C/mission transponder EM and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The redundant S-band/X-band TT&C transponders and the X-band/Ka-band mission downlink are integrated in the RF anechoic chamber. CCSDS test equipment measures uplink/downlink rates, BER, link margin and spectral compliance at the worst-case range and elevation. The spacecraft is powered in Modes N1 and N3; the high-gain antenna is pointed by the AOCS.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-08 (RF link emulator, channel simulator and spectrum analyser)
  * **MGSE**: MGSE-09 (optical alignment theodolite and autocollimator set)
  * **OGSE**: None required for this verification.
* **Environment & Execution Constraints**: RF anechoic chamber; TVAC hot/cold; EMC chamber; continuous power-on; antenna at worst-case pointing and 5 deg elevation; CCSDS 131.0-B framing.
* **Considered Assumptions**: Analysis covers the worst-case slant range and elevation, antenna pointing error, EOL transmitter power, rain-free space path, and the CCSDS 131.0-B/141.0-B protocol overhead.
* **Tools & Models**: TICRA GRASP/CST Studio Suite antenna models, MATLAB/Simulink RF link-budget model, AGI STK 12 ground-station geometry, and a CCSDS frame-error-rate model.
* **Test Correlation & Validation**: Measured antenna patterns, transmitter power and BER are compared with the model; the link budget is updated with the as-built RF chain losses.
* **Verification Pass/Fail Criteria**: Redundant S-band/X-band TT&C: uplink ≥256.0 kbps, downlink ≥2.0 Mbps, BER ≤1e-7. High-rate mission downlink: ≥150.0 Mbps for SATL and ≥300.0 Mbps for SATG, BER ≤1e-9, compliant with CCSDS 131.0-B. All links operate with positive margin at worst-case range and elevation.

### Requirement Verification: SSEG-REQ-ISL-004 - End-to-End Cryptographic Security and Authentication

* **Requirement Text**: "All space-to-ground and inter-satellite communication links shall implement hardware-based AES-256-GCM (or EU/NATO sovereign Level-1 equivalent) bulk data encryption and cryptographic telecommand authentication (CCSDS 355.0-B Space Data Link Security) with over-the-air key rotation and tamper-triggered zero-ization capability."
* **Verification Method**: Test (T), supported by Review of Design (R)
* **Applicable Model & Phase**: COMSEC module EM and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The hardware COMSEC module is integrated with the TT&C and OISL terminals. The ground crypto emulator establishes keys; AES-256-GCM encryption and CCSDS 355.0-B authentication are exercised on all space-to-ground and inter-satellite links. Key rotation, tamper detection and zeroisation are tested, including a physical tamper event on the EM.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-08 (RF link emulator, channel simulator and spectrum analyser)
  * **MGSE**: None required for this verification.
  * **OGSE**: OGSE-06 (laser power meter and optical spectrum analyser)
* **Environment & Execution Constraints**: RF-shielded security laboratory; controlled key-management facility; TVAC hot/cold repeat; continuous power-on; tamper and side-channel test cases.
* **Supporting R/I Evidence**: R evidence: security architecture review and CCSDS 355.0-B compliance review.
* **Verification Pass/Fail Criteria**: All space-to-ground and inter-satellite links use AES-256-GCM (or EU/NATO Level-1 equivalent) encryption and CCSDS 355.0-B cryptographic telecommand authentication. Key rotation completes without link loss; a tamper event triggers zeroisation within the specified time; no plaintext or unauthenticated command is accepted.

### Requirement Verification: SSEG-REQ-ISL-005 - Anti-Jamming and Anti-Spoofing Protection

* **Requirement Text**: "All RF space-to-ground and cross-layer links shall employ Direct-Sequence Spread Spectrum (DSSS) or frequency-hopping modulation and null-steering antenna processing providing a jamming resistance processing gain ≥ 20.0 dB, while narrow-beam ( &lt; 20.0 µrad divergence) 1,550 nm OISL links shall provide physical immunity to terrestrial RF jamming and interception."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: RF/OISL terminal EM and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The RF TT&C and cross-layer links are established in the anechoic chamber with a calibrated jammer and spoofer. DSSS/frequency-hopping and null-steering are activated; the jamming resistance processing gain and BER are measured over the specified jammer-to-signal ratios. The OISL terminal is tested with an off-axis receiver to confirm the narrow-beam immunity.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-08 (RF link emulator, channel simulator and spectrum analyser)
  * **MGSE**: None required for this verification.
  * **OGSE**: OGSE-06 (laser power meter and optical spectrum analyser)
* **Environment & Execution Constraints**: RF-shielded anechoic chamber; calibrated jammer/spoofer; TVAC hot/cold; continuous power-on; worst-case jammer geometry and power.
* **Considered Assumptions**: Analysis covers the worst-case jammer power and geometry, spoofing scenarios, EOL antenna/transmitter performance and the OISL narrow-beam immunity.
* **Tools & Models**: CST Studio Suite/GRASP antenna and null-steering model, MATLAB/Simulink anti-jam link-budget model, and a Monte Carlo jammer/spoofer campaign.
* **Test Correlation & Validation**: Measured processing gain, null depth and BER are compared with the model; the antenna and null-steering models are updated with the measured patterns.
* **Verification Pass/Fail Criteria**: Jamming resistance processing gain ≥20.0 dB; BER remains within the specified TT&C/mission limits under the worst-case jammer; no spoofed command is accepted. The 1,550 nm OISL with &lt; 20.0 urad divergence is physically immune to terrestrial RF jamming and interception.

### Requirement Verification: SSEG-REQ-ISL-006 - Autonomous QoS Mesh Routing and Failover

* **Requirement Text**: "The SSEG ISL network shall implement autonomous Quality-of-Service (QoS) packet routing that immediately preempts routine housekeeping traffic for Priority-0 warning-chain messages (GEO Event Reports, LEO Tracking Requests, LOS Vectors, and Preliminary Trajectories) and automatically reroutes packets around any failed node or degraded link within &lt; 200.0 ms."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: ISL network EM and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: A scaled ISL network test-bed with at least 12 OISL terminal emulators and the ground gateway emulator runs the flight QoS routing software. Priority-0 warning-chain messages (GEO Event Reports, LEO Tracking Requests, LOS vectors, Preliminary Trajectories) are injected concurrently with routine housekeeping traffic. Nodes and links are failed; the preemption and reroute times are measured.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-07 (OISL terminal emulator with optical channel attenuator/delay line); EGSE-08 (RF link emulator, channel simulator and spectrum analyser)
  * **MGSE**: None required for this verification.
  * **OGSE**: OGSE-06 (laser power meter and optical spectrum analyser)
* **Environment & Execution Constraints**: RF-shielded HIL network laboratory; optical delay/attenuation emulating the constellation; continuous power-on; worst-case traffic load and multiple failure scenarios.
* **Considered Assumptions**: Analysis covers the full 78-node topology, worst-case traffic load, single and multiple node/link failures, EOL processor performance and the 200 ms reroute requirement.
* **Tools & Models**: NS-3/OPNET network simulation with the constellation topology, AGI STK 12 visibility, and a queueing/priority model.
* **Test Correlation & Validation**: Measured preemption and reroute times are compared with the simulation; the emulator latencies are used to update the network model.
* **Verification Pass/Fail Criteria**: Priority-0 warning-chain messages immediately preempt routine housekeeping traffic; packets are rerouted around any failed node or degraded link within &lt; 200.0 ms; no warning-chain message is lost during the failure scenarios.

### Requirement Verification: SSEG-REQ-ISL-007 - ITU Spectral Compliance and Laser Safety Interlocks

* **Requirement Text**: "All RF transmitters shall comply with ITU Radio Regulations (RD-03) spectral masks and power-flux-density limits, and all 1,550 nm laser OISL terminals shall incorporate automatic beam-shutter interlocks preventing illumination of sub-orbital aviation airspace ( &lt; 20.0 km altitude) or non-cooperative satellites."
* **Verification Method**: Test (T), supported by Review of Design (R)
* **Applicable Model & Phase**: RF/OISL terminal EM and FM, Phase 1 and Phase 3

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The RF transmitters are operated in the anechoic chamber and the spectral mask, EIRP and power-flux density are measured with a calibrated spectrum analyser at the specified offsets. The 1,550 nm OISL terminal is operated into a beam dump and an aviation-airspace detector; the automatic beam-shutter interlock is triggered and its response is measured.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-08 (RF link emulator, channel simulator and spectrum analyser)
  * **MGSE**: MGSE-09 (optical alignment theodolite and autocollimator set)
  * **OGSE**: OGSE-06 (laser power meter and optical spectrum analyser)
* **Environment & Execution Constraints**: RF anechoic chamber and laser-safe optical laboratory; TVAC hot/cold; continuous power-on; controlled laser safety area with beam blocks and aviation-airspace simulation.
* **Supporting R/I Evidence**: R evidence: ITU/regulatory compliance review and laser-safety review.
* **Verification Pass/Fail Criteria**: All RF transmitters comply with the ITU Radio Regulations spectral masks and power-flux-density limits. The 1,550 nm OISL beam-shutter interlock prevents illumination of sub-orbital aviation airspace ( &lt; 20.0 km) and of non-cooperative satellites; the shutter closes within the specified response time.

### 5.8 Platform Subsystem Requirements (STR/MEC, TCS, EPS, PROP) (TRS Section 7.8)

### Requirement Verification: SSEG-REQ-PLAT-001 - Spacecraft Mass Envelopes and Dispenser Compatibility

* **Requirement Text**: "The wet launch mass (including system mass margin and propellant) of each SATL spacecraft (WBS .08) shall not exceed 280.0 kg (enabling 9 SATL spacecraft to be launched on a single multi-satellite dispenser stack ≤ 2,600.0 kg), and the wet launch mass of each SATG spacecraft shall not exceed 2,800.0 kg."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: SATL/SATG QM/PFM and FM, Phase 1; launch-site fit check, Phase 2

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The SATL and SATG QM/PFM are weighed on the mass-properties fixture in the stowed launch configuration. The centre of gravity and inertia tensor are measured. A SATL is mounted on the 9-satellite dispenser ring and a SATG on the 1,194 mm and 1,666 mm adapter simulators; interference, bolt pattern and umbilical routing are checked.
* **Required GSE**:
  * **EGSE**: EGSE-01 (spacecraft power/umbilical simulator); EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-09 (pyrotechnic/NEA safe-and-arm test plug set)
  * **MGSE**: MGSE-01 (lifting/handling rig, clamp band and spacecraft stand); MGSE-02 (mass-properties measurement fixture); MGSE-08 (9-satellite dispenser ring and 1,194/1,666 mm launch-vehicle adapter simulator)
  * **OGSE**: None required for this verification.
* **Environment & Execution Constraints**: ISO Class 8 cleanroom; stowed launch configuration with clamp band and hold-downs installed; spacecraft powered OFF or on un-switched bus; mass-properties fixture calibrated before use.
* **Considered Assumptions**: Analysis covers the mass budget with system margin, propellant loading, EOL mass, launch loads and dispenser/adapter interfaces.
* **Tools & Models**: Mass-budget tracking model, CAD fit-check model and MSC Nastran/Abaqus launch-load model.
* **Test Correlation & Validation**: Measured mass, centre of gravity and inertia are compared with the mass budget and the FEA model; the measured values update the launch-load and attitude-control models.
* **Verification Pass/Fail Criteria**: SATL wet launch mass ≤280.0 kg; nine-SATL dispenser stack ≤2,600.0 kg; SATG wet launch mass ≤2,800.0 kg. Centre of gravity and inertia lie within the dispenser/launch-vehicle ICD; the fit check shows no interference and all umbilical connectors mate.

### Requirement Verification: SSEG-REQ-PLAT-002 - Stowed Structural Fundamental Frequencies

* **Requirement Text**: "In the stowed launch configuration, the fundamental structural resonance frequencies (WBS .08) shall satisfy f_axial ≥ 35.0 Hz and f_lateral ≥ 20.0 Hz for SATL, and f_axial ≥ 31.0 Hz and f_lateral ≥ 15.0 Hz for SATG per ECSS-E-ST-32C (AD-09)."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: STM and QM/PFM, Phase 1; FM acceptance survey

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The STM and QM/PFM are mounted on the shaker table in the stowed launch configuration. A low-level sine sweep and modal survey identify the fundamental axial and lateral modes; the qualification sine/random vibration is then performed in three axes. The FM undergoes a workmanship random-vibration survey.
* **Required GSE**:
  * **EGSE**: EGSE-01 (spacecraft power/umbilical simulator); EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench)
  * **MGSE**: MGSE-03 (three-axis shaker table with slip table and accelerometer array); MGSE-06 (modal-survey fixture and suspension system)
  * **OGSE**: None required for this verification.
* **Environment & Execution Constraints**: Cleanroom shaker facility; stowed configuration with launch clamps; three orthogonal axes; sine 5–100 Hz and random 20–2,000 Hz at the specified qualification levels; accelerometers bonded to the primary structure.
* **Considered Assumptions**: Analysis covers the stowed FEA model with worst-case mass and joint stiffness, launch quasi-static loads, sine/random spectra and EOL stiffness.
* **Tools & Models**: MSC Nastran/Abaqus normal-modes and frequency-response analysis, and a modal-survey correlation/updating tool.
* **Test Correlation & Validation**: The FEA model is correlated with the measured modal survey; frequencies and mode shapes are updated to within the project correlation criteria before the flight prediction is released.
* **Verification Pass/Fail Criteria**: SATL stowed fundamental frequencies: axial ≥35.0 Hz and lateral ≥20.0 Hz. SATG: axial ≥31.0 Hz and lateral ≥15.0 Hz. No mode below the limit, no adverse coupling with the launch vehicle/dispenser, and the FM survey confirms the qualification model.

### Requirement Verification: SSEG-REQ-PLAT-003 - Micro-Vibration Isolation of Optical Bench

* **Requirement Text**: "The STR/MEC subsystem (WBS .08) shall incorporate tuned viscoelastic/fluid damping mounts between the reaction wheels, cryocooler compressors, and optical bench providing ≥ 25.0 dB mechanical transmissibility attenuation above 40.0 Hz to support &lt; 2.0 arcsec/s LOS pointing stability."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: STM/QM optical bench and QM/PFM, Phase 1; FM, Phase 3

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The optical bench with flight-representative viscoelastic/fluid isolators is mounted on the shaker/air-bearing fixture. Reaction-wheel and cryocooler simulators apply the specified disturbance spectra; the transmissibility across the isolators and the LOS jitter are measured above 40 Hz. The payload is in Mode N1/N2 with the FSM loop closed.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-06 (modal-survey fixture and suspension system); MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture); MGSE-09 (optical alignment theodolite and autocollimator set)
  * **OGSE**: OGSE-08 (wavefront sensor, autocollimator and optical alignment targets)
* **Environment & Execution Constraints**: ISO Class 5 optical bench; ambient and TVAC hot/cold; reaction-wheel/cryocooler disturbance sources active; continuous power-on; flight boundary conditions.
* **Considered Assumptions**: Analysis covers the worst-case wheel/cooler disturbance spectra, isolator temperature dependence, EOL isolator performance and the full Mode N1/N2 jitter environment.
* **Tools & Models**: MSC Nastran/Abaqus FEA with the isolator model, MATLAB/Simulink jitter model, and a measured disturbance-spectrum input.
* **Test Correlation & Validation**: Measured transmissibility and LOS jitter are compared with the FEA/jitter model; the isolator properties are updated from the measured data.
* **Verification Pass/Fail Criteria**: Attenuation ≥25.0 dB above 40.0 Hz between the reaction wheel/cryocooler and the optical bench, and the resulting LOS stability remains &lt; 2.0 arcsec/s, in Modes N1 and N2.

### Requirement Verification: SSEG-REQ-PLAT-004 - Thermal Control Operating Limits

* **Requirement Text**: "The TCS (WBS .01) shall maintain all internal platform electronics within -10.0°C to +50.0°C (0.0°C to +30.0°C for Li-ion batteries) with at least ± 10.0 K qualification margin per ECSS-E-ST-31C (AD-08) across all sunlit and eclipse phases."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: STM/QM/PFM and FM, Phase 1; FM, Phase 3

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The QM/PFM is installed in the TVAC chamber with the solar simulator and flight thermal hardware. The spacecraft is operated in Modes N1, N2 and N5 through hot and cold plateaus; platform electronics, battery and payload-interface temperatures are measured at the worst-case internal dissipation.
* **Required GSE**:
  * **EGSE**: EGSE-01 (spacecraft power/umbilical simulator); EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-05 (thermal-vacuum (TVAC) chamber with solar simulator and shrouds)
  * **OGSE**: None required for this verification.
* **Environment & Execution Constraints**: TVAC ≤1e-5 mbar, shroud -70 to +100 C, solar simulator at 1,322–1,414 W/m2, albedo 0.25–0.38 and Earth IR 210–260 W/m2; at least eight hot/cold cycles; qualification temperature margin ≥10 K.
* **Considered Assumptions**: Analysis covers the maximum and minimum solar flux, albedo, Earth IR, eclipse duration, EOL thermal properties and all nominal modes.
* **Tools & Models**: ESATAN-TMS/Thermal Desktop-SINDA 3D nodal thermal model, correlated with the thermal-balance test data.
* **Test Correlation & Validation**: The thermal model is correlated with the TVAC thermal-balance measurements; conductive/radiative couplings are adjusted until the predicted temperatures match the measured values within the project correlation tolerance.
* **Verification Pass/Fail Criteria**: All internal platform electronics remain within -10.0 to +50.0 C and Li-ion batteries within 0.0 to +30.0 C, with at least ±10.0 K qualification margin, in all sunlit and eclipse phases and all nominal modes.

### Requirement Verification: SSEG-REQ-PLAT-005 - End-of-Life Electrical Power Generation

* **Requirement Text**: "The EPS (WBS .03) triple-junction GaAs solar arrays shall deliver an End-of-Life (EOL) orbital average power of ≥ 550.0 W (≥ 650.0 W peak tracking load) for SATL at 7 years, and ≥ 4,200.0 W (≥ 5,000.0 W peak) for SATG at 15 years, maintaining a positive power margin ≥ 15.0% in all nominal modes."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: EPS QM/PFM and FM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The EPS QM/PFM with flight solar-array simulator, battery and representative loads is operated in the TVAC chamber. The solar-array simulator is programmed to the EOL degradation curve for 7-year SATL / 15-year SATG; orbital-average and peak tracking loads are applied in Modes N1, N2 and N3. Array I-V curves and battery state are measured.
* **Required GSE**:
  * **EGSE**: EGSE-01 (spacecraft power/umbilical simulator); EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-10 (solar-array simulator and Li-ion battery simulator)
  * **MGSE**: MGSE-05 (thermal-vacuum (TVAC) chamber with solar simulator and shrouds)
  * **OGSE**: None required for this verification.
* **Environment & Execution Constraints**: TVAC hot/cold; AM0 solar spectrum; EOL array degradation; maximum eclipse; continuous power-on; battery at flight temperature.
* **Considered Assumptions**: Analysis covers the worst-case solar flux, array degradation, temperature, eclipse duration, EOL battery capacity and all nominal modes with a ≥15% power margin.
* **Tools & Models**: MATLAB/Simulink power-budget model, SPENVIS radiation-degradation model, and an EPS load-flow model.
* **Test Correlation & Validation**: Measured array I-V curves and battery performance are compared with the power-budget model; the model is updated with the measured degradation and harness losses.
* **Verification Pass/Fail Criteria**: SATL EOL orbital-average power ≥550.0 W (≥650.0 W peak tracking load); SATG ≥4,200.0 W (≥5,000.0 W peak). A positive power margin ≥15.0% is maintained in all nominal modes.

### Requirement Verification: SSEG-REQ-PLAT-006 - Eclipse Battery Storage and DoD Limits

* **Requirement Text**: "The EPS Li-ion battery packs shall support full payload, OBDH, and ISL operation throughout maximum orbital eclipses (≤ 35.1 min per orbit for SATL over ≥ 35,000 cycles; ≤ 71.5 min equinox eclipses for SATG over ≥ 1,350 cycles) without exceeding a maximum Depth of Discharge (DoD) of 30.0% for SATL and 65.0% for SATG."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: Battery QM/PFM and FM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The Li-ion battery QM/PFM is installed in the TVAC chamber and subjected to the maximum eclipse discharge profile for SATL (35.1 min) and SATG (71.5 min), followed by the specified charge profile. Depth of discharge, temperature and voltage are measured over accelerated cycles (≥35,000 for SATL, ≥1,350 for SATG).
* **Required GSE**:
  * **EGSE**: EGSE-01 (spacecraft power/umbilical simulator); EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-10 (solar-array simulator and Li-ion battery simulator)
  * **MGSE**: MGSE-05 (thermal-vacuum (TVAC) chamber with solar simulator and shrouds)
  * **OGSE**: None required for this verification.
* **Environment & Execution Constraints**: TVAC hot/cold; maximum eclipse profile; battery at 0–30 C; accelerated charge/discharge cycling; continuous telemetry.
* **Considered Assumptions**: Analysis covers the maximum eclipse duration, EOL capacity degradation, worst-case load, temperature extremes and the specified cycle life.
* **Tools & Models**: MATLAB/Simulink battery model, cell-test data and a reliability/cycle-life model.
* **Test Correlation & Validation**: The battery model is correlated with the measured cell and pack performance; end-of-cycle capacity and impedance are used to update the EOL prediction.
* **Verification Pass/Fail Criteria**: SATL maximum DoD ≤30.0% over ≥35,000 cycles with eclipses up to 35.1 min; SATG maximum DoD ≤65.0% over ≥1,350 cycles with equinox eclipses up to 71.5 min. No thermal runaway, cell imbalance beyond the specified limit, or capacity below the EOL requirement.

### Requirement Verification: SSEG-REQ-PLAT-007 - Propulsion Delta-v Capacity for SATL

* **Requirement Text**: "Each SATL propulsion subsystem (WBS .05) shall provide a total deliverable Δ v ≥ 320.0 m/s over 7 years, allocated to initial Walker Delta phasing (≥ 35.0 m/s), station-keeping (≥ 35.0 m/s), collision avoidance (≥ 20.0 m/s), and protected active End-of-Life deorbitation from 1,000 km (≥ 230.0 m/s)."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: SATL propulsion module QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The SATL propulsion module is installed on the thrust stand in the vacuum chamber. Thrust, mass flow and specific impulse are measured for the flight thruster operating points; the deliverable Delta-v is integrated over the 7-year manoeuvre profile (phasing, station-keeping, collision avoidance and EOL deorbit).
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-05 (thermal-vacuum (TVAC) chamber with solar simulator and shrouds); MGSE-01 (lifting/handling rig, clamp band and spacecraft stand)
  * **OGSE**: None required for this verification.
* **Environment & Execution Constraints**: TVAC ≤1e-5 mbar; propellant loaded to the flight configuration; thrust stand calibrated; continuous telemetry; worst-case duty cycle.
* **Considered Assumptions**: Analysis covers the 7-year mission, launch injection dispersions, station-keeping, collision avoidance, EOL deorbit from 1,000 km, propellant residual and thruster degradation.
* **Tools & Models**: AGI STK 12/Orekit 12 manoeuvre and Delta-v budget model, and a propulsion performance model anchored to the thrust-stand data.
* **Test Correlation & Validation**: Measured thrust, Isp and mass flow are used to update the Delta-v budget; the in-orbit LEOP phasing burn performance provides the final correlation.
* **Verification Pass/Fail Criteria**: Total deliverable Delta-v ≥320.0 m/s over 7 years from 1,000 km, with allocations ≥35.0 m/s for initial Walker Delta phasing, ≥35.0 m/s for station-keeping, ≥20.0 m/s for collision avoidance and ≥230.0 m/s for protected EOL deorbitation. Positive propellant margin remains at EOL.

### Requirement Verification: SSEG-REQ-PLAT-008 - Propulsion Delta-v Capacity for SATG

* **Requirement Text**: "Each SATG propulsion subsystem (WBS .05) shall provide a total deliverable Δ v ≥ 810.0 m/s over 15 years, allocated to north–south and east–west geostationary station-keeping (≥ 780.0 m/s equivalent), momentum wheel desaturation (≥ 15.0 m/s), and mandatory End-of-Life super-synchronous graveyard re-orbitation (Δ v_EOL ≥ 15.0 m/s for Δ H ≥ +300.0 km)."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: SATG propulsion module QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The SATG propulsion module is installed on the thrust stand in the vacuum chamber. Thrust, mass flow and Isp are measured for the apogee/station-keeping thruster operating points; the deliverable Delta-v is integrated over the 15-year station-keeping, momentum desaturation and graveyard re-orbit profile.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-05 (thermal-vacuum (TVAC) chamber with solar simulator and shrouds); MGSE-01 (lifting/handling rig, clamp band and spacecraft stand)
  * **OGSE**: None required for this verification.
* **Environment & Execution Constraints**: TVAC ≤1e-5 mbar; propellant loaded to flight configuration; thrust stand calibrated; continuous telemetry; worst-case duty cycle.
* **Considered Assumptions**: Analysis covers the 15-year GEO mission, lunisolar station-keeping, momentum desaturation, EOL graveyard re-orbit (Delta H ≥+300 km), propellant residual and thruster degradation.
* **Tools & Models**: AGI STK 12/Orekit 12 GEO station-keeping and Delta-v budget model, and a propulsion performance model anchored to the thrust-stand data.
* **Test Correlation & Validation**: Measured thrust, Isp and mass flow update the Delta-v budget; in-orbit station-keeping manoeuvre performance provides the final correlation.
* **Verification Pass/Fail Criteria**: Total deliverable Delta-v ≥810.0 m/s over 15 years, covering ≥780.0 m/s equivalent north-south/east-west station-keeping, ≥15.0 m/s momentum-wheel desaturation and ≥15.0 m/s EOL graveyard re-orbit for Delta H ≥+300.0 km.

### Requirement Verification: SSEG-REQ-PLAT-009 - Deployment Mechanisms and Hold-Down Reliability

* **Requirement Text**: "All solar array, antenna, and payload aperture cover hold-down and release mechanisms (WBS .08) shall employ non-explosive actuators (NEAs) with redundant initiation circuits achieving a deployment reliability ≥ 0.9995 and a positive torque/force margin ≥ 100% per ECSS-E-ST-33-01C (AD-09)."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: QM/PFM and FM, Phase 1; FM, Phase 3

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The solar-array, antenna and aperture-cover hold-down/release mechanisms are mounted on the zero-gravity deployment fixture. Each NEA is fired with its redundant initiation circuit; deployment torque/force, position indication and latch-up are measured. At least 100 deploy/stow cycles are performed, with vibration and TVAC before and after.
* **Required GSE**:
  * **EGSE**: EGSE-01 (spacecraft power/umbilical simulator); EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-09 (pyrotechnic/NEA safe-and-arm test plug set)
  * **MGSE**: MGSE-01 (lifting/handling rig, clamp band and spacecraft stand); MGSE-05 (thermal-vacuum (TVAC) chamber with solar simulator and shrouds); MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture)
  * **OGSE**: OGSE-08 (wavefront sensor, autocollimator and optical alignment targets)
* **Environment & Execution Constraints**: ISO Class 8 cleanroom; zero-gravity offload; TVAC hot/cold; vibration before/after; continuous instrumentation; NEA safe-and-arm plugs installed.
* **Considered Assumptions**: Analysis covers worst-case friction, thermal distortion, vacuum effects, NEA output and the 0.9995 deployment reliability target.
* **Tools & Models**: MSC Adams multibody deployment model, a Monte Carlo reliability analysis, and a torque/force margin calculation.
* **Test Correlation & Validation**: Measured deployment torque/force, timing and latch-up are compared with the multibody model; friction and spring properties are updated from the test data.
* **Verification Pass/Fail Criteria**: Deployment reliability ≥0.9995, positive torque/force margin ≥100% for every mechanism, and successful deployment in ≥100 consecutive cycles. All redundant initiation circuits function and every deployment microswitch indicates the correct state.

### Requirement Verification: SSEG-REQ-PLAT-010 - Propulsion Plume and Optical Impingement Avoidance

* **Requirement Text**: "All propulsion thrusters (WBS .05) and internal outgassing vents shall be positioned and canted such that exhaust plume half-cone angles (99.9% mass flux contour) maintain at least 15.0° angular clearance from the SWIR/MWIR stray-light baffles and the 1,550 nm OISL optical terminals."
* **Verification Method**: Analysis (A), supported by Inspection (I)
* **Applicable Model & Phase**: Analysis and inspection, Phase 1

#### Verification Strategy & Execution Plan:
* **Considered Assumptions**: The analysis covers all thrusters and internal outgassing vents, the 99.9% mass-flux plume contour, the SWIR/MWIR stray-light baffles and the 1,550 nm OISL terminals. It includes worst-case plume expansion in vacuum, thermal-vacuum operation and EOL contamination limits.
* **Tools & Models**: Direct Simulation Monte Carlo (SPARTA/DS2V) plume model, CFD analysis, CAD layout inspection and a contamination/deposition model.
* **Test Correlation & Validation**: Plume model predictions are compared with available thruster plume test data and with thermal-vacuum contamination measurements; the CAD layout is verified against the as-built spacecraft.
* **Supporting R/I Evidence**: I evidence: inspection of the as-built thruster/vent layout and cant angles against the analysis model.
* **Verification Pass/Fail Criteria**: The 99.9% exhaust plume half-cone maintains ≥15.0 deg angular clearance from the SWIR/MWIR stray-light baffles and the 1,550 nm OISL optical terminals. No plume impingement or outgassing deposition exceeds the contamination limit in any mode.

### 5.9 Environmental, Radiation, and Space Sustainability Requirements (TRS Section 7.9)

### Requirement Verification: SSEG-REQ-ENV-001 - Total Ionizing Dose and Careful COTS Shielding

* **Requirement Text**: "Incorporating a 2× Radiation Design Margin (RDM) per ECSS-E-ST-10-04C (AD-06) and localized graded-Z Al/Ta spot shielding (WBS .08), all SATL components shall withstand the 7-year 1,000 km, 80° radiation environment (≥ 30.0 krad(Si) behind 4.0 mm Al; ≤ 15.0 krad(Si) inside spot-shielded enclosures), and all SATG components shall withstand the 15-year 35,786 km GEO environment (≥ 100.0 krad(Si) behind 4.0 mm Al; ≤ 25.0 krad(Si) inside vault shielding)."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: Component/board radiation tests and QM/PFM, Phase 1; FM lot acceptance, Phase 1

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: Representative boards and units are biased and irradiated in a Co-60/proton facility to the SATL 30 krad(Si) and SATG 100 krad(Si) total-dose requirements behind 4 mm Al, with and without the flight graded-Z spot shielding. Functional and parametric tests are performed at intermediate dose steps and after the final dose; the shielded internal dose is measured with dosimeters.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: None required for this verification.
  * **OGSE**: None required for this verification.
* **Environment & Execution Constraints**: Radiation facility with calibrated Co-60/proton source; biased devices at worst-case voltage and temperature; dosimeters at the component and enclosure locations; TVAC functional checks before and after irradiation.
* **Considered Assumptions**: Analysis covers the AP-8/AE-8/IRENE AE9/AP9 and SAPPHIRE environments, 2x radiation design margin, 7-year SATL and 15-year SATG exposure, and the graded-Z Al/Ta shielding configuration.
* **Tools & Models**: SPENVIS/OMERE/ESABASE2 radiation transport models, a 2x RDM dose-depth analysis, and a Monte Carlo shielding campaign.
* **Test Correlation & Validation**: Measured dose-depth and component degradation are compared with the transport model; the shielding model is updated with the as-built harness and spot-shield geometry.
* **Verification Pass/Fail Criteria**: In the 7-year 1,000 km, 80 deg SATL environment, components withstand ≥30.0 krad(Si) behind 4.0 mm Al and ≤15.0 krad(Si) inside spot-shielded enclosures. In the 15-year 35,786 km GEO environment, SATG components withstand ≥100.0 krad(Si) behind 4.0 mm Al and ≤25.0 krad(Si) inside vault shielding. All units remain functional at the EOL dose.

### Requirement Verification: SSEG-REQ-ENV-002 - Single-Event Latch-Up Immunity and Current Limiting

* **Requirement Text**: "All electronic components aboard SATL and SATG shall either be immune to destructive Single-Event Latch-up (SEL) up to a Linear Energy Transfer threshold LET_th ≥ 37.0 MeV\cdotcm^2/mg or be protected by autonomous fast-trip ( &lt; 1.0 ms) current limiters with automatic power-rail recovery."
* **Verification Method**: Test (T), supported by Review of Design (R)
* **Applicable Model & Phase**: Component/unit radiation tests, Phase 1

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: Representative components and units are tested with heavy ions at increasing LET up to and above 37.0 MeV cm2/mg and with protons. The device is biased at worst-case voltage and temperature; SEL current, power-rail response and the autonomous fast-trip limiter are monitored. The limiter trip time and automatic recovery are measured.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: None required for this verification.
  * **OGSE**: None required for this verification.
* **Environment & Execution Constraints**: Heavy-ion/proton accelerator; vacuum chamber; biased devices at worst-case voltage and temperature; current probe with &lt; 1 ms resolution.
* **Supporting R/I Evidence**: R evidence: design review of the SEL protection and current-limiter architecture.
* **Verification Pass/Fail Criteria**: No destructive SEL occurs at LET ≥37.0 MeV cm2/mg, or the autonomous limiter trips in &lt; 1.0 ms and the rail recovers automatically. No permanent damage or loss of the critical function occurs.

### Requirement Verification: SSEG-REQ-ENV-003 - Electrostatic Discharge and Charging Mitigation

* **Requirement Text**: "All external spacecraft surfaces, optical windows (Indium Tin Oxide coated), and MLI blankets shall be electrically conductive and grounded to the primary structure (maintaining surface potential differentials &lt; 100.0 V) in compliance with ECSS-E-ST-20-06C (AD-07)."
* **Verification Method**: Test (T), supported by Inspection (I)
* **Applicable Model & Phase**: QM/PFM and FM, Phase 1; FM, Phase 3

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The spacecraft QM/PFM is inspected and tested for surface conductivity and grounding. Surface resistivity, bond resistance and MLI/ITO coating continuity are measured on all external surfaces. A plasma/ESD test is performed to measure surface potential differentials under representative GEO/LED charging conditions.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-09 (optical alignment theodolite and autocollimator set)
  * **OGSE**: OGSE-08 (wavefront sensor, autocollimator and optical alignment targets)
* **Environment & Execution Constraints**: ISO Class 8 cleanroom; plasma/ESD chamber or vacuum facility; controlled humidity; representative GEO substorm and LEO auroral charging conditions.
* **Supporting R/I Evidence**: I evidence: inspection of the grounding/bonding records and surface finishes.
* **Verification Pass/Fail Criteria**: All external surfaces, ITO-coated optical windows and MLI blankets are electrically conductive and grounded to the primary structure; surface potential differentials remain &lt; 100.0 V in the representative charging environment. Bond resistances meet the ECSS-E-ST-20-06C limits.

### Requirement Verification: SSEG-REQ-ENV-004 - Outgassing and Molecular Contamination Control

* **Requirement Text**: "All non-metallic materials used in SATL and SATG shall satisfy Total Mass Loss TML &lt; 1.0% and Collected Volatile Condensable Material CVCM &lt; 0.01% per ECSS-Q-ST-70-02C, and the TCS shall execute a 72.0–96.0 h in-orbit decontamination bake-out at 310.0–320.0 K prior to cryocooler cooldown."
* **Verification Method**: Test (T), supported by Inspection (I)
* **Applicable Model & Phase**: Material/component tests, Phase 1; FM bake-out, Phase 3

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: All non-metallic materials are tested per ASTM E595/ECSS-Q-ST-70-02C for TML and CVCM. The QM/PFM and FM spacecraft undergo a 72–96 h thermal-vacuum bake-out at 310–320 K before cryocooler cooldown; QCMs and pressure gauges monitor the residual outgassing. The optical aperture covers remain closed during the bake-out.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-05 (thermal-vacuum (TVAC) chamber with solar simulator and shrouds)
  * **OGSE**: OGSE-01 (calibrated blackbody source (280-1,200 K)); OGSE-02 (IR collimator)
* **Environment & Execution Constraints**: TVAC ≤1e-5 mbar; 310–320 K bake-out for 72–96 h; QCM contamination monitoring; ISO Class 5 optical cavity with GN2 purge before and after.
* **Supporting R/I Evidence**: I evidence: inspection of the material list, certificates and bake-out records.
* **Verification Pass/Fail Criteria**: All non-metallic materials have TML &lt; 1.0% and CVCM &lt; 0.01%. The 72.0–96.0 h bake-out at 310.0–320.0 K reduces the residual outgassing to the specified level; no condensable contamination is detected on the cold optics or QCMs above the limit.

### Requirement Verification: SSEG-REQ-ENV-005 - MMOD Protection and Collision Avoidance

* **Requirement Text**: "Structural shielding (WBS .08) of pressurized tanks, batteries, and redundant harnesses shall achieve a Probability of No Penetration PNP ≥ 0.99 per spacecraft over its design lifetime against untrackable debris ( &lt; 1.0 cm), and each spacecraft shall execute a ground-commanded or autonomous Collision Avoidance Manoeuvre (CAM) within ≤ 12.0 hours whenever a Conjunction Data Message indicates collision probability P_c &gt; 10^-4."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: Coupon/panel hypervelocity tests and QM/PFM, Phase 1; analysis and FM operations, Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: Whipple/honeycomb shield coupons representative of the tank, battery and harness protection are subjected to hypervelocity impacts at 11–14.5 km/s. The penetration and damage are measured and compared with the PNP model. The collision-avoidance function is exercised in HIL with a CDM injection; the CAM execution time is measured.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-01 (lifting/handling rig, clamp band and spacecraft stand)
  * **OGSE**: None required for this verification.
* **Environment & Execution Constraints**: Hypervelocity impact facility; vacuum; representative LEO debris velocities; HIL for the CAM function; continuous telemetry.
* **Considered Assumptions**: Analysis covers the MASTER-8 debris environment, 7-year SATL and 15-year SATG exposure, the PNP ≥0.99 target and all conjunction geometries with Pc &gt; 1e-4.
* **Tools & Models**: ESABASE2/MASTER-8 MMOD model, a Whipple/shield penetration model, AGI STK 12 conjunction and CAM analysis, and a Monte Carlo PNP campaign.
* **Test Correlation & Validation**: Measured hypervelocity impact damage is compared with the PNP model; the shield model is updated with the as-built panel configuration.
* **Verification Pass/Fail Criteria**: Probability of no penetration ≥0.99 per spacecraft over the design lifetime for untrackable debris &lt; 1.0 cm. A ground-commanded or autonomous CAM is executed within ≤12.0 h whenever a CDM indicates Pc &gt; 1e-4.

### Requirement Verification: SSEG-REQ-ENV-006 - Mandatory End-of-Life Disposal for LEO and GEO

* **Requirement Text**: "In compliance with R-018, ECSS-U-AS-10C (AD-12), and the ESA Zero Debris Charter (RD-01), every SATL spacecraft shall execute active retrograde deorbitation from 1,000 km at End of Life to guarantee complete atmospheric demise within &lt; 5.0 years (≥ 99.0% disposal reliability and ground casualty risk &lt; 10^-4), and every SATG spacecraft shall re-orbit to a super-synchronous graveyard orbit at least Δ H ≥ +300.0 km above 35,786 km (Δ e ≤ 0.0005)."
* **Verification Method**: Analysis (A), supported by Review of Design (R)
* **Applicable Model & Phase**: Analysis and R, Phase 6; correlated with propulsion and orbit-determination data

#### Verification Strategy & Execution Plan:
* **Considered Assumptions**: The analysis covers SATL active deorbitation from 1,000 km to complete demise within &lt; 5 years with ≥99.0% disposal reliability and ground casualty risk &lt; 1e-4, and SATG re-orbit to a super-synchronous graveyard at Delta H ≥+300 km with Delta e ≤0.0005. EOL mass, residual propellant, drag and solar-cycle variations are included.
* **Tools & Models**: AGI STK 12/Orekit 12 deorbit and graveyard propagation, ESA DRAMA re-entry/casualty model, and a Monte Carlo disposal-reliability campaign.
* **Test Correlation & Validation**: The disposal Delta-v budget is correlated with the propulsion test data and the in-orbit orbit-determination/manoeuvre performance; the drag model is updated with the measured solar-cycle response.
* **Supporting R/I Evidence**: R evidence: review of the disposal plan, Zero Debris compliance and ECSS-U-AS-10C compliance.
* **Verification Pass/Fail Criteria**: Every SATL completes atmospheric demise within &lt; 5.0 years, with ≥99.0% disposal reliability and ground casualty risk &lt; 1e-4. Every SATG reaches a graveyard orbit at Delta H ≥+300.0 km above 35,786 km with Delta e ≤0.0005.

### Requirement Verification: SSEG-REQ-ENV-007 - End-of-Life Spacecraft Passivation

* **Requirement Text**: "Upon completion of End-of-Life disposal manoeuvres, each SATL and SATG spacecraft shall permanently vent or deplete all residual propellants and pressurants, open battery charging relays, spin down reaction wheels and cryocoolers, and disable all RF and optical transmitters."
* **Verification Method**: Test (T), supported by Review of Design (R)
* **Applicable Model & Phase**: QM/PFM and FM, Phase 3; analysis/procedure review, Phase 6

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The passivation sequence is exercised on the QM/PFM in the TVAC chamber and on the FM during end-to-end testing. Residual propellant/pressurant venting, battery relay opening, reaction-wheel/cryocooler spin-down and RF/OISL transmitter disable are commanded; the residual pressure, battery current and RF/optical emissions are measured.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-08 (RF link emulator, channel simulator and spectrum analyser)
  * **MGSE**: MGSE-05 (thermal-vacuum (TVAC) chamber with solar simulator and shrouds)
  * **OGSE**: OGSE-06 (laser power meter and optical spectrum analyser)
* **Environment & Execution Constraints**: TVAC ≤1e-5 mbar; EOL configuration; RF-shielded chamber for transmitter-disable verification; continuous telemetry until final power-off.
* **Supporting R/I Evidence**: R evidence: review of the passivation procedure and ECSS-U-AS-10C compliance.
* **Verification Pass/Fail Criteria**: All residual propellants and pressurants are vented or depleted to zero differential pressure; battery charging relays are permanently open; reaction wheels and cryocoolers are spun down; all RF and optical transmitters are disabled. No residual emission or energetic source remains.

### 5.10 Operational, Autonomy, Product Assurance, and Interface Requirements (TRS Section 7.10)

### Requirement Verification: SSEG-REQ-OPS-001 - Operational Design Lifetimes

* **Requirement Text**: "Each SATL spacecraft shall be designed and qualified for an in-orbit operational lifetime of ≥ 7.0 years at 1,000 km LEO, and each SATG spacecraft shall be designed and qualified for an in-orbit operational lifetime of ≥ 15.0 years at 35,786 km GEO."
* **Verification Method**: Analysis (A), supported by Review of Design (R)
* **Applicable Model & Phase**: Analysis and R, Phase 1; qualified for Phase 4 operations

#### Verification Strategy & Execution Plan:
* **Considered Assumptions**: The analysis covers the 7-year SATL and 15-year SATG missions, all nominal modes, radiation, thermal cycling, battery cycling, propulsion, mechanisms and EOL performance. Worst-case environment and component degradation are included.
* **Tools & Models**: Reliability/life model, SPENVIS radiation model, thermal-cycle and battery-cycle life models, and a Monte Carlo wear-out analysis.
* **Test Correlation & Validation**: The life predictions are correlated with the qualification test durations, accelerated life-test data, and the FM acceptance test results.
* **Supporting R/I Evidence**: R evidence: design life review and qualification test dossier.
* **Verification Pass/Fail Criteria**: SATL qualified for ≥7.0 years at 1,000 km LEO and SATG for ≥15.0 years at 35,786 km GEO. No wear-out mechanism limits the design life, and all EOL performance requirements remain met.

### Requirement Verification: SSEG-REQ-OPS-002 - No Single-Point Failure Redundancy Architecture

* **Requirement Text**: "Critical spacecraft functional chains (OBDH, TT&C/ISL, EPS/PCDU, ADCS sensors/actuators, and cryocooler drive electronics) shall implement block or cross-strapped redundancy (A/B chains) per ECSS-Q-ST-30C (AD-11) such that no single component failure degrades constellation detection or stereoscopic tracking performance."
* **Verification Method**: Analysis (A), supported by Review of Design (R)
* **Applicable Model & Phase**: Analysis and R, Phase 1; verified by FDIR HIL and FM test data

#### Verification Strategy & Execution Plan:
* **Considered Assumptions**: The analysis covers all critical chains (OBDH, TT&C/ISL, EPS/PCDU, ADCS sensors/actuators and cryocooler drive electronics), all nominal modes, single-failure cases and the 7/15-year mission.
* **Tools & Models**: Reliability block diagram, fault-tree analysis (FTA), FMEA, Markov model and a Monte Carlo failure/availability simulation.
* **Test Correlation & Validation**: Failure rates and redundancy switching are correlated with FDIR HIL test results and FM acceptance data; on-orbit telemetry updates the model.
* **Supporting R/I Evidence**: R evidence: design review of the redundancy architecture and FMEA.
* **Verification Pass/Fail Criteria**: No single component failure degrades constellation detection or stereoscopic tracking performance below the requirements. All critical chains have block or cross-strapped A/B redundancy and the FDIR switchover meets the ≤2.0 s requirement.

### Requirement Verification: SSEG-REQ-OPS-003 - Autonomous FDIR Failover and Safe Mode Recovery

* **Requirement Text**: "Onboard FDIR logic shall detect and isolate unit-level faults and switch to redundant hardware within ≤ 2.0 seconds (Level 2), and upon a severe bus anomaly (Level 3), shall automatically close the payload aperture shutter and acquire a power-safe Sun-pointing attitude within ≤ 60.0 seconds without ground intervention."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: OBDH/AOCS EM and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The spacecraft QM/PFM or EM HIL is operated in Mode N1/N2 while unit-level faults and bus anomalies are injected: OBDH processor hang, star-tracker loss, reaction-wheel failure, cryocooler drive fault and main-bus under-voltage. The FDIR response, redundant-unit switchover, aperture-cover closure and Sun-pointing acquisition are measured.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-05 (thermal-vacuum (TVAC) chamber with solar simulator and shrouds); MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture)
  * **OGSE**: OGSE-05 (star simulator)
* **Environment & Execution Constraints**: ISO Class 8/5 cleanroom; HIL and TVAC hot/cold; sun simulator for Safe-Mode acquisition; continuous power-on; fault injection synchronized with the flight software.
* **Considered Assumptions**: Analysis covers all unit-level fault classes, severe bus anomalies, the three FDIR levels, EOL processor performance and the no-ground-intervention requirement.
* **Tools & Models**: MATLAB/Simulink FDIR and AOCS model, fault-tree analysis, and a Monte Carlo fault-injection campaign.
* **Test Correlation & Validation**: Measured FDIR detection/isolation times and Safe-Mode acquisition are compared with the model; the FDIR timing parameters are updated from the HIL data.
* **Verification Pass/Fail Criteria**: Level-2 FDIR detects and isolates unit faults and switches to redundant hardware within ≤2.0 s. Level-3 Safe Mode closes the payload aperture shutter and acquires a power-safe Sun-pointing attitude within ≤60.0 s without ground intervention.

### Requirement Verification: SSEG-REQ-OPS-004 - 72-Hour Autonomous Constellation Operation

* **Requirement Text**: "The SSEG constellation shall maintain full Mode N1 boost-phase surveillance and Mode N3 ISL mesh routing autonomously for at least 72.0 hours without ground station contact."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: Constellation HIL and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: A 78-node constellation emulator (or a representative scaled subset with the full flight software) is operated for 72 h without ground contact. All nodes run Modes N1 and N3; launch events are injected, ISL links are failed, and the autonomous routing, event detection, storage and recovery are monitored.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-07 (OISL terminal emulator with optical channel attenuator/delay line); EGSE-08 (RF link emulator, channel simulator and spectrum analyser)
  * **MGSE**: None required for this verification.
  * **OGSE**: OGSE-02 (IR collimator); OGSE-04 (IR target/scene projector)
* **Environment & Execution Constraints**: RF-shielded HIL laboratory; 72 h continuous power-on; no ground station contact; worst-case traffic and link failures; GNSS-disciplined time.
* **Considered Assumptions**: Analysis covers 72 h without ground contact, all nominal modes, single and multiple failures, worst-case traffic and EOL processor performance.
* **Tools & Models**: AGI STK 12 constellation geometry, NS-3 network simulation, MATLAB/Simulink FDIR/autonomy model, and a 72 h Monte Carlo campaign.
* **Test Correlation & Validation**: The HIL 72 h run is compared with the simulation; any autonomous-mode transition or buffer overflow is fed back into the FDIR/autonomy model.
* **Verification Pass/Fail Criteria**: Full Mode N1 boost-phase surveillance and Mode N3 ISL mesh routing are maintained autonomously for at least 72.0 h without ground station contact. Injected events are detected, stored and recovered; no node enters an unrecoverable state.

### Requirement Verification: SSEG-REQ-OPS-005 - Launch Safety Inhibits

* **Requirement Text**: "All hazardous spacecraft systems (propulsion valves, non-explosive release actuators, high-power RF amplifiers, and Class 3B/4 laser OISL diodes) shall incorporate at least three (3) independent mechanical or electrical safety inhibits during on-ground AIT and launch ascent per ECSS-Q-ST-40C (AD-11)."
* **Verification Method**: Test (T), supported by Inspection (I)
* **Applicable Model & Phase**: QM/PFM and FM, Phase 1; launch-site verification, Phase 2

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The spacecraft is inspected in the launch configuration. At least three independent mechanical/electrical inhibits are verified on propulsion valves, NEA release circuits, high-power RF amplifiers and Class 3B/4 laser OISL diodes. Safe-and-arm test plugs are installed, no-fire current is measured, and the arming/removal sequence is demonstrated.
* **Required GSE**:
  * **EGSE**: EGSE-01 (spacecraft power/umbilical simulator); EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-09 (pyrotechnic/NEA safe-and-arm test plug set)
  * **MGSE**: MGSE-01 (lifting/handling rig, clamp band and spacecraft stand)
  * **OGSE**: OGSE-06 (laser power meter and optical spectrum analyser)
* **Environment & Execution Constraints**: ISO Class 8 launch-site cleanroom; stowed launch configuration; safe-and-arm plugs installed; no-fire current test at the specified margin; ESD-controlled area.
* **Supporting R/I Evidence**: I evidence: inspection of the inhibit installation and safe/arm plug configuration.
* **Verification Pass/Fail Criteria**: At least three independent mechanical or electrical safety inhibits are present on every hazardous system; no-fire current is below the specified threshold; the arming sequence requires all inhibits to be removed in the correct order. Compliance with ECSS-Q-ST-40C is demonstrated.

### Requirement Verification: SSEG-REQ-OPS-006 - Health Housekeeping Telemetry and Anomaly Logging

* **Requirement Text**: "Each spacecraft shall generate continuous health and status housekeeping telemetry packets at ≥ 1.0 Hz (including subsystem temperatures, bus voltages, FDIR status counters, and ISL link margins) for real-time monitoring by the Ground Segment Mission Control Center (123456.02.03)."
* **Verification Method**: Test (T), supported by Review of Design (R)
* **Applicable Model & Phase**: OBDH/TT&C EM and FM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The spacecraft EM/FM generates housekeeping telemetry while the Ground Segment Mission Control Center emulator records and displays it. Subsystem temperatures, bus voltages, FDIR status counters and ISL link margins are checked for content, rate and continuity over at least 24 h, including Mode transitions and a Safe-Mode recovery.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-03 (network data interface unit (NDIU)); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: None required for this verification.
  * **OGSE**: None required for this verification.
* **Environment & Execution Constraints**: RF-shielded HIL/ground-network laboratory; continuous power-on; 24 h recording; nominal and worst-case link delays.
* **Supporting R/I Evidence**: R evidence: review of the telemetry database and housekeeping packet ICD.
* **Verification Pass/Fail Criteria**: Continuous health and status housekeeping telemetry is generated at ≥1.0 Hz, including all specified parameters. No gap exceeds the telemetry sampling interval, all packets are time-tagged and accepted by the MCC emulator, and the FDIR status counters are correct.

### Requirement Verification: SSEG-REQ-IF-001 - Space-to-Ground ICD Compliance (IF-EXT-01)

* **Requirement Text**: "All SSEG housekeeping telemetry, tracking commands, GEO Event Reports, LEO Observation Packages, and Onboard Preliminary Trajectories exchanged across IF-EXT-01 shall conform strictly to the packet schemas, timing, and cryptographic boundaries defined in the Space Segment ICD (123456.05.02.04) and Ground Segment Data Dictionary (Chapter 12 of AD-01)."
* **Verification Method**: Test (T), supported by Inspection (I)
* **Applicable Model & Phase**: FM/EM and ground ICD test-bed, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The spacecraft is connected to the Ground Segment ICD test-bed. All housekeeping telemetry, tracking commands, GEO Event Reports, LEO Observation Packages and Onboard Preliminary Trajectories are exchanged over the emulated IF-EXT-01 link. Packet schemas, timing, cryptographic boundaries and error handling are verified against the Space Segment ICD and the Ground Segment Data Dictionary.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-03 (network data interface unit (NDIU)); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-08 (RF link emulator, channel simulator and spectrum analyser)
  * **MGSE**: None required for this verification.
  * **OGSE**: None required for this verification.
* **Environment & Execution Constraints**: RF-shielded end-to-end laboratory; CCSDS/space-link security test set; continuous power-on; nominal and worst-case link delays; ICD-controlled packet captures.
* **Supporting R/I Evidence**: I evidence: inspection of the ICD, data dictionary and as-built interface configuration.
* **Verification Pass/Fail Criteria**: Every IF-EXT-01 packet conforms to the ICD schema, timing and cryptographic boundaries. The Ground Segment Data Dictionary parser accepts all packets without error, and no mandatory field, checksum or authentication tag is missing.

### Requirement Verification: SSEG-REQ-IF-002 - Dispenser and Launch Vehicle Interface Compliance (IF-EXT-02)

* **Requirement Text**: "SATL mechanical bolt patterns, separation springs (Δ v_sep = 0.5–1.5 m/s, tip-off &lt; 2.0°/s), center-of-gravity offsets, and umbilical connectors across IF-EXT-02 shall comply with 9-satellite-per-plane cylindrical rideshare dispenser rings, and SATG adapters shall comply with standard 1,194 mm or 1,666 mm heavy-lift launch vehicle interface rings per ECSS-E-ST-10-24C (AD-14)."
* **Verification Method**: Test (T), supported by Inspection (I)
* **Applicable Model & Phase**: QM/PFM and FM, Phase 1; launch-site verification, Phase 2

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The SATL is mounted on the 9-satellite cylindrical rideshare dispenser and the SATG on the 1,194 mm and 1,666 mm adapter simulators. Bolt patterns, separation springs, CoG offsets, umbilical connectors and separation kinematics are checked. A separation test measures Delta-v and tip-off rate.
* **Required GSE**:
  * **EGSE**: EGSE-01 (spacecraft power/umbilical simulator); EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-09 (pyrotechnic/NEA safe-and-arm test plug set)
  * **MGSE**: MGSE-01 (lifting/handling rig, clamp band and spacecraft stand); MGSE-02 (mass-properties measurement fixture); MGSE-08 (9-satellite dispenser ring and 1,194/1,666 mm launch-vehicle adapter simulator)
  * **OGSE**: None required for this verification.
* **Environment & Execution Constraints**: ISO Class 8 cleanroom; stowed launch configuration; separation test stand; umbilical mated; spacecraft powered OFF or un-switched bus.
* **Supporting R/I Evidence**: I evidence: inspection of the mechanical interface and fit-check records.
* **Verification Pass/Fail Criteria**: Bolt patterns, separation springs (Delta-v 0.5–1.5 m/s, tip-off &lt; 2.0 deg/s), CoG offsets and umbilical connectors comply with the 9-satellite dispenser and the 1,194/1,666 mm launch-vehicle interfaces per ECSS-E-ST-10-24C. The separation test shows no re-contact or interference.

### Requirement Verification: SSEG-REQ-IF-003 - Target Plume Radiometric Interface Compliance (IF-EXT-03)

* **Requirement Text**: "The SSEG optical payloads and onboard discrimination algorithms across IF-EXT-03 shall operate without pixel saturation across plume radiant intensities from 50.0 kW/sr to 10.0 MW/sr against sunlit cloud tops, Earth-limb airglow, and industrial thermal clutter backgrounds."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: PLD/OBDH EM and QM/PFM, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The PLD EM/QM and OBDH EM are operated with the IR scene projector over the full plume radiance range 50 kW/sr to 10 MW/sr against sunlit cloud tops, Earth-limb airglow and industrial thermal clutter. Pixel saturation, dynamic range, radiometric linearity and plume discrimination are measured in Modes N1 and N2.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture)
  * **OGSE**: OGSE-01 (calibrated blackbody source (280-1,200 K)); OGSE-02 (IR collimator); OGSE-03 (integrating sphere); OGSE-04 (IR target/scene projector)
* **Environment & Execution Constraints**: ISO Class 5 optics; FPA 65–95 K; calibrated radiance source; continuous power-on; worst-case background and sun-glint geometry.
* **Considered Assumptions**: Analysis covers the full radiance range, all specified backgrounds, EOL detector performance and the no-saturation requirement.
* **Tools & Models**: MODTRAN 6/HITRAN radiometric scene model, MATLAB/Simulink detector model, and a Monte Carlo radiance/background campaign.
* **Test Correlation & Validation**: Measured pixel response and saturation thresholds are compared with the radiometric model; the model is updated with the measured PLD dynamic range.
* **Verification Pass/Fail Criteria**: The payload and onboard discrimination algorithms operate without pixel saturation across plume radiant intensities from 50.0 kW/sr to 10.0 MW/sr against the specified backgrounds. Radiometric linearity and plume discrimination are maintained over the full range.

### Requirement Verification: SSEG-REQ-IF-004 - Space Traffic Management and Regulatory Interface (IF-EXT-04)

* **Requirement Text**: "The SSEG shall ingest standardized CCSDS Conjunction Data Messages (CDMs) relayed from the Ground Segment Mission Control Center across IF-EXT-04 and execute collision-avoidance trajectories, ITU spectral compliance, and ECSS-U-AS-10C (AD-12) disposal reporting."
* **Verification Method**: Test (T), supported by Review of Design (R)
* **Applicable Model & Phase**: FM/EM and ground STM test-bed, Phase 1; FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The Ground Segment Mission Control Center emulator ingests CCSDS Conjunction Data Messages over the emulated IF-EXT-04 interface. The spacecraft executes the commanded collision-avoidance trajectory; the ITU spectral-compliance and ECSS-U-AS-10C disposal reports are generated and checked.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-03 (network data interface unit (NDIU)); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: None required for this verification.
  * **OGSE**: None required for this verification.
* **Environment & Execution Constraints**: RF-shielded HIL laboratory; CDM generator; continuous power-on; representative conjunction geometries and Pc values.
* **Supporting R/I Evidence**: R evidence: review of the STM/regulatory interface and CDM processing procedure.
* **Verification Pass/Fail Criteria**: The spacecraft ingests standard CCSDS CDMs and executes collision-avoidance trajectories within ≤12.0 h for Pc &gt; 1e-4. ITU spectral compliance and ECSS-U-AS-10C disposal reporting are demonstrated for all required cases.

### 5.11 Verification Requirements (TRS Section 7.11)

### Requirement Verification: SSEG-REQ-VER-001 - Multi-Scenario Constellation and Radiometric Simulation

* **Requirement Text**: "SSEG compliance with 24/7 Baltic and extra-regional coverage (R-006–R-008), boost-phase detection probability (P_d &gt; 95.0%, R-010), stereoscopic viewing geometry (30.0° ≤ β ≤ 120.0°), and the ≤ 45.0 s Space Segment latency allocation (R-011) shall be verified via astrodynamic and radiometric Monte Carlo simulation campaigns encompassing ≥ 1,000 representative launch trajectories across SRBM, MRBM, IRBM, and ICBM threat profiles."
* **Verification Method**: Analysis (A)
* **Applicable Model & Phase**: Analysis, Phase 1; updated with Phase 3/4 data

#### Verification Strategy & Execution Plan:
* **Considered Assumptions**: The campaign covers at least 1,000 representative launch trajectories across SRBM, MRBM, IRBM and ICBM profiles, all Baltic and extra-regional corridors, all seasons, maximum eclipse, sunlit cloud clutter, EOL constellation geometry and the 99th-percentile latency.
* **Tools & Models**: AGI STK 12/Orekit 12 astrodynamics and coverage simulation, MATLAB/Simulink radiometric and warning-chain model, MODTRAN 6/HITRAN plume/background model, and a 10,000-run Monte Carlo driver.
* **Test Correlation & Validation**: The simulation is correlated with the HIL radiometric/timing measurements and with Phase 3/4 on-orbit data; model parameters are updated before each verification review.
* **Verification Pass/Fail Criteria**: The campaign demonstrates 24/7 Baltic and extra-regional coverage, Pd &gt; 95.0%, a valid stereo pair (30.0 ≤ beta ≤ 120.0 deg) for every trajectory, and SSEG latency ≤45.0 s at 99% confidence for at least 1,000 representative trajectories.

### Requirement Verification: SSEG-REQ-VER-002 - Hardware-in-the-Loop Testing of Sensing, LOS, and OBDH/ISL

* **Requirement Text**: "Prior to flight deployment, the SWIR/MWIR focal plane readout, OBDH proton-despiking and stereoscopic 3D triangulation pipeline (R-022, R-023), dual-stage gimbal + FSM &lt; 5.0 s lock-on and &lt; 2.0 arcsec/s stabilization loop (R-024), and encrypted OISL routing protocols (R-031, R-044) shall undergo closed-loop Hardware-in-the-Loop (HIL) testing on the Engineering and Qualification Models (WBS 123456.04.02.02)."
* **Verification Method**: Test (T)
* **Applicable Model & Phase**: EM/QM HIL, Phase 1; FM selected tests, Phase 3

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The SWIR/MWIR FPA readout, OBDH proton-despiking and stereoscopic 3D triangulation pipeline, dual-stage gimbal + FSM control loop and encrypted OISL routing protocols are integrated in the HIL facility. Closed-loop target injection, ISL emulation and ground-command injection are performed in Modes N1, N2 and N3.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-07 (OISL terminal emulator with optical channel attenuator/delay line); EGSE-08 (RF link emulator, channel simulator and spectrum analyser)
  * **MGSE**: MGSE-07 (zero-gravity/air-bearing gravity-compensation fixture); MGSE-09 (optical alignment theodolite and autocollimator set)
  * **OGSE**: OGSE-01 (calibrated blackbody source (280-1,200 K)); OGSE-02 (IR collimator); OGSE-04 (IR target/scene projector); OGSE-05 (star simulator)
* **Environment & Execution Constraints**: ISO Class 5 optics and ISO Class 8 avionics; FPA 65–95 K; RF-shielded HIL; continuous power-on; worst-case jitter and link delays.
* **Verification Pass/Fail Criteria**: All specified HIL functions pass: FPA readout and despiking latency ≤50 ms, stereo 3D state within 18 s, gimbal/FSM lock-on &lt; 5.0 s with LOS stability &lt; 2.0 arcsec/s, and encrypted OISL routing with no unauthenticated packet. No functional anomaly remains open.

### Requirement Verification: SSEG-REQ-VER-003 - Environmental Qualification and Batch Acceptance Testing

* **Requirement Text**: "The lead SATL and SATG Qualification / Proto-Flight Models (QM/PFM) and all recurring Flight Models (FM-01 to FM-72 for SATL; FM-01 to FM-06 for SATG) shall undergo mechanical vibration, shock, acoustic, thermal-vacuum (TVAC), and electromagnetic compatibility (EMC) testing in strict accordance with ECSS-E-ST-10-03C (AD-05)."
* **Verification Method**: Test (T)
* **Applicable Model & Phase**: QM/PFM and all FM, Phase 1; launch-site acceptance, Phase 2

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: The lead SATL and SATG QM/PFM and every recurring FM undergo the specified environmental test sequence: sine and random vibration, acoustic noise, shock, TVAC and EMC. The spacecraft is in the stowed launch configuration for mechanical tests and in operational mode for TVAC/EMC. Pre/post-test functional and optical-boresight checks are performed.
* **Required GSE**:
  * **EGSE**: EGSE-01 (spacecraft power/umbilical simulator); EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: MGSE-03 (three-axis shaker table with slip table and accelerometer array); MGSE-04 (acoustic reverberation chamber); MGSE-05 (thermal-vacuum (TVAC) chamber with solar simulator and shrouds); MGSE-06 (modal-survey fixture and suspension system)
  * **OGSE**: OGSE-08 (wavefront sensor, autocollimator and optical alignment targets)
* **Environment & Execution Constraints**: Three-axis sine 5–100 Hz and random 20–2,000 Hz at qualification levels; acoustic 138–142 dB OASPL; shock SRS 1,500–2,000 g above 1,000 Hz; TVAC ≤1e-5 mbar with hot/cold plateaus; EMC chamber per ECSS-E-ST-10-03C.
* **Verification Pass/Fail Criteria**: All QM/PFM units and all 72 SATL FM plus 6 SATG FM units pass the specified vibration, shock, acoustic, TVAC and EMC acceptance/qualification tests per ECSS-E-ST-10-03C. No degradation of function, alignment or structural integrity occurs; pre/post-test boresight and radiometric checks remain within tolerance.

### Requirement Verification: SSEG-REQ-VER-004 - End-to-End Operational Validation Exercises

* **Requirement Text**: "During In-Orbit Commissioning and periodic operational readiness exercises, SSEG and the Ground Segment shall execute end-to-end validation trials using cooperative calibration targets and injected or live rocket-launch signatures to demonstrate compliance with the ≤ 60.0 s total warning latency (R-011), P_d &gt; 95.0% (R-010), and &gt; 99.9% availability (R-015)."
* **Verification Method**: Test (T)
* **Applicable Model & Phase**: FM, Phase 3 and Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: During in-orbit commissioning and periodic readiness exercises, the FM constellation and Ground Segment execute end-to-end trials with cooperative calibration targets and injected or live rocket-launch signatures. The full warning chain from T0 to national-authority delivery is timed, and Pd/availability are recorded.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-03 (network data interface unit (NDIU)); EGSE-05 (spacecraft Suitcase Model / dynamics simulator); EGSE-08 (RF link emulator, channel simulator and spectrum analyser)
  * **MGSE**: None required for this verification.
  * **OGSE**: OGSE-01 (calibrated blackbody source (280-1,200 K)); OGSE-02 (IR collimator); OGSE-04 (IR target/scene projector)
* **Environment & Execution Constraints**: Phase 3/4 operational environment; cooperative targets and injected signatures; live ground-station and mission-control configuration; continuous operations.
* **Verification Pass/Fail Criteria**: The end-to-end trial demonstrates ≤60.0 s total warning latency, Pd &gt; 95.0% and &gt; 99.9% system availability during the exercise. The warning is delivered to the authorized national-authority interface without prior operator approval.

### Requirement Verification: SSEG-REQ-VER-005 - Post-Event Archive Analysis and Algorithm Calibration

* **Requirement Text**: "The SSEG flight software and Ground Segment support tools shall support periodic ingestion and replay of archived mission event data (under R-004) to verify false-alarm reduction and update onboard plume-classification coefficients via authenticated over-the-air patches."
* **Verification Method**: Combined Test (T) and Analysis (A)
* **Applicable Model & Phase**: Analysis and test, Phase 4

#### Verification Strategy & Execution Plan:
* **Spacecraft Configuration**: Archived mission event data from the Ground Segment archive are replayed through the flight software in the SVF. False-alarm and detection statistics are recomputed, refined plume-classification coefficients are generated, authenticated and uploaded as an OTA patch, and the archive is replayed again to check for regression.
* **Required GSE**:
  * **EGSE**: EGSE-02 (CCSDS TM/TC front-end and recorder); EGSE-04 (software validation facility (SVF) / HIL test bench); EGSE-05 (spacecraft Suitcase Model / dynamics simulator)
  * **MGSE**: None required for this verification.
  * **OGSE**: OGSE-02 (IR collimator); OGSE-04 (IR target/scene projector)
* **Environment & Execution Constraints**: RF-shielded SVF laboratory; continuous power-on; archive replay at the flight-software execution rate; authenticated OTA link; no live spacecraft required.
* **Considered Assumptions**: The analysis covers the 5-year archive, all recorded event types, false-alarm statistics, radiometric look-up tables and plume-classification coefficients, EOL algorithm performance and the authenticated OTA update process.
* **Tools & Models**: Ground Segment archive analytics, statistical false-alarm/ROC analysis, MATLAB/Python classifier-refinement tools, and the SVF for OTA patch validation.
* **Test Correlation & Validation**: Archived in-orbit data are replayed through the flight software and compared with the original event classification; the refined coefficients are validated against the archive before upload.
* **Verification Pass/Fail Criteria**: Periodic archive replay demonstrates a measurable false-alarm reduction without loss of Pd. Every refined coefficient set is uploaded via an authenticated OTA patch, and the post-update replay shows no regression beyond the specified tolerance.

## 6. Compliance Summary and Closure Process

| Method set | Requirements | Closure route |
|---|---:|---|
| Test only (T) | 8 | Test report and verification certificate. |
| Test with supporting R or I | 16 | Test report plus design/inspection evidence. |
| Analysis only (A) | 8 | Analysis report, validated model and correlation report. |
| Analysis with supporting R or I | 6 | Analysis report plus design/inspection evidence. |
| Combined Test and Analysis (T, A) | 37 | Test report plus correlated analysis report. |
| Review of Design only (R) | 2 | Design review record and compliance statement. |
| **Total** | **77** | |

All entries remain **Open** at this issue. Closure requires the objective evidence defined in the detailed entries to be produced, reviewed and accepted by the verification review board.
